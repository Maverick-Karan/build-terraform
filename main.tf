#create security grups
module "sg" {
  source        = "./modules/sg"
}

#create RDS postgres
module "rds" {
    source      = "./modules/rds"
    username    = var.username
    password    = var.password
    identifier  = var.identifier
    db_name     = var.db_name
    sg_rds      = module.sg.rds_sg_id
    private_az1 = var.private_az1
    parameter_group_name = var.parameter_group_name

    depends_on = [
      module.sg
    ]
}

# create alb
module "application_load_balancer" {
  source                = "./modules/alb"
  alb_name              = var.alb_name
  public_subnet_az1_id  = var.public_subnet_az1_id
  public_subnet_az2_id  = var.public_subnet_az2_id
  sg_alb                = module.sg.alb_sg_id
  vpc_id                = var.vpc_id 

  depends_on = [
    module.rds
  ]
}

# create ECS cluster
module "ecs_cluster" {
  source                = "./modules/ecs_cluster"

  depends_on = [
    module.application_load_balancer
  ]
}

# create ECS task definition
module "ecs_task" {
  source                = "./modules/task_definitions"
  rds_endpoint          = module.rds.rds_db_endpoint
  exec_role             = var.exec_role
  api_image             = var.api_image
  alb_endpoint          = "${module.application_load_balancer.alb_dns}:3000"
  web_image             = var.web_image
  
  depends_on = [
    module.ecs_cluster
  ]   
}

# create ECS service
module "ecs_service" {
  source                = "./modules/ecs_service"
  ecs_cluster           = module.ecs_cluster.ecs_cluster_id
  api_task              = module.ecs_task.api_task_definition_arn
  web_task              = module.ecs_task.web_task_definition_arn
  public_subnet_az1_id  = var.public_subnet_az1_id
  sg_fargate            = [module.sg.rds_sg_id,module.sg.alb_sg_id]
  tg_api_arn            = module.application_load_balancer.tg_api_arn
  tg_web_arn            = module.application_load_balancer.tg_web_arn 

  depends_on = [
    module.ecs_task
  ]
}
