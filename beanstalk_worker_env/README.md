# beanstalk_worker_env

Creates an AWS Elastic Beanstalk worker environment with load balancer and auto
scaling group.


## Usage

```hcl
module "myapp" {
  source = "github.com/openoakland/terraform-modules.git//beanstalk_app?ref=2.1.0

  app_name = "myapp"
}

module "myapp_prod_worker" {
  source         = "github.com/openoakland/terraform-modules//beanstalk_worker_env?ref=v2.1.0"

  name           = "myapp-worker"
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

See [beanstalk_worker_env/variables.tf](./variables.tf).


### Outputs

See [beanstalk_worker_env/outputs.tf](./outputs.tf).
