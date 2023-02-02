output "melissa_vpc_id" {
  description = "VPC Id"
  value       = aws_vpc.MelissaVPC.id
}

output "melissa_public_subnets" {
  description = "Will be used by Web Server Module to set subnet_ids"
  value = [
    aws_subnet.MelissaPublicSubnet1,
    aws_subnet.MelissaPublicSubnet2
  ]
}

output "melissa_private_subnets" {
  description = "Will be used by RDS Module to set subnet_ids"
  value = [
    aws_subnet.MelissaPrivateSubnet1,
    aws_subnet.MelissaPrivateSubnet2
  ]
}