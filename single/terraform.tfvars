vpc_cidr        = "10.0.0.0/16"
tenancy         = "default"
vpc_name        = "VPC"
Igw_name        = "Internet_Gateway"
elastic         = "Elastic-Ip"
public_rt_cidr  = "0.0.0.0/0"
Nat_Gateway     = "Lending-Nat"
Baiston_SG_Name = "Baiston_Security_Group"
Private_SG_Name = "Private_Security_Group"
ALB_SG_Name     = "ALB_Security_Group"
ENV_Name        = "Lending-Prod"
instance_t      = "t2.micro"
key_name        = "legalityassociates"

public_subnet_config = {
  "Public_subnet1" = {
    cidr_block        = "10.0.1.0/24"
    availability_zone = "ap-south-1a"
  }
  "Public_subnet2" = {
    cidr_block        = "10.0.2.0/24"
    availability_zone = "ap-south-1b"
  }
}

private_subnet_config = {
  "Application_subnet-1" = {
    cidr_block        = "10.0.50.0/24"
    availability_zone = "ap-south-1a"
  }
  "Application_subnet-2" = {
    cidr_block        = "10.0.51.0/24"
    availability_zone = "ap-south-1b"
  }
}


db_subnet_config = {
  "Data_Base_subnet" = {
    cidr_block        = "10.0.151.0/24"
    availability_zone = "ap-south-1a"
  }
}

baiston_dynamic_sg = {
  ingress_rules = [{
    port     = 22
    protocol = "tcp"
    },
    {
      port     = 80
      protocol = "tcp"
    },
    {
      port     = 443
      protocol = "tcp"

  }]
}


App_dynamic_sg = {
  ingress_rules = [{
    port     = 22
    protocol = "tcp"
    },
    {
      port     = 80
      protocol = "tcp"
  }]
}



ALB_dynamic_sg = {
  ingress_rules = [{
    port     = 80
    protocol = "tcp"
    },
    {
      port     = 443
      protocol = "tcp"

  }]
}


