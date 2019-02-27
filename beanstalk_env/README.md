# beanstalk_env

Creates an AWS Elastic Beanstalk environment.


## Usage

```hcl
module "production_web" {
  source         = "github.com/openoakland/terraform-modules//beanstalk_env?ref=v2.0.0"
  app_name       = "my-app"
  app_instance   = "production"
  dns_zone_name  = "myapp.aws.example.com"
  dns_zone_id    = "${aws_route53_zone.myapp_zone.id}"

  environment_variables {
    DATABASE_URL = "postgres://dbuser:dbpassword@dbhost/dbname"
  }
}
```

### Variables

See [beanstalk_env/variables.tf](./variables.tf).


### Outputs

See [beanstalk_env/outputs.tf](./outputs.tf).
