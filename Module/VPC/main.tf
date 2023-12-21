# Create VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block
  instance_tenancy = var.tenancy
  enable_dns_hostnames = true
  tags = {
    "Name"  = "${var.name}-vpc"
}
}


