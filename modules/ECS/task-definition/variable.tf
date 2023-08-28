#------------------------------------------------------------------------------
# AWS ECS Task Definition Variables
#------------------------------------------------------------------------------


variable "create" {
  description = "Determines whether resources will be created (affects all resources)"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "prefix" {
  description = "Prfix will be used for Name tag"
  type        = string
  default     = ""
}

variable "created_by" {
  description = "String Value to specify Created by Terraform or Manual"
  type        = string
  default     = ""
}

variable "env" {
  description = "Name of the environment."
  type        = string
  default     = ""
}

variable "task_definition_name" {
  description = "A unique name for your task definition."
  type        = string
  default     = "demo-task-def"
}

variable "container_definition" {
  type        = any
  description = "Container definitions to use for the task. If this is used, all other container options will be ignored."
  default = [
    {
      "name" : "web-server",
      "image" : "httpd:latest",
      "cpu" : 256,
      "memory" : 512,
      "portMappings" : [
        {
          "containerPort" : 80,
          "hostPort" : 80,
          "protocol" : "tcp"
        }
      ],
      "essential" : true
    }
  ]

}

variable "task_role_arn" {
  description = "(Optional) The ARN of IAM role that grants permissions to the actual application once the container is started (e.g access an S3 bucket or DynamoDB database). If not specified, `aws_iam_role.ecs_task_execution_role.arn` is used"
  type        = string
  default     = "arn:aws:iam::108040610828:role/ecsTaskExecutionRole"
}

variable "execution_role_arn" {
  description = "(Optional) The ARN of IAM role that grants permissions to start the containers defined in a task (e.g populate environment variables from AWS Secrets Manager). If not specified, `aws_iam_role.ecs_task_execution_role.arn` is used"
  type        = string
  default     = "arn:aws:iam::108040610828:role/ecsTaskExecutionRole"
}

variable "network_mode" {
  description = "The network mode to use for the task.This is required to be `awsvpc` for `FARGATE` `launch_type`"
  type        = string
  default     = "awsvpc"
}

variable "task_cpu_units" {
  description = "The no. of CPU units used by the task."
  type        = number
  default     = 256

}

variable "task_memory_size" {
  description = "The amount of memory (in MiB) used by the task."
  type        = number
  default     = 512

}

variable "task_definition_launch_type_compatibilities" {
  description = "The launch type on which to run your service. Valid values are `EC2` and `FARGATE`"
  type        = list(string)
  default     = ["FARGATE"]

}

variable "runtime_platform_operating_system_family" {
  type        = string
  default     = "LINUX"
  description = "If the requires_compatibilities is FARGATE this field is required. The valid values for Amazon ECS tasks that are hosted on Fargate are LINUX, WINDOWS_SERVER_2019_FULL, WINDOWS_SERVER_2019_CORE, WINDOWS_SERVER_2022_FULL, and WINDOWS_SERVER_2022_CORE."
}

variable "runtime_platform_cpu_architecture" {
  type        = string
  description = "Must be set to either X86_64 or ARM64"
  default     = "X86_64"
}

variable "mandatory_resource_tags" {
  description = "Key-Value pair of resource tag"
  type        = map(string)
  default     = {}
}

variable "task_definition_tags" {
  description = "Key-Value pair of resource tag"
  type        = map(string)
  default     = {}
}

# App Mesh proxy
variable "proxy_configuration" {
  description = "(Optional) The proxy configuration details for the App Mesh proxy."
  type = list(object({
    container_name = string
    properties = list(object({
      name  = string
      value = string
    }))
    type = string #proxy type
  }))
  default = []
}

variable "placement_constraints" {
  description = "(Optional) A set of placement constraints rules that are taken into consideration during task placement. Maximum number of placement_constraints is 10."
  type = list(object({
    type       = string
    expression = string
  }))
  default = []

}

variable "volume" {
  description = ""
  type = list(object({
    name      = string
    host_path = string
    docker_volume_configuration = list(object({
      scope         = string
      autoprovision = bool
      driver        = string
      driver_opts   = map(string)
      labels        = map(string)
    }))
    efs_volume_configuration = list(object({
      file_system_id          = string
      root_directory          = string
      transit_encryption      = string
      transit_encryption_port = number
      authorization_config = list(object({
        access_point_id = string
        iam             = string
      }))
    }))
  }))
  default = []
}