# create EC2 Instance

resource "aws_instance" "web_server" {
    
    ami = var.ami_id
    instance_type = var.instance_type
    availability_zone = data.aws_availability_zones.az.names[0]

    subnet_id = var.subnet_id
    security_groups = ["${var.my_security_groups_id}"]

    tags = {
      "Name" = "${var.name}-instance"
    }
  
}
# AZ

data "aws_availability_zones" "az" {}



