# EC2 - IN PUBLIC SUBNET
resource "aws_instance" "my_public_server" {
  count         = 1
  ami           = data.aws_ami.amazon_linux_2_ssm.id
  instance_type = var.instance_type

  # no need to specify keyname as we using ssm
  # key_name               = var.keypair_name

  # use public subnet

  subnet_id = module.network.public_subnet_a_id

  vpc_security_group_ids = [
    aws_security_group.my_app_sg.id
  ]
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

  tags = {
    Name = "Public Server"
    Schedule = "custom_schedule"
  }

}

# EC2 - IN PRIVATE SUBNET
resource "aws_instance" "my_private_server" {
  count = 1
  ami   = "ami-0f882ee54d426dce2"

  # ami                    = data.aws_ami.amazon_linux_2_ssm.id
  instance_type = var.instance_type

  # no need to specify keyname as we using ssm
  # key_name               = var.keypair_name

  # use private subnet
  subnet_id = module.network.private_subnet_a_id


  vpc_security_group_ids = [
    aws_security_group.my_app_sg.id
  ]
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

  tags = {
    Name = "Private Server"
    Schedule = "custom_schedule"
  }

}