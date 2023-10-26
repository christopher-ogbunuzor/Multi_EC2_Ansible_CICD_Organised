# These are the 3 vpc interface endpts required for connecting to ssm
locals {
  endpoints = {
    "endpoint-ssm" = {
      name = "ssm"
    },
    "endpoint-ssmm-essages" = {
      name = "ssmmessages"
    },
    "endpoint-ec2-messages" = {
      name = "ec2messages"
    }
  }
}

resource "aws_vpc_endpoint" "endpoints" {
  vpc_id            = module.network.my_vpc_id
  for_each          = local.endpoints
  vpc_endpoint_type = "Interface"
  service_name      = "com.amazonaws.${var.region}.${each.value.name}"
  subnet_ids          = [module.network.private_subnet_a_id]
  private_dns_enabled = true
  # Add a security group to the VPC endpoint
  security_group_ids = [aws_security_group.vpc_endpoint_security_group.id]
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = module.network.my_vpc_id
  service_name = "com.amazonaws.${var.region}.s3"
  
}
resource "aws_vpc_endpoint" "gw_endpoint" {
    vpc_endpoint_type = "Gateway"
    vpc_id = module.network.my_vpc_id
    service_name = "com.amazonaws.${var.region}.s3"
    route_table_ids = [module.network.private_to_public_subnet_rt_id]
    private_dns_enabled = false

    tags = {
        Name = "s3_gateway_end_point"
    }
}

# associate route table with VPC endpoint NO LOGER NEEDED DUE TO USING INLINE LINE 36
# resource "aws_vpc_endpoint_route_table_association" "route_table_association" {
#   route_table_id  = module.network.private_to_public_subnet_rt_id
#   vpc_endpoint_id = aws_vpc_endpoint.s3.id
# }

# ======== NO LONGER NEEDED ===============
  #shows how to use for_each

# resource "aws_vpc_endpoint_route_table_association" "privatesubnetRT_Assoc" {
#   for_each          = local.endpoints
#   route_table_id  = module.network.private_to_public_subnet_rt_id
#   vpc_endpoint_id = aws_vpc_endpoint.endpoints[each.key].id
# }
# resource "aws_vpc_endpoint_route_table_association" "privatesubnetRT_Assoc" {
#   for_each          = local.endpoints
#   route_table_id  = module.network.private_to_public_subnet_rt_id
#   vpc_endpoint_id = aws_vpc_endpoint.endpoints[each.key].id
# }
