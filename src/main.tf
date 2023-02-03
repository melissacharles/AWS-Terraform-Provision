
terraform {
    backend "s3" {
    bucket         = "cc-tf-state-backend"
    key            = "tf-infra/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true
  }

  required_version = ">=0.13.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "tf-state" {
  source      = "./modules/tf-state"
  bucket_name = "cc-tf-state-backend"
}

module "vpc-infra" {
  source = "./modules/VPC"
  
#VPC Input Vars
  vpc_cidr             = local.vpc_cidr
  availability_zones   = local.availability_zones
  public_subnet_cidrs  = local.public_subnet_cidrs
  private_subnet_cidrs = local.private_subnet_cidrs
}
module "db-infra" {
  source = "./modules/db"

#RDS Input Vars
melissa_vpc_id = module.vpc-infra.melissa_vpc_id
melissa_private_subnets = module.vpc-infra.melissa_private_subnets
melissa_private_subnet_cidrs = local.private_subnet_cidrs

db_az = local.availability_zones[0]
db_name = "MelissaDatabaseInstance"
db_user_name = var.db_user_name
db_user_password = var.db_user_password
}