# s3_cloudfront_website

Creates a website in S3, served by CloudFront with a domain name in your
specified zone.


## Usage

```hcl
provider "aws" {
  region = "us-east-1"
  alias  = "cloudfront"
}

provider "aws" {
  region = "us-west-1"
  alias  = "main"
}

module "s3_cloudfront_website" {
  source = "github.com/openoakland/terraform-modules.git//s3_cloudfront_website?ref=2.1.0

  host        = "mywebsite"
  zone        = "aws.openoakland.org"

  providers = {
    aws.main = "aws.main"
    aws.cloudfront = "aws.cloudfront"
  }
}
```

Note that the [upstream
module](https://github.com/riboseinc/terraform-aws-s3-cloudfront-website)
requires the AWS CloudFront provider to be defined for the `us-east-1` region.


### Variables

See [s3_cloudfront_website/variables.tf](./variables.tf).


### Outputs

See [s3_cloudfront_website/outputs.tf](./outputs.tf).
