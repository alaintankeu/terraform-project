
provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

# Creating VPC

resource "aws_vpc" "main" {
  cidr_block = "10.20.0.0/16"
  enable_dns_hostnames = true

    tags = {
    Name = "VPC_Testing"
  }
   
}

#  Creating vpc output
#  ///////////////////////////////////////////

output "vpc_id" {

  value = aws_vpc.main.id    
  
}

