
# output "vpc" {
#   value = aws_vpc.main.id
# }




# output "Private_subnets" {
#   #value = [ for vnet in aws_subnet.private_subnets: vnet.id]
#   value = keys({for net in aws_subnet.private_subnets: net.id => net.id})
# }



# output "security_group" {
#   value = aws_security_group.ssh-security-group.id
# }

# output "private_security_group" {
#   value = aws_security_group.private-security-group.id

# }


# output "Alb_security_group" {
#   value = aws_security_group.Alb-security-group.id
# }