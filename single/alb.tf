# # Create an Application Load Balancer


# resource "aws_lb" "app" {
#   name               = var.lb_app_name
#   internal           = false
#   load_balancer_type = var.lb_type
#   security_groups    = [aws_security_group.Alb-security-group.id]
#   subnets            = keys({ for net in aws_subnet.private_subnets : net.id => net.id })

#   tags = {
#     Terraform   = "true"
#     Environment = "dev"
#   }
# }


# # Create Three Target Groups


# resource "aws_lb_target_group" "lendingplate-com" {
#   name     = var.lb_target_group_lending-com
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.main.id

# }




# resource "aws_lb_target_group" "unifinz-in" {
#   name     = "unifinz-in"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.main.id

# }

# resource "aws_lb_target_group" "lms-lendingpalte" {
#   name     = "lms-lendingplate"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.main.id

# }







# # Create a listener for the ALB with host-based routing





# resource "aws_lb_listener" "lending" {
#   load_balancer_arn = aws_lb.app.arn
#   port              = 80
#   protocol          = "HTTP"

#   default_action {
#     type = "forward"
#     target_group_arn = aws_lb_target_group.lendingplate-com.arn
    
#   }
# }


# resource "aws_lb_listener_rule" "lendingpalte-com_rule" {
#   listener_arn = aws_lb_listener.lending.arn
#   priority     = 100
#   action {
#     type = "forward"
#     target_group_arn = aws_lb_target_group.lendingplate-com.arn
#     fixed_response {
#       content_type = "text/plain"
#       status_code = "200"
#       #content = "Host lendingpalte.com"
#     }

#   }

#   condition {
#     host_header {
#           values =["lendingplate.com"]
#         }
#   }
# }





# resource "aws_lb_listener" "unifinz-in" {
#   load_balancer_arn = aws_lb.app.arn
#   port              = 80
#   protocol          = "HTTP"

#   default_action {
#     type = "forward"
#     target_group_arn = aws_lb_target_group.unifinz-in.arn
    
#   }
# }



# resource "aws_lb_listener_rule" "unifinz-in_rule" {
#   listener_arn = aws_lb_listener.unifinz-in.arn
#   priority     = 100
#   action {
#     type = "forward"
#     target_group_arn = aws_lb_target_group.unifinz-in.arn
#     fixed_response {
#       content_type = "text/plain"
#       status_code = "200"
#       #content = "Host lendingpalte.com"
#     }

#   }

#   condition {
#     host_header {
#           values =["http://unifinz.in"]
#         }
#   }
# }



# resource "aws_lb_listener" "lms-lendingplate-co-in" {
#   load_balancer_arn = aws_lb.app.arn
#   port              = 80
#   protocol          = "HTTP"

#   default_action {
#     type = "forward"
#     target_group_arn = aws_lb_target_group.lms-lendingpalte.arn
    
#   }
# }


# resource "aws_lb_listener_rule" "lms-lending-co-in_rule" {
#   listener_arn = aws_lb_listener.lms-lendingplate-co-in.arn
#   priority     = 100
#   action {
#     type = "forward"
#     target_group_arn = aws_lb_target_group.lms-lendingpalte.arn
#     fixed_response {
#       content_type = "text/plain"
#       status_code = "200"
#       #content = "Host lendingpalte.com"
#     }

#   }

#   condition {
#     host_header {
#           values =["http://lms.lendingplate.co.in"]
#         }
#   }
# }



