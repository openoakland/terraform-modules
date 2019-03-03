# eb_deploy_user

Creates an IAM user for deploying applications to Elastic Beanstalk with the
`eb` command line tool for use with continuous integration and deployment.


## Usage

Create the CI user in your terraform template.

```hcl
module "ci_user" {
  source      = "github.com/openoakland/terraform-modules//eb_deploy_username?ref=2.0.0"
  eb_deploy_username = "ci"
}

output "ci_user_access_key_id" {
  value = "${module.ci_user.access_key_id}"
}

output "ci_user_secret_access_key" {
  value     = "${module.ci_user.secret_access_key}"
  sensitive = true
}
```

Then set the AWS access secret key and Id in your continuous integration system.

    $ terraform output
    ci_user_access_key_id = ...
    ci_user_secret_access_key = ....

For CircleCI, add `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment
variables with the above values  in your project's settings.


## Variables


### eb_deploy_username

IAM useranme.


## Outputs


### ci_access_key_id

The AWS_ACCESS_KEY_ID for this user.


### ci_secret_access_key

The AWS_SECRET_ACCESS_KEY for this user.
