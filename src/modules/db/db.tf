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

resource "aws_db_instance" "melissaRDS" {
    availability_zone = var.db_az
    db_subnet_group_name = aws_db_subnet_group.MelissaDBSubnetGroup.name
    vpc_security_group_ids = [aws_security_group.MelissaDBSecurityGroup.id]
    allocated_storage = 20
    storage_type = "standard"
    engine = "postgres"
    engine_version = "12"
    instance_class = "db.t2.micro"
    name = var.db_name
    username = var.db_user_name
    password = var.db_user_password
    skip_final_snapshot = true 
    tags = {
      Name = "MelissaRDS"
      Project = "Melissa Terraform Provision"    
    }
}