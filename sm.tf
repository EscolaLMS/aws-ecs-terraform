resource "aws_secretsmanager_secret" "sm-backend-password" {
  name = "${random_string.name.result}/backend/db-password"

  recovery_window_in_days = 0
}
resource "aws_secretsmanager_secret_version" "service_password" {
  secret_id     = aws_secretsmanager_secret.sm-backend-password.id
  secret_string = random_password.db.result
}

resource "aws_secretsmanager_secret" "sm-rds-endpoint" {
  name = "${random_string.name.result}/backend/rds-endpoint"

  recovery_window_in_days = 0
}
resource "aws_secretsmanager_secret_version" "rds-endpoint" {
  secret_id     = aws_secretsmanager_secret.sm-rds-endpoint.id
  secret_string = aws_rds_cluster.postgresql.endpoint
}

resource "aws_secretsmanager_secret" "sm-redis-endpoint" {
  name = "${random_string.name.result}/backend/redis-endpoint"

  recovery_window_in_days = 0
}
resource "aws_secretsmanager_secret_version" "redis-endpoint" {
  secret_id     = aws_secretsmanager_secret.sm-redis-endpoint.id
  secret_string = aws_elasticache_replication_group.default.primary_endpoint_address
}

resource "aws_secretsmanager_secret" "sm-back-url" {
  name = "${random_string.name.result}/backend/back-url"

  recovery_window_in_days = 0
}
resource "aws_secretsmanager_secret_version" "back-url" {
  secret_id     = aws_secretsmanager_secret.sm-back-url.id
  secret_string = "https://${aws_cloudfront_distribution.back_distribution.domain_name}"
}


