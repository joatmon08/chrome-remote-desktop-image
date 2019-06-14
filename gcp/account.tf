resource "google_service_account" "packer" {
  account_id   = "packer-builder"
  display_name = "packer-builder"
}

resource "google_service_account_key" "packer" {
  service_account_id = google_service_account.packer.name
  pgp_key            = var.pgp_key
  public_key_type    = "TYPE_X509_PEM_FILE"
}

resource "google_project_iam_member" "packer" {
  project = var.project
  role    = "roles/compute.admin"
  member  = "serviceAccount:${google_service_account.packer.email}"
}