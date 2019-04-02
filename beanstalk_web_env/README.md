# beanstalk_web_env

Creates an AWS Elastic Beanstalk web environment with load balancer and auto
scaling group.


## Usage

```hcl
module "myapp" {
  source = "github.com/openoakland/terraform-modules.git//beanstalk_app?ref=2.0.0

  app_name = "myapp"
}

module "myapp_prod_web" {
  source         = "github.com/openoakland/terraform-modules//beanstalk_web_env?ref=v2.0.0"
  name           = "awesome-domain-name"
  app_name       = "myapp"
  app_instance   = "production"
  dns_zone_name  = "myapp.aws.example.com"
  dns_zone_id    = "${aws_route53_zone.myapp_zone.id}"

  environment_variables {
    DATABASE_URL = "postgres://dbuser:dbpassword@dbhost/dbname"
  }
}
```

### Variables

See [beanstalk_web_env/variables.tf](./variables.tf).


### Outputs

See [beanstalk_web_env/outputs.tf](./outputs.tf).
