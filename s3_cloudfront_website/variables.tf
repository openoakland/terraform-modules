variable "host" {
  description = "The host name of the resulting S3 website (the part of the domain excluding the zone)."
}

variable "zone" {
  description = "The zone to host this site."
  default     = "aws.openoakland.org"
}

# Allowed IPs that can directly access the S3 bucket
variable "allowed_ips" {
  type    = list(string)
  default = ["0.0.0.0/0"]
}

