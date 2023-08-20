# variablies for ECS cluster

variable "is_create_ecs_cluster" {
  description = "Boolean value for creation ecs cluster"
  type        = bool
  default     = true
}

variable "ecs_cluster_name" {
  description = "The name of ecs cluster to create."
  type        = string
  default     = "demo-cluster"
}

variable "prefix" {
  description = "Prefix will be used for Name tag"
  type        = string
  default     = "nonprod"
}

variable "created_by" {
  description = "String value to specify create by Terraform or Manual"
  type        = string
  default     = "tf"
}

variable "app_name" {
  description = "Specify App name"
  type        = string
  default     = ""
}

variable "ecs_capacity_provider" {
  description = "List of short name of one or more capacity providers to associate with cluster"
  type        = list(string)
  default     = ["FARGATE", "FARGATE_SPOT"]
}

variable "default_capacity_providers" {
  type = list(object({
    base              = number
    weight            = number
    capacity_provider = string
  }))
  default = [
    {
      base              = 0
      weight            = 1
      capacity_provider = "FARGATE"
    }
  ]

}

variable "ecs_cluster_setting" {
  description = "Configuration block with cluster setting."
  type = list(object({
    name  = string
    value = string
  }))
  default = [
    {
      name  = "containerInsights"
      value = "enabled"
    }
  ]
}

variable "env" {
  description = "Name of enviroment."
  type        = string
  default     = "dev"
}

variable "ecs_cluster_tags" {
  description = "Map of tags to apply on resource"
  type        = map(string)
  default     = {}
}

variable "mandatory_resource_tags" {
  description = "Mandatory tags to apply on resource"
  type        = map(string)
  default     = {}
}

