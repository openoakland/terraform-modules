# s3_deploy_user

Creates an IAM user for automated access to an S3 bucket. Use this with the
s3_cloudfront_website module to configure your CI to automatically deploy your
website to S3.


## Usage

Create the IAM user in your terraform template.

```hcl
module "s3_cloudfront_website" {
  host = "myapp"
  zone = "aws.openoakland.org"
}

module "s3_deploy_user" {
  source        = "github.com/openoakland/terraform-modules//s3_deploy_user?ref=2.1.0"
  username      = "ci-app"
  s3_bucket_arn = "${module.s3_cloudfront_website.s3_bucket_arn}"
}

output "ci_user_access_key_id" {
  value = "${module.s3_deploy_user.access_key_id}"
}

output "ci_user_secret_access_key" {
  value     = "${module.s3_deploy_user.secret_access_key}"
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


### username

IAM useranme.

### s3_bucket_arn

ARN of your s3 bucket e.g. `arn:aws:s3:::my-bucket-name`.


## Outputs


### access_key_id

The AWS_ACCESS_KEY_ID for this user.


### secret_access_key

The AWS_SECRET_ACCESS_KEY for this user.
