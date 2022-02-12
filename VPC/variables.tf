variable "vpc_ipv4_cidr" {
  description = "The VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Name to be used on the Default VPC"
  type        = string
  default     = ""
}

variable "vpc_instance_tenancy" {
  description = "VPC instance_tenancy Default, Host and dedicated"
  type        = string
  default     = "default"
}

variable "vpc_enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "vpc_tags" {
  description = "VPC tags"
  type        = map(string)
  default = {
    "Name"      = "dev-vpc-tf"
    "Env"       = "Dev"
    "CreatedBy" = "sagar Borse"
  }
}

variable "vpc_pvt_subnet_tags" {
  description = "Subnet tags"
  type        = map(string)
  default = {
    "Name"      = "dev-pvt-subnet-tf"
    "Env"       = "Dev"
    "CreatedBy" = "Sagar Borse"
  }
}

variable "pvt-sub-cidr" {
  description = "CIDR for the private subnet"
  type = string
  default = "10.0.2.0/24"
}

variable "vpc_pub_subnet_tags" {
  description = "Subnet tags"
  type        = map(string)
  default = {
    "Name"      = "dev-pub-subnet-tf"
    "Env"       = "Dev"
    "CreatedBy" = "Sagar Borse"
  }
}

variable "pub_sub_cidr" {
  description = "CIDR for the public subnet"
  type = string
  default = "10.0.1.0/24"
}

variable "igw_tags" {
  description = "igw tags"
  type        = map(string)
  default = {
    "Name"      = "dev-igw-tf"
    "Env"       = "Dev"
    "CreatedBy" = "Sagar Borse"
  }
}

variable "route_tbl_tags" {
  description = "igw tags"
  type        = map(string)
  default = {
    "Name"      = "dev-route-tbl-tf"
    "Env"       = "Dev"
    "CreatedBy" = "Sagar Borse"
  }
}

variable "vpc_security_group_name" {
    description = "Dev VPC default security group"
    type = string
    default = "dev-sg-tf"
}

variable "avz" {
  description = "Subnect availability zone"
  type = list(string)
  default = [ "ap-south-1a", "ap-south-1b" ]
}

variable "images" {
  description = "ID of AMI to use for the instance"
  type        = map(string)
  default = {
    "centos7" = "ami-0007417ec76523a33"
    "redhat8" = "ami-06a0b4e3b7eb7a300"
    "amazone" = "ami-03fa4afc89e4a8a09"
  }

  validation {
    condition     = length(var.images["centos7"]) > 4 && substr(var.images["centos7"], 0, 4) == "ami-"
    error_message = "The ec28 ami id value must be a valid AMI id starting with \"ami-\"."
  }
}

variable "instance_type" {
  description = "The type of instance to strt"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Key name of key pair to use for the instance"
  type        = string
  default     = "win-kp"
}