
terraform {
# Run init/plan/apply with "backend" commented-out (uses local backend) to provision Resources (Bucket, Table)
# Then uncomment "backend" and run command init, apply after resources have been created (this uses AWS)
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