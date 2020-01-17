output "database_url" {
  description = "DATABASE_URL to configure for applications to use this database."
  value       = "postgresql://${var.db_username}:${var.db_password}@${aws_db_instance.database.endpoint}/${var.db_name}"
}

output "postgis_database_url" {
  description = "DATABASE_URL to configure for applications to use this database, with postgis:// prefix."
  value       = "postgis://${var.db_username}:${var.db_password}@${aws_db_instance.database.endpoint}/${var.db_name}"
}

output "security_group_id" {
  description = "Id of the security group with access to database."
  value       = aws_security_group.allowed.id
}

output "security_group_name" {
  description = "Name of the security group with access to database."
  value       = aws_security_group.allowed.name
}

