# RDS variables
username="postgres"
password="password123"
parameter_group_name="no-ssl"
private_az1="us-east-1e"
identifier="rds-db"
db_name="mydatabase"

# ALB variables
public_subnet_az1_id="subnet-0409caade50770b30"
public_subnet_az2_id="subnet-04e19eb31108529d7"
alb_name="alb-build"
vpc_id="vpc-0d6f7e5f8e2810121" 

# ECS Task Definitions variables
exec_role="arn:aws:iam::339713165832:role/ecsTaskExecutionRole"
api_image="339713165832.dkr.ecr.us-east-1.amazonaws.com/api"
