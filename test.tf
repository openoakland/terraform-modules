module "beanstalk_app_test" {
  source = "./beanstalk_app"

  app_name = "terraform-modules"
}

module "postgresdb_test" {
  source      = "./postgresdb"
  namespace   = "terraform-modules-test"
  db_name     = "terraform_modules"
  db_password = "database-secret"
  db_username = "db_test_user"
  deletion_protection = false
}

module "beanstalk_env_test" {
  source = "./beanstalk_env"

  app_instance    = "test"
  app_name        = "terraform-modules"
  dns_zone   = "aws.openoakland.org"
  security_groups = ["${module.postgresdb_test.security_group_name}"]

  environment_variables = {
    DATABASE_URL = "${module.postgresdb_test.database_url}"
  }
}

output "beanstalk_env_fqdn" {
  value = "${module.beanstalk_env_test.fqdn}"
}
