#  Getting the security group id

output "sg_id" {

    value = aws_security_group.public_sg.id
  
}