[![CircleCI](https://circleci.com/gh/openoakland/terraform-modules.svg?style=svg)](https://circleci.com/gh/openoakland/terraform-modules)

# Terraform modules

Various [Terraform](https://www.terraform.io/) modules used to provision resources in AWS.

## Usage

### Prerequisites

You'll need to install these.

- [Terraform](https://www.terraform.io/downloads.html) v0.11+


## Development

### Setup

Set your AWS access key.

    $ export AWS_ACCESS_KEY_ID=<your-aws-access-key-id>
    $ export AWS_SECRET_ACCESS_KEY=<your-aws-secret-access-key>

There is no state for this repo. You can run `terraform plan` or `terraform
apply` with local state to make sure modules are created properly. Make changes
to `test.tf` template in order to test them. Make sure to delete your modules
afterwards with `terraform destroy`.


### Test your templates

Runs `terraform validate` on all the modules.

    $ make test
