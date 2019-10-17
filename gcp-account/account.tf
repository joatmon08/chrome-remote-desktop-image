resource "google_service_account" "packer" {
  account_id   = "packer-builder"
  display_name = "packer-builder"
}

resource "google_service_account_key" "packer" {
  service_account_id = google_service_account.packer.name
  pgp_key            = var.pgp_key
  public_key_type    = "TYPE_X509_PEM_FILE"
}

resource "google_project_iam_member" "compute_instance_admin" {
  project = var.project
  role    = "roles/compute.instanceAdmin.v1"
  member  = "serviceAccount:${google_service_account.packer.email}"
}

resource "google_project_iam_member" "service_account_user" {
  project = var.project
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.packer.email}"
}