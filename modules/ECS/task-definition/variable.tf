variable "container_name" {
  description = "The name of the container."
  type        = string
  default     = "web-server-1"

}

variable "container_image" {
  description = "The image used to start the container."
  type        = string
  default     = "httpd:latest"
}

variable "task_def_name" {
  description = "A unique name for your task definition."
  type        = string
  default     = "test-def"
}

variable "container_definition" {
  type = any
  default = [
    {
      name      = "first"
      image     = "httpd:2.4"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ]
  #   sensitive = true
}