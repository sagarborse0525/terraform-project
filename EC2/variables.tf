# EC2 instance variables
variable "create" {
  description = "Whether to create an instance"
  type        = bool
  default     = true
}

variable "name" {
  description = "Name to be used on EC2 instance created"
  type        = string
  default     = ""
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

variable "availability_zone" {
  description = "AZ to start the instance in"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]
}

variable "subnet_id" {
  description = "The VPC subnet ID to launch in"
  type        = list(string)
  default     = ["subnet-0cc9725deffb7bc5c", "subnet-07b3a6776ec7081a9"]
}

variable "ec2_count" {
  description = "EC2 instance count"
  type        = number
  default     = 2
}

variable "instance_type" {
  description = "The type of instance to strt"
  type        = string
  default     = "t2.micro"
}

variable "tags" {
  description = "EC2 instance tags"
  type        = map(string)
  default = {
    "Name"      = "Web-Server-tf"
    "Env"       = "dev"
    "CreatedBy" = "sagar borse"
  }
}

variable "key_name" {
  description = "Key name of key pair to use for the instance"
  type        = string
  default     = "win-kp"
}

/* variable "ec2_user_data" {
    description = "EC2 instance user data"
    type = string
    default = file("apache-instance.sh")
  } */

variable "ec2_sg" {
  description = "EC2 security group"
  type        = list(string)
  default     = ["sg-0ee3fbfc2eef4793a", "sg-012e094d5cb696756"]
}