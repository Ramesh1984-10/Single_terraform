resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  #instance_tenancy     = var.tenancy
  enable_dns_hostnames = true
  tags = {
    "Name" = "${var.ENV_Name}-${var.vpc_name}"
  }
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.main.id

  tags = {
    "Name" = "${var.ENV_Name}-${var.Igw_name}"

  }

}


// Public Subnet Creation



resource "aws_subnet" "public_subnets" {
  for_each = var.public_subnet_config

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  map_public_ip_on_launch = true

  tags = {
    Name = "${var.ENV_Name}-${each.key}"
  }
}


resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.ENV_Name}-Public_route_table"
  }

}



resource "aws_route" "public_route" {
  for_each = aws_subnet.public_subnets

  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.IGW.id

  depends_on = [aws_subnet.public_subnets]

}




resource "aws_route_table_association" "public_association" {
  for_each = aws_subnet.public_subnets

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_route_table.id
}


// Private Subnet Creation


resource "aws_subnet" "private_subnets" {
  for_each = var.private_subnet_config

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = {
    Name = "${var.ENV_Name}-${each.key}"
  }
}


resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.ENV_Name}-Private_route_table"
  }

}



resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0" #var.public_rt_cidr
  nat_gateway_id         = aws_nat_gateway.nat.id
}




resource "aws_route_table_association" "private_association" {
  for_each       = aws_subnet.private_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_route_table.id
}



############################################################

# DataBase Subnet Creation

resource "aws_subnet" "db_subnets" {
  for_each = var.db_subnet_config

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = {
    Name = "${var.ENV_Name}-${each.key}"
  }
}


resource "aws_route_table" "db_route_table" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.ENV_Name}-db_route_table"
  }

}



resource "aws_route" "db_route" {
  route_table_id         = aws_route_table.db_route_table.id
  destination_cidr_block = "0.0.0.0/0" #var.public_rt_cidr
  nat_gateway_id         = aws_nat_gateway.nat.id
}




resource "aws_route_table_association" "db_association" {
  for_each       = aws_subnet.db_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.db_route_table.id
}



#Creating EIP
resource "aws_eip" "elasticip" {
  domain = "vpc"

  tags = {
    Name = "Lending-elastic"
  }
}


#Attach Nat Gateway with 1st Public Subnet


#Creating NAT Gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.elasticip.id
  subnet_id     = aws_subnet.public_subnets["Public_subnet1"].id

  tags = {
    Name = var.Nat_Gateway
  }
}



#################################################################


// Dynamically created SSH key pair

resource "tls_private_key" "legalityassociates" {
  algorithm = "RSA"
}

resource "aws_key_pair" "Public_key" {
  key_name   = var.key_name
  public_key = tls_private_key.legalityassociates.public_key_openssh
}

resource "local_file" "TF_key" {
  content = tls_private_key.legalityassociates.private_key_pem
  #sensitive_content = tls_private_key.key.private_key_pem
  filename = "legalityassociates.pem"
  file_permission = "0400"
}




####################################EC2##############



// Create a new EC2 launch configuration in PUBLIC subnet

resource "aws_instance" "public-ec2" {
 # ami                         = "ami-0a7cf821b91bcccbc"
  ami                         = data.aws_ami.Latest_Image.id
  key_name                    = aws_key_pair.Public_key.key_name
  instance_type               = var.instance_t
  associate_public_ip_address = var.associate_public_ip
  subnet_id     =  aws_subnet.public_subnets["Public_subnet1"].id
  vpc_security_group_ids = [aws_security_group.baiston-security-group.id]
  tags = {
    Name = "Baiston-ec2"
  }

}

# provisioner "file" {
#   source      = "./${var.key_name1}"  
#   destination = "/home/ubuntu/${var.key_name1}"

#   }
# provisioner "remote-exec" {
#   inline = ["chmod 400 ~/${var.key_name1}", "sudo mkdir /tmp/ramesh"]
#   }
  
#   lifecycle {
#     create_before_destroy = true
#   }
#   tags = {
#     "Name" = "Bastion-Host"
#   }


