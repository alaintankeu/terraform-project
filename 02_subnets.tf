data "aws_availability_zones" "available" {}

resource "aws_subnet" "public_subnet" {

  count = "${length(data.aws_availability_zones.available.names)-4}"

  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "10.20.${10+count.index}.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet_0${1+count.index}"
  }
  
}
resource "aws_subnet" "private_subnet" {

  count = "${length(data.aws_availability_zones.available.names)-4}"
  vpc_id = "${aws_vpc.main.id}"
  cidr_block = "10.20.${20+count.index}.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  map_public_ip_on_launch = false

    tags = {
    Name = "private_subnet_0${1+count.index}"
  }
 
}


# Creating subnets resource output.
#  ////////////////////////////////////////////

output "private_subnets" {
  description = "The IDs of the private subnets as list"
  value       = ["${aws_subnet.private_subnet.*.id}"]
}

output "public_subnets" {
  description = "The IDs of the public subnets as list"
  value       = ["${aws_subnet.public_subnet.*.id}"]
}
 
