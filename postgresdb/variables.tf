variable "namespace" {
  description = "Name to help identify database resources, e.g. app-production."
}

variable "db_engine_version" {
  description = "Engine version for the database."
  default     = "10.6"
}

variable "db_name" {
  description = "Name of the RDS database to create for the application."
}

variable "db_username" {
  description = "RDS username to create for the application."
}

variable "db_password" {
  description = "RDS password to create for the application."
}

variable "deletion_protection" {
  description = "Enable deletion protection."
  default     = true
}

variable "security_groups_allowed" {
  description = "Security groups allowed to access the database."
  default     = []
}

variable "skip_final_snapshot" {
  description = "Disable final snapshot creation on deletion."
  default     = false
}

