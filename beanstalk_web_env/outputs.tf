output "cname" {
  description = "CNAME of the created Beanstalk environment."
  value       = aws_elastic_beanstalk_environment.environment.cname
}

output "fqdn" {
  description = "Public FQDN of the created Beanstalk environment."
  value       = aws_route53_record.environment.fqdn
}

