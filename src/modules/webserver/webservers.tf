resource "aws_security_group" "MelissaWebserverSecurityGroup" {
  name = "allow_ssh_http"
  description = "Allow ssh http inbound traffic"
  vpc_id = var.melissa_vpc_id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
        from_port = ingress.value["port"]
        to_port = ingress.value["port"]
        protocol = ingress.value["proto"]
        cidr_blocks = ingress.value["cidr_blocks"]
    }
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "MelissaWebserverSecurityGroup"
    Project = "Melissa Terraform Provision"
  }
}

