#variable for ECS_service

variable "create" {
  description = "Boolean value for creation ecs service"
  type        = bool
  default     = true
}

variable "ecs_service_name" {
  description = "The name of the service."
  type        = string
  default     = "test"
}

variable "ecs_cluster_arn" {
  description = "(Optional)ARN of an ECS cluster"
  type        = string
  default     = "arn:aws:ecs:us-east-1:108040610828:cluster/demo-cluster"
}

variable "task_definition_arn" {
  description = "(Required) The full ARN of the task definition that you want to run in your service."
  type        = string
  default     = "arn:aws:ecs:us-east-1:108040610828:task-definition/demo-DF:3"
}

variable "deployment_maximum_percent" {
  description = "(Optional) The upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment."
  type        = number
  default     = 200
}

variable "deployment_minimum_healthy_percent" {
  description = "(Optional) The lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment."
  type        = number
  default     = 100
}

variable "desired_count" {
  description = "(Optional) The number of instances of the task definition to place and keep running. Defaults to 0."
  type        = number
  default     = 1
}

variable "enable_execute_command" {
  description = "(Optional) Specifies whether to enable Amazon ECS Exec for the tasks within the service."
  type        = bool
  default     = false
}

variable "enable_ecs_managed_tags" {
  description = "(Optional) Specifies whether to enable Amazon ECS managed tags for the tasks within the service."
  type        = bool
  default     = false
}

variable "health_check_grace_period_seconds" {
  description = "(Optional) Seconds to ignore failing load balancer health checks on newly instantiated tasks to prevent premature shutdown, up to 2147483647. Only valid for services configured to use load balancers."
  type        = number
  default     = 0
}

variable "launch_type" {
  description = "The launch type on which to run your service. Valid values are `EC2` and `FARGATE`"
  type        = string
  default     = "FARGATE"
}

variable "force_new_deployment" {
  description = "(Optional) Enable to force a new task deployment of the service. This can be used to update tasks to use a newer Docker image with same image/tag combination (e.g. myimage:latest), roll Fargate tasks onto a newer platform version, or immediately deploy ordered_placement_strategy and placement_constraints updates."
  type        = bool
  default     = false
}

variable "platform_version" {
  description = "The platform version on which to run your service.Only applicable for launch_type set to FARGATE."
  type        = string
  default     = "LATEST"
}

variable "scheduling_strategy" {
  description = "The scheduling strategy to use for the service.The valid values are REPLICA and DAEMON.Fargate tasks do not support the DAEMON scheduling strategy."
  type        = string
  default     = "REPLICA"
}

variable "propagate_tags" {
  description = "(Optional) Specifies whether to propagate the tags from the task definition or the service to the tasks. The valid values are SERVICE and TASK_DEFINITION. Default to SERVICE"
  default     = "SERVICE"
}

variable "capacity_provider_strategies" {
  description = "The capacity provider strategies to use for the service."
  type = list(object({
    capacity_provider = string
    weight            = number
    base              = number
  }))
  default = []
}

variable "service_registries" {
  description = "(Optional) The service discovery registries for the service. The maximum number of service_registries blocks is 1. This is a map that should contain the following fields \"registry_arn\", \"port\", \"container_port\" and \"container_name\""
  type = list(object({
    registry_arn   = string
    port           = number
    container_port = number
    container_name = string
  }))
  default = []
}

variable "ordered_placement_strategy" {
  description = "(Optional) Service level strategy rules that are taken into consideration during task placement. List from top to bottom in order of precedence. The maximum number of ordered_placement_strategy blocks is 5. This is a list of maps where each map should contain \"id\" and \"field\""
  type = list(object({
    type  = string
    field = string
  }))
  default = []
}

variable "placement_constraints" {
  type = list(object({
    type       = string
    expression = string
  }))
  description = "(Optional) rules that are taken into consideration during task placement. Maximum number of placement_constraints is 10. This is a list of maps, where each map should contain \"type\" and \"expression\""
  default     = []
}

variable "load_balancer" {
  description = "A list of load balancer config objects for the ECS service."
  type = list(object({
    container_name   = string
    container_port   = number
    elb_name         = string
    target_group_arn = string
  }))
  default = []
}

variable "deployment_controller" {
  description = " (Optional) Type of deployment controller. Valid values: CODE_DEPLOY, ECS, EXTERNAL. Default: ECS."
  type = list(object({
    type = string
  }))
  default = [{
    type = "ECS"
  }]
}

variable "assign_public_ip" {
  description = "(Optional) Assign a public IP address to the ENI (Fargate launch type only). If true service will be associated with public subnets. Default false. "
  type        = bool
  default     = true
}

variable "security_group_ids" {
  description = "(Optional) The security groups associated with the task or service. If you do not specify a security group, the default security group for the VPC is used."
  type        = list(any)
  default     = ["sg-0da0d4b35236bb809"]
}

variable "public_subnets" {
  description = "The public subnets associated with the task or service."
  type        = list(any)
  default     = ["subnet-0c462f8471784a2e7","subnet-0270808baf0da1aae"]
}

variable "private_subnets" {
  description = "The private subnets associated with the task or service."
  type        = list(any)
  default     = ["subnet-0514c2171caa68497","subnet-02fafae2ed88a1773"]
}