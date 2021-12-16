output "ec2_instance_ip" {
 value       = join(" ", aws_instance.my_public_server.*.public_ip)
  
}

# output "ec2_instance_ip2" {
#  value = aws_instance.my_public_server.public_ip
#   # value = aws_instance.my
# }