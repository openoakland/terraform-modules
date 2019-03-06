# postgresd

Creates a PostgreSQL RDS database instnace.


## Usage

```hcl
module "db" {
  source = "github.com/openoakland/terraform-modules.git//postgresdb?ref=2.0.0

  db_name     = "myapp_db"
  db_password = "${var.db_password}"
  db_username = "myappuser"
  namespace   = "myapp-prod"

}
```

### Variables

See [postgresdb/variables.tf](./variables.tf).


### Outputs

See [postgresdb/outputs.tf](./outputs.tf).
