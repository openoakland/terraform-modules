# VPC Config
variable "vpc_name" {
  description = "VPC for Security"
  default     = "OpenOakland"
}

variable "vpc_cidr_block" {
  description = "IP addressing for Network"
  default     = "10.12.0.0/18"
}

variable "tenancy" {
  description = "tenacy of instances launched in VPC "
  default     = "default"
}

variable "num_availability_zones" {
  description = "How many AWS Availability Zones (AZs) to use."
  default     = "-1"
}

variable "vpc_public_subnet_cidr" {
  description = "CIDR for public subnet"
  type        = map(string)
  default     = {}
}

variable "num_nat_gateways" {
  description = "The number of NAT Gateways to launch for this VPC."
  default     = "1"
}

variable "vpc_private_subnet_cidr" {
  description = "CIDR block for internal subnet"
  type        = map(string)
  default = {
    AZ-0 = "10.12.20.0/23"
    AZ-1 = "10.12.22.0/23"
    AZ-2 = "10.12.24.0/23"
    AZ-3 = "10.12.26.0/23"
    AZ-4 = "10.12.28.0/23"
    AZ-5 = "10.12.30.0/23"
  }
}

variable "private_propagating_vgws" {
  description = "A list of Virtual Gateways that will propagate routes to private subnets."
  type        = list(string)
  default     = []
}

variable "custom_tags" {
  description = "A map of tags to apply to the VPC, Subnets, Route Tables, and Internet Gateway."
  type        = map(string)
  default     = {}
}

