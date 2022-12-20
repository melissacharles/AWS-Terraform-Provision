resource "aws_vpc" "MelissaVPC" {
    cidr_block = var.vpc_cidr
    instance_tenancy = "default"
    tags = {
        Name = "MelissaVPC"
        Project = "Melissa Terraform Provision"
    }
}

#define internet gateway
resource "aws_internet_gateway" "MelissaIGW" {
  vpc_id = aws_vpc.MelissaVPC.id
  tags = {
    Name = "MelissaIGW"
    Project = "Melissa Terraform Provision"
  }
}