output "ec2_instance_ip" {
  value = join(" ", aws_instance.my_public_server.*.public_ip)
}

output "CFN_Instanc_Scheduler_Token" {
  value = aws_cloudformation_stack.network.outputs.ServiceInstanceScheduleServiceToken
}

# output "ec2_instance_ip2" {
#  value = aws_instance.my_public_server.public_ip
#   # value = aws_instance.my
# }