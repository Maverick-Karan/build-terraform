# Security group variables
variable "sg_rds" {}
variable "sg_alb" {}
variable "sg_fargate" {}

# RDS variables
variable "username" {}
variable "password" {}
variable "parameter_group_name" {}
variable "private_az1" {}
variable "identifier" {}

# ALB variables
variable "public_subnet_az1_id" {}
variable "public_subnet_az2_id" {}
variable "alb_name" {}

# ECS Task Definitions variables
variable "exec_role" {}
variable "api_image" {}
variable "rds_endpoint" {}

# ECS service variables
variable "ecs_cluster" {}
variable "api_task" {}
variable "tg_api_arn" {}




