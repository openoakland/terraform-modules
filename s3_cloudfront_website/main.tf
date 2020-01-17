provider "aws" {
  alias = "main"
}

provider "aws" {
  alias = "cloudfront"
}

module "site" {
  source = "github.com/riboseinc/terraform-aws-s3-cloudfront-website?ref=8b040cc6"

  fqdn                = "${var.host}.${var.zone}"
  ssl_certificate_arn = aws_acm_certificate_validation.cert.certificate_arn
  allowed_ips         = var.allowed_ips

  index_document = "index.html"
  error_document = "404.html"

  force_destroy = "true"

  providers = {
    aws.main       = aws.main
    aws.cloudfront = aws.cloudfront
  }
}

resource "aws_acm_certificate" "cert" {
  provider          = aws.cloudfront
  domain_name       = "${var.host}.${var.zone}"
  validation_method = "DNS"
}

resource "aws_route53_record" "cert_validation" {
  provider = aws.cloudfront
  name     = aws_acm_certificate.cert.domain_validation_options[0].resource_record_name
  type     = aws_acm_certificate.cert.domain_validation_options[0].resource_record_type
  zone_id  = data.aws_route53_zone.site.id
  records  = [aws_acm_certificate.cert.domain_validation_options[0].resource_record_value]
  ttl      = 60
}

resource "aws_acm_certificate_validation" "cert" {
  provider                = aws.cloudfront
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [aws_route53_record.cert_validation.fqdn]
}

# Route 53 record for the static site
data "aws_route53_zone" "site" {
  name         = var.zone
  private_zone = false
}

resource "aws_route53_record" "web" {
  zone_id = data.aws_route53_zone.site.zone_id
  name    = "${var.host}.${var.zone}"
  type    = "CNAME"
  ttl     = 1800
  # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
  # force an interpolation expression to be interpreted as a list by wrapping it
  # in an extra set of list brackets. That form was supported for compatibility in
  # v0.11, but is no longer supported in Terraform v0.12.
  #
  # If the expression in the following list itself returns a list, remove the
  # brackets to avoid interpretation as a list of lists. If the expression
  # returns a single list item then leave it as-is and remove this TODO comment.
  records = [module.site.cf_domain_name]
}

