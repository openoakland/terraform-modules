variable "app_name" {
  description = "Slugified name of the beanstalk application."
}

variable "app_instance" {
  description = "Name of this beanstalk environment e.g. (dev, staging, production, etc)."
}

variable "health_check_path" {
  description = "App endpoint to check the health of the instance."
  default     = "/health/"
}

variable "instance_type" {
  description = "EC2 instance type to use for beanstalk instances."
  default     = "t3.micro"
}

variable "dns_zone" {
  description = "DNS zone to use for beanstalk application e.g. aws.example.com"
}

variable "environment_variables" {
  description = "Map of environment variables to set for this beanstalk environment."
  type        = "map"
  default     = {}
}

variable "key_pair" {
  description = "SSH key pair to assign to EC2 instances."
  default     = ""
}

variable "name" {
  description = "Name to use for beanstalk environment and DNS."

  # TODO remove me on major version bump
  default = ""
}

variable "security_groups" {
  description = "List of security groups to attach to Beanstalk instances."
  default     = []
}
