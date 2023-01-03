resource "aws_alb" "front" {
  name            = "${random_string.name.result}front-load-balancer"
  subnets         = "${module.Networking.public_subnets_id}"
  security_groups = [aws_security_group.lb.id]
}

resource "aws_alb_target_group" "front" {
  name        = "${random_string.name.result}-front-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = "${module.Networking.vpc_id}"
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/"
    unhealthy_threshold = "2"
  }
}

# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_alb.front.id
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.front.id
    type             = "forward"
  }
}



resource "aws_alb" "back" {
  name            = "${random_string.name.result}back-load-balancer"
  subnets         = "${module.Networking.public_subnets_id}"
  security_groups = [aws_security_group.lb.id]
}

resource "aws_alb_target_group" "back" {
  name        = "${random_string.name.result}-back-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = "${module.Networking.vpc_id}"
  target_type = "ip"

  health_check {
    healthy_threshold   = "2"
    interval            = "90"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/api/courses"
    unhealthy_threshold = "4"
  }
}

# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "back_end" {
  load_balancer_arn = aws_alb.back.id
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.back.id
    type             = "forward"
  }
}

resource "aws_alb" "admin" {
  name            = "${random_string.name.result}admin-load-balancer"
  subnets         = "${module.Networking.public_subnets_id}"
  security_groups = [aws_security_group.lb.id]
}

resource "aws_alb_target_group" "admin" {
  name        = "${random_string.name.result}-admin-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = "${module.Networking.vpc_id}"
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/"
    unhealthy_threshold = "2"
  }
}

# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "admin_end" {
  load_balancer_arn = aws_alb.admin.id
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.admin.id
    type             = "forward"
  }
}