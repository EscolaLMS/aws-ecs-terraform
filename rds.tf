resource "aws_rds_cluster" "postgresql" {
  cluster_identifier = "${random_string.name.result}-postgresql"
  engine             = "aurora-postgresql"
  engine_mode        = "provisioned"
  backup_retention_period = 10
  db_subnet_group_name = "${aws_db_subnet_group.subnet_rds.id}"
  vpc_security_group_ids = [aws_security_group.rds.id]
  engine_version     = "14.5"
  database_name      = "sa"
  master_username    = "sa"
  master_password    = random_password.db.result
  skip_final_snapshot       = true
#  deletion_protection = true
  

  serverlessv2_scaling_configuration {
    max_capacity = 1
    min_capacity = 0.5
  }
}

resource "aws_rds_cluster_instance" "postgresql" {
  cluster_identifier = aws_rds_cluster.postgresql.id
  instance_class     = "db.serverless"
  engine             = aws_rds_cluster.postgresql.engine
  engine_version     = aws_rds_cluster.postgresql.engine_version
  #maintenance_window = "Sat:00:00-Sat:03:00"
  auto_minor_version_upgrade = false
}

resource "aws_db_subnet_group" "subnet_rds" {
  name        = "${random_string.name.result}-subnet-group"
  subnet_ids  = "${module.Networking.public_subnets_id}"
}
