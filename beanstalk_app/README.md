# beanstalk_app

Creates an Elastic Beanstalk app.

## Usage

```hcl
module "myapp" {
  source = "github.com/openoakland/terraform-modules.git//beanstalk_app?ref=2.0.0

  app_name = "myapp"
}
```

### Variables

See [beanstalk_app/variables.tf](./variables.tf).


### Outputs

N/A
