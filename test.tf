module "vpc" {
  source = "./vpc"

  vpc_name               = "terraform-modules-test"
  num_availability_zones = 2
}

module "beanstalk_app_test" {
  source = "./beanstalk_app"

  app_name = "terraform-modules"
}

module "postgresdb_test" {
  source              = "./postgresdb"
  namespace           = "terraform-modules-test"
  db_name             = "terraform_modules"
  db_password         = "database-secret"
  db_username         = "db_test_user"
  deletion_protection = false
  skip_final_snapshot = true
}

module "beanstalk_worker" {
  source = "./beanstalk_worker_env"

  app_instance    = "test"
  app_name        = "terraform-modules"
  name            = "terraform-modules-worker"
  security_groups = [module.postgresdb_test.security_group_name]

  environment_variables = {
    DATABASE_URL = module.postgresdb_test.database_url
  }
}

module "beanstalk_web" {
  source = "./beanstalk_web_env"

  name            = "terraform-modules-web"
  app_instance    = "test"
  app_name        = "terraform-modules"
  dns_zone        = "aws.openoakland.org"
  security_groups = [module.postgresdb_test.security_group_name]

  environment_variables = {
    DATABASE_URL = module.postgresdb_test.database_url
  }
}

module "s3_cloudfront_website_test" {
  source = "./s3_cloudfront_website"

  host = "oo-s3-cf-website-terraform-modules-test"

  providers = {
    aws.main       = aws
    aws.cloudfront = aws.cloudfront
  }
}

module "s3_deploy_user" {
  source        = "./s3_deploy_user"
  username      = "ci-terraform-modules-test"
  s3_bucket_arn = module.s3_cloudfront_website_test.s3_bucket_arn
}

output "beanstalk_env_fqdn" {
  value = module.beanstalk_web.fqdn
}
