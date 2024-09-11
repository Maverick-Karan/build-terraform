# RDS variables
variable "username" {}
variable "password" {}
variable "parameter_group_name" {}
variable "private_az1" {}
variable "identifier" {}
variable "db_name" {}

# ALB variables
variable "public_subnet_az1_id" {}
variable "public_subnet_az2_id" {}
variable "alb_name" {}
variable "vpc_id" {}

# ECS Task Definitions variables
variable "exec_role" {}
variable "api_image" {}






