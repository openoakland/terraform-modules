provider "aws" {
  region = "us-west-2"
  alias  = "main"
}

provider "aws" {
  region = "us-west-2"
  alias  = "cloudfront"
}
