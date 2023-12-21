# Internet Gateway
resource "aws_internet_gateway" "igw" {
vpc_id  = var.vpc_id

tags = {
  "Name" = "${var.name}-igw"
}
}

# AZ

data "aws_availability_zones" "az" {}

# AWS Public Subnet

resource "aws_subnet" "public_subnet" {
  
vpc_id  = var.vpc_id
cidr_block  = var.cidr_block_subnet
availability_zone = data.aws_availability_zones.az.names[0]
map_public_ip_on_launch = true

tags = {
  "Name" = "${var.name}-subnet"
}
}

# aws route table

resource "aws_route_table" "public_route_table" {
  
vpc_id  = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

# associate public subnet to route table

resource "aws_route_table_association" "pub_association" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}