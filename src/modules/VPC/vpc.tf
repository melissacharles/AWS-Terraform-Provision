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

#define elastic IP and NAT IPs
resource "aws_eip" "MelissaNatGatewayEIP1" {
    tags = {
      Name = "MelissaNatGateway1"
    Project = "Melissa Terraform Provision"    
    }
}
resource "aws_nat_gateway" "MelissaNatGateway1" {
    allocation_id = aws_eip.MelissaNatGatewayEIP1.id
    subnet_id = aws_subnet.MelissaPublicSubnet1.id
    tags = {
      Name = "MelissaNatGateway1"
      Project = "Melissa Terraform Provision"    
    }
}

#Define Subnet in AWS for Public Subnet 1
resource "aws_subnet" "MelissaPublicSubnet1" {
    vpc_id = aws_vpc.MelissaVPC.id
    cidr_block = var.public_subnet_cidrs[0]
    availability_zone = var.availability_zones[0]
    tags = {
        Name = "MelissaPublicSubnet1"
        Project = "Melissa Terraform Provision"    
    }
}

#Define NatGatewayEIP2 and NatGateway2
resource "aws_eip" "MelissaNatGatewayEIP2" {
    tags = {
      Name = "MelissaNatGatewayEIP2"
      Project = "Melissa Terraform Provision"    
    }
}
resource "aws_nat_gateway" "MelissaNatGateway2" {
    allocation_id = aws_eip.MelissaNatGatewayEIP2.id
    subnet_id = aws_subnet.MelissaPublicSubnet1.id
    tags = {
        Name = "MelissaNatGateway2"
        Project = "Melissa Terraform Provision"    
    } 
}

#define subnet for Public Subnet 2
resource "aws_subnet" "MelissaPublicSubnet2" {
    vpc_id = aws_vpc.MelissaVPC.id
    cidr_block = var.public_subnet_cidrs[1]
    availability_zone = var.availability_zones[1]
    tags = {
        Name = "MelissaPublicSubnet2"
        Project = "Melissa Terraform Provision"    
    }
}

#define subnet for Private Subnet 1 and 2
resource "aws_subnet" "MelissaPrivateSubnet1" {
  vpc_id            = aws_vpc.MelissaVPC.id
  cidr_block        = var.private_subnet_cidrs[0]
  availability_zone = var.availability_zones[0]
  tags = {
    Name    = "MelissaPrivateSubnet1"
    Project = "Melissa Terraform Provision"
  }
}
resource "aws_subnet" "MelissaPrivateSubnet2" {
  vpc_id            = aws_vpc.MelissaVPC.id
  cidr_block        = var.private_subnet_cidrs[1]
  availability_zone = var.availability_zones[1]
  tags = {
    Name    = "MelissaPrivateSubnet2"
    Project = "Melissa Terraform Provision"
  }
}

#Add AWS Route Tables for Public Route table, Private RT 1 and Private RT 2
resource "aws_route_table" "MelissaPublicRT" {
  vpc_id = aws_vpc.MelissaVPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.MelissaIGW.id
  }
  tags = {
    Name    = "MelissaPublicRT"
    Project = "Melissa Terraform Provision"
    }
}
resource "aws_route_table" "MelissaPrivateRT1" {
  vpc_id = aws_vpc.MelissaVPC.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.MelissaNatGateway1.id
  }
  tags = {
    Name    = "MelissaPrivateRT1"
    Project = "Melissa Terraform Provision"
    }
}
resource "aws_route_table" "MelissaPrivateRT2" {
  vpc_id = aws_vpc.MelissaVPC.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.MelissaNatGateway2.id
  }
  tags = {
    Name    = "MelissaPrivateRT2"
    Project = "Melissa Terraform Provision"  
    }
}

#Add route table associations to public and private subnets
resource "aws_route_table_association" "MelissaPublicRTassociation1" {
  subnet_id      = aws_subnet.MelissaPublicSubnet1.id
  route_table_id = aws_route_table.MelissaPublicRT.id
}
resource "aws_route_table_association" "MelissaPublicRTassociation2" {
  subnet_id      = aws_subnet.MelissaPublicSubnet2.id
  route_table_id = aws_route_table.MelissaPublicRT.id
}
resource "aws_route_table_association" "MelissaPrivateRTassociation1" {
  subnet_id      = aws_subnet.MelissaPrivateSubnet1.id
  route_table_id = aws_route_table.MelissaPrivateRT1.id
}
resource "aws_route_table_association" "MelissaPrivateRTassociation2" {
  subnet_id      = aws_subnet.MelissaPrivateSubnet2.id
  route_table_id = aws_route_table.MelissaPrivateRT2.id
}