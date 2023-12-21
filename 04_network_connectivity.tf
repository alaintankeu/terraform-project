
# Creating internet gateway resource
# ////////////////////////////////////////////

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "internet_gateway"
  }
}

# Creating nat gateway resource
# ////////////////////////////////////////////

resource "aws_eip" "elastic_nat" { 
 domain = "vpc" 
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.elastic_nat.id
  subnet_id     = aws_subnet.public_subnet[0].id

  tags = {
    Name = "gw_NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]
}


#  Creating a public route table in order to route the traffic inside public 
#  subnet to igw and associate public route table with public subnet.
# //////////////////////////////////////////////////////////////////////

resource "aws_route_table" "Public_rt_table" {

  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "Public_rt_table"
  }
}

resource "aws_route_table_association" "public_rt_association" {
  
  for_each = toset(["0","1"])
  subnet_id = aws_subnet.public_subnet[each.key].id
  route_table_id = aws_route_table.Public_rt_table.id

}

#  Creating a private route table in order to route the traffic inside private 
#  subnet to nat and associate private route table with private subnet.
# //////////////////////////////////////////////////////////////////////

resource "aws_route_table" "Private_rt_table" {

  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gw.id
  }
  tags = {
    Name = "Private_rt_table"
  }
}

resource "aws_route_table_association" "private_rt_association" {
  
  for_each = toset(["0","1"])
  subnet_id = aws_subnet.private_subnet[each.key].id
  route_table_id = aws_route_table.Private_rt_table.id

}