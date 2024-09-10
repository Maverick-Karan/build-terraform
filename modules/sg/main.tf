# create security group for the database
resource "aws_security_group" "database_security_group" {
  name        = "rds sg"
  description = "enable fargate access on port 5432"

  ingress {
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    security_groups  = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags   = {
    Name = "RDS security group"
  }
}


# create security group for the ALB
resource "aws_security_group" "alb_security_group" {
  name        = "alb sg"
  description = "enable all access"

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags   = {
    Name = "ALB security group"
  }
}

# create security group for the ECS fargate
resource "aws_security_group" "fargate_security_group" {
  name        = "fargate sg"
  description = "enable access from alb and rds"

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = -1
    security_groups  = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags   = {
    Name = "fargate security group"
  }
}


# ------ Setting Security group rules ------ #

# Allow traffic from Fargate to RDS
resource "aws_security_group_rule" "fargate_to_rds" {
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  source_security_group_id = aws_security_group.fargate_security_group.id
  security_group_id = aws_security_group.database_security_group.id
}

# Allow traffic from RDS to Fargate
resource "aws_security_group_rule" "rds_to_fargate" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  source_security_group_id = aws_security_group.database_security_group.id
  security_group_id = aws_security_group.fargate_security_group.id
}

# Allow traffic from ALB to Fargate
resource "aws_security_group_rule" "alb_to_fargate" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = aws_security_group.alb_security_group.id
  security_group_id = aws_security_group.fargate_security_group.id
}
