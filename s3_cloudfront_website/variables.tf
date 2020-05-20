variable "host" {
  description = "The host name of the resulting S3 website (the part of the domain excluding the zone)."
}

variable "zone" {
  description = "The zone to host this site."
  default     = "aws.openoakland.org"
}

# NOTE: These aliases will be added as Subject Alternate Names (SAN's) for the
# TLS certificate that is created for the site. You will need to create the DNS
# records that the Amazon console tells you to during the initial `terraform
# apply`.
variable "aliases" {
  description = "The other domain names at which the site is accessible."
  type        = list(string)
  default     = []
}

# Allowed IPs that can directly access the S3 bucket
variable "allowed_ips" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

