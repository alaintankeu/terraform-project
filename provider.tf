provider "aws" {
    region = var.region
    profile = "default"
      
}

terraform {
  backend "s3" {
    bucket = "tf-state-twwebservice"
    region = "us-east-1"
    key = "stg/terraform.tfstate"
    profile = "default"
  }
}