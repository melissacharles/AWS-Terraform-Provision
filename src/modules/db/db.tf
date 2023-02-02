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