resource "random_password" "db_master_pass" {
  length            = 40
  special           = true
  min_special       = 5
  override_special  = "!#$%^&*()-_=+[]{}<>:?"
  keepers           = {
    pass_version  = 1
  }
}

module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "2.35.0"
  identifier = "Test-db"
  port = 3306
  storage_type = "gp2"
  allocated_storage = 200
  max_allocated_storage = 300
  engine = "mariadb"
  engine_version = "10.6.15"
  major_engine_version = "10.6"
  family = "mariadb10.6"  # Corrected parameter group family
  instance_class = "db.m5.large"
  name = var.app_name
  username = "${var.app_name}_admin"  # Start with a letter. Only numbers, letters, and _ accepted, 1 to 16 characters long
  password = random_password.db_master_pass.result
  multi_az = false
  vpc_security_group_ids = [module.security_group.security_group_id]
  subnet_ids = module.vpc.private_subnets
  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window = "03:00-06:00"
  backup_retention_period = 0
  skip_final_snapshot = true
  publicly_accessible = true
  allow_major_version_upgrade = true
  deletion_protection = true
  performance_insights_enabled = true
  parameter_group_name = ""
  create_monitoring_role = true
  monitoring_interval = 60

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]
}