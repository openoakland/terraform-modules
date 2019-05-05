provider "aws" {
  alias = "main"
}

provider "aws" {
  alias = "cloudfront"
}

module "site" {
  source  = "github.com/riboseinc/terraform-aws-s3-cloudfront-website"
  version = "1.0.1"

  fqdn                = "${var.host}.${var.zone}"
  aliases             = ["${var.aliases}"]
  ssl_certificate_arn = "${aws_acm_certificate_validation.cert.certificate_arn}"
  allowed_ips         = "${var.allowed_ips}"

  index_document = "index.html"
  error_document = "404.html"

  force_destroy = "true"
}

resource "aws_acm_certificate" "cert" {
  provider                  = "aws.cloudfront"
  domain_name               = "${var.host}.${var.zone}"
  subject_alternative_names = ["${var.aliases}"]
  validation_method         = "DNS"
}

resource "aws_route53_record" "cert_validation" {
  count = "${length(var.aliases) + 1}"

  provider = "aws.cloudfront"
  name     = "${element(aws_acm_certificate.cert.domain_validation_options.*.resource_record_name, count.index)}"
  type     = "${element(aws_acm_certificate.cert.domain_validation_options.*.resource_record_type, count.index)}"
  records  = ["${element(aws_acm_certificate.cert.domain_validation_options.*.resource_record_value, count.index)}"]
  zone_id  = "${data.aws_route53_zone.site.id}"
  ttl      = 60
}

resource "aws_acm_certificate_validation" "cert" {
  provider                = "aws.cloudfront"
  certificate_arn         = "${aws_acm_certificate.cert.arn}"
  validation_record_fqdns = ["${aws_route53_record.cert_validation.fqdn}"]
}

# Route 53 record for the static site
data "aws_route53_zone" "site" {
  name         = "${var.zone}"
  private_zone = false
}

resource "aws_route53_record" "web" {
  zone_id = "${data.aws_route53_zone.site.zone_id}"
  name    = "${var.host}.${var.zone}"
  type    = "CNAME"
  ttl     = 1800
  records = ["${module.site.cf_domain_name}"]
}
