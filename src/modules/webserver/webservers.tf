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

resource "aws_lb" "MelissaLoadBalancer" {
    name = "web-app-lb"
    load_balancer_type = "application"
    subnets = [var.melissa_public_subnets[0].id, var.cc_public_subnets[1].id]
    security_groups = [aws_security_group.MelissaWebserverSecurityGroup.id]
    tags = {
      Name = "MelissaLoadBalancer"
      Project = "Melissa Terraform Provision"
    }
}

resource "aws_lb_listener" "MelissaLBListerner" {
    load_balancer_arn = aws_lb.MelissaLoadBalancer.arn

    port = 80
    protocol = "HTTP"

    default_action {
      target_group_arn = aws_lb_target_group.ccTargetGroup.id
      type = "forward"
    }
}

resource "aws_lb_target_group" "MelissaTargetGroup" {
  name = "terra-target-group"
  port = 80
  protocol = "HTTP"
  vpc_id = var.melissa_vpc_id

  health_check {
    path = "/"
    protocol = "HTTP"
    matcher = "200"
    interval = 15
    timeout = 3
    healthy_threshold = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "MelissaTargetGroup"
    Project = "Melissa Terraform Provision"
  }
}

resource "aws_lb_target_group_attachment" "webserver1" {
  target_group_arn = aws_lb_target_group.MelissaTargetGroup.arn
  target_id = aws_instance.webserver1.id
  port = 80
}

resource "aws_lb_target_group_attachment" "webserver2" {
  target_group_arn = aws_lb_target_group.MelissaTargetGroup.arn
  target_id = aws_instance.webserver2.id
  port = 80
}