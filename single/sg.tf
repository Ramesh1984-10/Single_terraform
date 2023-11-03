# // Create Security Group for Baiston Host 

resource "aws_security_group" "baiston-security-group" {
  vpc_id = aws_vpc.main.id

  dynamic "ingress" {
    for_each = var.baiston_dynamic_sg.ingress_rules
    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      cidr_blocks = [var.public_rt_cidr]


    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.public_rt_cidr]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = var.Baiston_SG_Name
  }
}




# resource "aws_security_group" "private-security-group" {
#   name        = "Private Security Group"
#   description = "Enable SSH access on Port 22"
#   vpc_id      = aws_vpc.main.id
#   dynamic "ingress" {
#     for_each = var.App_dynamic_sg.ingress_rules
#     content {
#       description = "SSH Access"
#       from_port   = ingress.value.port
#       to_port     = ingress.value.port
#       protocol    = ingress.value.protocol
#       #cidr_blocks = [var.public_rt_cidr]
#       security_groups = [aws_security_group.Alb-security-group.id]
#     }
#   }
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = [var.public_rt_cidr]
#   }
#   tags = {
#     Name = var.Private_SG_Name

#   }
# }

# resource "aws_security_group" "Alb-security-group" {
#   name        = "ALB  Security Group"
#   description = "Enable http/https access on Port 80/443"
#   vpc_id      = aws_vpc.main.id
#   dynamic "ingress" {
#     for_each = var.ALB_dynamic_sg.ingress_rules
#     content {
#       description = "SSH Access"
#       from_port   = ingress.value.port
#       to_port     = ingress.value.port
#       protocol    = ingress.value.protocol
#       cidr_blocks = [var.public_rt_cidr]
#     }
#   }
#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = [var.public_rt_cidr]
#   }
#   tags = {
#     Name = var.ALB_SG_Name

#   }
# }
