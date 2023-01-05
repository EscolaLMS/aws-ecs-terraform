resource "aws_ecs_cluster" "cluster1" {
  name = "${random_string.name.result}-cluster"
}

locals {
  front_app = templatefile("./ecs/front.json.tpl", {
    app_image      = var.image_front
    app_port       = 80
    fargate_cpu    = 1024
    fargate_memory = 2048	
    region         = var.region
    name           = random_string.name.result
    back_url       = "${aws_secretsmanager_secret.sm-back-url.arn}"
  })
}

resource "aws_ecs_task_definition" "front" {
  family                   = "${random_string.name.result}-front"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1024
  memory                   = 2048
  container_definitions    = local.front_app
}


resource "aws_ecs_service" "front" {
  name            = "${random_string.name.result}-front-service"
  cluster         = aws_ecs_cluster.cluster1.id
  task_definition = aws_ecs_task_definition.front.arn
  desired_count   = var.app_count_front
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = "${module.Networking.public_subnets_id}"
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.front.id
    container_name   = "${random_string.name.result}-front"
    container_port   = 80
  }

  depends_on = [aws_alb_listener.front_end, aws_iam_role_policy_attachment.ecs_task_execution_role]
}

locals {
  back_app = templatefile("./ecs/back.json.tpl", {
    app_image      = var.image_back
    app_port       = 80
    fargate_cpu    = 2048
    fargate_memory = 4096
    region     = var.region
    name           = random_string.name.result
    db_password    = "${aws_secretsmanager_secret.sm-backend-password.arn}"
    db_host        = "${aws_secretsmanager_secret.sm-rds-endpoint.arn}"
    redis_host     = "${aws_secretsmanager_secret.sm-redis-endpoint.arn}"
    back_url       = "${aws_secretsmanager_secret.sm-back-url.arn}"
  })
}


resource "aws_ecs_task_definition" "back" {
  family                   = "${random_string.name.result}-back"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 2048
  memory                   = 4096
  container_definitions    = local.back_app
 
 volume {
      name  = "storage"
      efs_volume_configuration {
        file_system_id = aws_efs_file_system.efs.id
      }
  }
}

resource "aws_ecs_service" "back" {
  name            = "${random_string.name.result}-back-service"
  cluster         = aws_ecs_cluster.cluster1.id
  task_definition = aws_ecs_task_definition.back.arn
  desired_count   = var.app_count_back
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = "${module.Networking.public_subnets_id}"
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.back.id
    container_name   = "${random_string.name.result}-back"
    container_port   = 80
  }

  depends_on = [aws_alb_listener.back_end, aws_iam_role_policy_attachment.ecs_task_execution_role]
}

locals {
  admin_app = templatefile("./ecs/admin.json.tpl", {
    app_image      = var.image_admin
    app_port       = 80
    fargate_cpu    = 1024
    fargate_memory = 2048	
    region     = var.region
    name           = random_string.name.result
    back_url       = "${aws_secretsmanager_secret.sm-back-url.arn}"
  })
}

resource "aws_ecs_task_definition" "admin" {
  family                   = "${random_string.name.result}-admin"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 1024
  memory                   = 2048
  container_definitions    = local.admin_app
}


resource "aws_ecs_service" "admin" {
  name            = "${random_string.name.result}-admin-service"
  cluster         = aws_ecs_cluster.cluster1.id
  task_definition = aws_ecs_task_definition.admin.arn
  desired_count   = var.app_count_admin
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = "${module.Networking.public_subnets_id}"
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.admin.id
    container_name   = "${random_string.name.result}-admin"
    container_port   = 80
  }

  depends_on = [aws_alb_listener.admin_end, aws_iam_role_policy_attachment.ecs_task_execution_role]
}