variable "vpc_cidr" {
  description = "main vpc cidr"
  default     = ""
}


variable "tenancy" {
  default = ""
}

variable "vpc_name" {
  type    = string
  default = ""

}

variable "Igw_name" {
  type    = string
  default = ""

}


variable "elastic" {
  type    = string
  default = ""

}

variable "Nat_Gateway" {
  type    = string
  default = ""

}



variable "public_rt_cidr" {
  type        = string
  description = "private route table cidr and nat gateway"
  default     = ""
}



variable "ports" {
  default = ""


}


#######################################


variable "public_subnet_config" {
  description = "Configuration for public subnets"
  type        = map(any)
}


variable "private_subnet_config" {
  description = "Configuration for public subnets"
  type        = map(any)
}

variable "db_subnet_config" {
  description = "Configuration for public subnets"
  type        = map(any)
}




variable "Baiston_SG_Name" {
  description = "Name of Bastion security Group"

}


variable "Private_SG_Name" {
  description = "Name of Private security Group"

}

variable "ALB_SG_Name" {
  description = "Name of ALB security Group"

}


variable "ENV_Name" {
  description = "Name of the Environmet"

}




#####################################

variable "baiston_dynamic_sg" {
  type = map(any)
}

variable "App_dynamic_sg" {
  type = map(any)
}

variable "ALB_dynamic_sg" {
  type = map(any)
}


##########################################

variable "key_name" {
  description = "Public Key Name"
  type        = string
  
}


################################Ec2##############################


variable "instance_t" {
  description = "Ec2 instance type"
  type = string
  
}

variable "associate_public_ip" {
  default = "true"

}








variable "private_security_group" {
  type    = string
  default = ""

}




variable "subnet_id" {
  type    = string
  default = ""
}



variable "server_names" {
  description = "Names of the instances"
  type        = list(string)
  default     = ["lendingplate.co.in", "Unifinz.in", "lendingplate.com"]
}


#######################################################

#ALB

variable "lb_type" {
  type    = string
  default = "application"
}

variable "lb_app_name" {
  default = "Lendingplate-alb"
}



variable "lb_target_group_lending-com" {
  default = "lending-com-tg"
}
