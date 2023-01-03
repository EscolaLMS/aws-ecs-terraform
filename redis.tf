resource "aws_elasticache_subnet_group" "default" {
  name       = "${random_string.name.result}-cache-subnet"
  subnet_ids = "${module.Networking.public_subnets_id}"
}

resource "aws_elasticache_replication_group" "default" {
  replication_group_id          = "${random_string.name.result}-group-redis-id"
  description                 = "${random_string.name.result} redis"
  node_type            = "cache.t3.micro"
  port                 = 6379
  parameter_group_name = "default.redis7"

  snapshot_retention_limit = 1
  snapshot_window          = "00:00-05:00"

  subnet_group_name          = "${aws_elasticache_subnet_group.default.name}"
  automatic_failover_enabled = false
  num_cache_clusters          = 1

  security_group_ids = [aws_security_group.redis.id]
#  user_group_ids                = [aws_elasticache_user_group.sa.id]
  transit_encryption_enabled = false

#  cluster_mode {
#    replicas_per_node_group = 1
#    num_node_groups         = "${var.node_groups}"
#  }
}
#resource "aws_elasticache_user" "sa" {
#  user_id       = "sa"
#  user_name     = "default"
#  access_string = "on ~app::* -@all +@read +@hash +@bitmap +@geo -setbit -bitfield -hset -hsetnx -hmset -hincrby -hincrbyfloat -hdel -bitop -geoadd -georadius -georadiusbymember"
#  engine        = "REDIS"
#  passwords     = ["${var.db_password}"]
#}

#resource "aws_elasticache_user_group" "sa" {
#  user_group_id = "${random_string.name.result}-sa"
#  engine        = "REDIS"
#  user_ids      = [aws_elasticache_user.sa.user_id]
#}