output "s3_bucket_arn" {
  # https://github.com/riboseinc/terraform-aws-s3-cloudfront-website/issues/17
  value = "arn:aws:s3:::${var.host}.${var.zone}"
}

output "s3_bucket_id" {
  value = "${module.site.s3_bucket_id}"
}

output "s3_domain" {
  value = "${module.site.s3_website_endpoint}"
}

output "s3_hosted_zone_id" {
  value = "${module.site.s3_hosted_zone_id}"
}

output "cloudfront_domain" {
  value = "${module.site.cf_domain_name}"
}

output "cloudfront_hosted_zone_id" {
  value = "${module.site.cf_hosted_zone_id}"
}

output "cloudfront_distribution_id" {
  value = "${module.site.cf_distribution_id}"
}

output "route53_fqdn" {
  value = "${aws_route53_record.web.fqdn}"
}

output "acm_certificate_arn" {
  value = "${aws_acm_certificate_validation.cert.certificate_arn}"
}
