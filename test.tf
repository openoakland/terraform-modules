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

module "beanstalk_env_test" {
  source = "./beanstalk_web_env"

  app_instance    = "test"
  app_name        = "terraform-modules"
  dns_zone        = "aws.openoakland.org"
  security_groups = ["${module.postgresdb_test.security_group_name}"]

  environment_variables = {
    DATABASE_URL = "${module.postgresdb_test.database_url}"
  }
}

provider "aws" {
  region = "us-west-1"
  alias  = "cloudfront"
}

provider "aws" {
  region = "us-west-1"
  alias  = "main"
}

module "s3_cloudfront_website_test" {
  source = "./s3_cloudfront_website"

  host = "oo-s3-cf-website-terraform-modules-test"
}

module "s3_deploy_user" {
  source        = "./s3_deploy_user"
  username      = "ci-terraform-modules-test"
  s3_bucket_arn = "${module.s3_cloudfront_website_test.s3_bucket_arn}"
}

output "beanstalk_env_fqdn" {
  value = "${module.beanstalk_env_test.fqdn}"
}
