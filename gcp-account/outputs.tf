output "private_key_file" {
  sensitive = true
  value     = google_service_account_key.packer.private_key_encrypted
}

