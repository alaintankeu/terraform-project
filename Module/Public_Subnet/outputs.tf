# getting the subnet id
output "subnetID" {
    value = aws_subnet.public_subnet.id
  
}