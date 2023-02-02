resource "aws_db_subnet_group" "MelissaDBSubnetGroup" {
  name = "melissa-db-subnet-group"
  subnet_ids = [ 
    var.melissa_private_subnets[0].id,
    var.melissa_private_subnets[1].id
   ]
   tags = {
     Name = "MelissaDBSubnetGroup"
     Project = "Melissa Terraform Provision"
   }
}

resource "aws_security_group" "MelissaDBSubnetGroup" {
  name = "melissa-db-security-group"
  vpc_id = var.melissa_vpc_id

  ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    cidr_blocks = [
        var.melissa_private_subnet_cidrs[0],
        var.melissa_private_subnet_cidrs[1]
    ]
  }
  tags = {
    Name = "MelissaDBSecurityGroup"
    Project = "Melissa Terraform Provision"
  }
}