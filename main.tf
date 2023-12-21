
module "vpc" {
  source    =   "./Module/VPC"
  cidr_block = var.cidr_block
  name = var.name
  tenancy = var.tenancy
    
}
module "public_subnet" {
  source = "./Module/Public_Subnet"
  cidr_block_subnet = var.cidr_block_subnet
  name = var.name
  vpc_id  = module.vpc.vpcid
}

module "Public_Instance" {
  source = "./Module/Public_Instance"
  subnet_id = module.public_subnet.subnetID
  my_security_groups_id = module.Public_SG.sg_id
  ami_id = var.ami_id
  instance_type = var.instance_type
  name = var.name
}

module "Public_SG" {
  source = "./Module/Public_Security_Group"
    vpc_id  = module.vpc.vpcid 

    name = var.name

}
  
 

