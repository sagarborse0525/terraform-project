terraform {
  backend "s3" {
    bucket  = "terraform-state-bkt-23"
    key     = "terraform/state/ECS/task-def/terraform.tfstate"
    encrypt = true
    region  = "us-east-1"
    # dynamodb_table = "state-locking"

  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "default"
  assume_role {
    role_arn = "arn:aws:iam::108040610828:role/terraform-role"
  }

}