# iam_user

Creates an IAM user for automated AWS access.


## Usage

Create the IAM user in your terraform template.

```hcl
module "ci_user" {
  source      = "github.com/openoakland/terraform-modules//iam_user?ref=2.1.0"
  username = "ci-app"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:ListBucket",
                "s3:DeleteObject"
            ],
            "Resource": [
              "arn:aws:s3:::beta.aws.openoakland.org",
              "arn:aws:s3:::beta.aws.openoakland.org/*"
            ]
        }
    ]
}
EOF
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


### username

IAM useranme.

### policy

Inline IAM policy to attach to this user.


## Outputs


### access_key_id

The AWS_ACCESS_KEY_ID for this user.


### secret_access_key

The AWS_SECRET_ACCESS_KEY for this user.
