resource "google_compute_instance" "default" {
  
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone

  tags = var.tags
  allow_stopping_for_update = var.allow_stopping_for_update
  can_ip_forward = var.can_ip_forward
  description = var.description
  desired_status = var.desired_status
  deletion_protection = var.deletion_protection
  guest_accelerator = var.guest_accelerator
  labels = var.labels

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "NVME"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = var.metadata_startup_script

  

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = var.service_account_email
    scopes = ["cloud-platform"]
  }
}