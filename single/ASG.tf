
# resource "aws_launch_template" "lending-1" {
#   name                   = "lendingplate.com-terra"
#   image_id               = "ami-0e8108b9614d4eb27"
#   instance_type          = "t2.micro"
#   vpc_security_group_ids = [aws_security_group.private-security-group.id]
#   key_name               = aws_key_pair.Public_key.id
#   lifecycle {
#     create_before_destroy = true
#   }

# }

# resource "aws_launch_template" "Unifinz-in" {
#   name                   = "Unifinz.in"
#   image_id               = "ami-0f4efe77a3e80f84e"
#   instance_type          = "t2.micro"
#   vpc_security_group_ids = [aws_security_group.private-security-group.id]
#   key_name               = aws_key_pair.Public_key.id
#   lifecycle {
#     create_before_destroy = true
#   }
# }


# resource "aws_launch_template" "lms-lending" {
#   name                   = "qa-lms.lendingplate.co.in-terra"
#   image_id               = "ami-0f8463d2b460ec3bb"
#   instance_type          = "t2.small"
#   vpc_security_group_ids = [aws_security_group.private-security-group.id]
#   key_name               = aws_key_pair.Public_key.id
#   lifecycle {
#     create_before_destroy = true
#   }

# }



###############################################################################




#Creation Of Auto Scaling group

# resource "aws_autoscaling_group" "my-asg-1" {
#   name                = "lendingplate.com-ASG"
#   vpc_zone_identifier = keys({ for net in aws_subnet.private_subnets : net.id => net.id })
#   desired_capacity    = 1
#   max_size            = 1
#   min_size            = 1
#   force_delete        = true
#   health_check_type   = "ELB"
#   target_group_arns   = [aws_lb_target_group.lendingplate-com.arn]


#   mixed_instances_policy {
#     launch_template {
#       launch_template_specification {
#         launch_template_id = aws_launch_template.lending-1.id
#         version            = "$Latest"
#       }
#     }
#   }
#   tag {
#     key                 = "Name"
#     value               = "frontend"
#     propagate_at_launch = true
#   }
# }



# resource "aws_autoscaling_group" "my-asg-2" {
#   name                = "Unifinz.in-ASG"
#   vpc_zone_identifier = keys({ for net in aws_subnet.private_subnets : net.id => net.id })
#   desired_capacity    = 1
#   max_size            = 1
#   min_size            = 1
#   force_delete        = true
#   health_check_type   = "ELB"

#   mixed_instances_policy {
#     launch_template {
#       launch_template_specification {
#         launch_template_id = aws_launch_template.Unifinz-in.id
#         version            = "$Latest"
#       }
#     }
#   }
# }




# resource "aws_autoscaling_group" "my-asg-3" {
#   name                = "QA-lendingplate.com-ASG"
#   vpc_zone_identifier = keys({ for net in aws_subnet.private_subnets : net.id => net.id })
#   desired_capacity    = 1
#   max_size            = 1
#   min_size            = 1
#   force_delete        = true
#   health_check_type   = "ELB"

#   mixed_instances_policy {
#     launch_template {
#       launch_template_specification {
#         launch_template_id = aws_launch_template.lms-lending.id
#         version            = "$Latest"
#       }
#     }
#   }
# }





#   provisioner "file" {
#     source      = "./${var.key_name1}"  
#     destination = "/home/ubuntu/${var.key_name1}"

#   }
#   provisioner "remote-exec" {
#     inline = ["chmod 400 ~/${var.key_name1}", "sudo mkdir /tmp/ramesh"]
#   }
# }  

#   }
#   lifecycle {
#     create_before_destroy = true
#   }
#   tags = {
#     "Name" = "Bastion-Host"
#   }











//Create a new EC2 launch configuration in Private subnet

# resource "aws_instance" "App_private-ec2" {
#   ami                    = data.aws_ami.Latest_Image.id
#   key_name               = var.key_name
#   instance_type          = var.instance_t
#   count = length(var.server_tag)

#   subnet_id              = var.private_sub_id
#   //subnet_id     = aws_subnet.private[count.index % length(aws_subnet.private)].id
#   vpc_security_group_ids = [var.private_security_group]

#   tags = {
#      Name =  var.server_tag[keys(var.server_tag)[count.index]]
#   }
# }



# resource "aws_instance" "Db_private-ec2" {
#   ami                    = data.aws_ami.amzlinux2.id
#   key_name               = var.key_name
#   instance_type          = var.instance_t
#   subnet_id              = aws_subnet.App2_private_ap_south_1b.id
#   vpc_security_group_ids = [aws_security_group.frontend-SG.id]
#   lifecycle {
#     create_before_destroy = true
#   }
#   tags = {
#      Name = "DB_instance"
#   }