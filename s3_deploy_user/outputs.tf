output "access_key_id" {
  value = module.iam_user.access_key_id
}

output "secret_access_key" {
  value     = module.iam_user.secret_access_key
  sensitive = true
}

