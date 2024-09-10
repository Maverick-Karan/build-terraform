# create the rds instance
resource "aws_db_instance" "db_instance" {
  allocated_storage    = 20
  #db_name              = var.db_name
  engine               = "postgres"
  engine_version       = "16.3"
  instance_class       = "db.t3.micro"
  identifier           = var.identifier
  username             = var.username
  password             = var.password
  parameter_group_name = var.parameter_group_name
  skip_final_snapshot  = true
  multi_az             = false
  availability_zone    = var.private_az1
  vpc_security_group_ids = [var.sg_rds]
}