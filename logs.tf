resource "aws_cloudwatch_log_group" "front_log_group" {
  name              = "/${random_string.name.result}/front"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_stream" "front_log_stream" {
  name           = "${random_string.name.result}-front-log-stream"
  log_group_name = aws_cloudwatch_log_group.front_log_group.name
}

resource "aws_cloudwatch_log_group" "back_log_group" {
  name              = "/${random_string.name.result}/back"
  retention_in_days = 30

}

resource "aws_cloudwatch_log_stream" "back_log_stream" {
  name           = "${random_string.name.result}-back-log-stream"
  log_group_name = aws_cloudwatch_log_group.back_log_group.name
}

resource "aws_cloudwatch_log_group" "admin_log_group" {
  name              = "/${random_string.name.result}/admin"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_stream" "admin_log_stream" {
  name           = "${random_string.name.result}-admin-log-stream"
  log_group_name = aws_cloudwatch_log_group.admin_log_group.name
}