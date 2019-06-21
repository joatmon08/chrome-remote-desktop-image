data "google_compute_zones" "available" {
  status = "UP"
}

locals {
  hostname = "${var.prefix}-${data.google_compute_zones.available.names[0]}"
}

resource "google_compute_instance" "default" {
  name         = local.hostname
  machine_type = var.machine_type
  zone         = data.google_compute_zones.available.names[0]

  tags = [var.prefix]

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network = "default"

    access_config {}
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }

  metadata = {
    sshKeys = "${var.crd_user}:${file(var.public_key_file)}"
  }

  provisioner "local-exec" {
    command = "gcloud compute ssh --zone ${data.google_compute_zones.available.names[0]} ${var.crd_user}@${local.hostname} --command 'DISPLAY= /opt/google/chrome-remote-desktop/start-host --code=\"${var.crd_code}\" --redirect-url=\"https://remotedesktop.google.com/_/oauthredirect\" --name=${local.hostname} --pin=${var.crd_pin}'"
  }
}