resource "aws_security_group" "my_app_sg" {
  name        = "my_app_sg"
  description = "Allow access to my Server"
  vpc_id      = module.network.my_vpc_id

  # INBOUND RULES
  ingress {
    description = "SSH from my mac and the world"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["86.15.241.215/32", "0.0.0.0/0"]
  }

  ingress {
    description = "SSH from my VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["192.168.0.0/16"]
  }

  ingress {
    description = "http from the world"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "https from the world"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow access to the world"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my_app_sg"
  }
}

data "aws_ami" "my_aws_ami" {
    owners = ["099720109477"]
    most_recent = true
    filter {
        name = "name"
        values = [ "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*" ]
    }
}

# EC2 - PUBLIC
resource "aws_instance" "my_public_server" {
    count = 5
    ami = data.aws_ami.my_aws_ami.id
    instance_type = var.instance_type
    key_name = var.keypair_name
    subnet_id = module.network.public_subnet_a_id
    vpc_security_group_ids = [ aws_security_group.my_app_sg.id ]
}