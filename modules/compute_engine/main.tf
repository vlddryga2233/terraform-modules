


resource "google_compute_instance" "default" {
  name           = var.name
  description    = var.description
  machine_type   = var.machine_type
  zone           = var.zone
  can_ip_forward = var.can_ip_forward
  tags           = var.tags
  boot_disk {
    auto_delete = var.auto_delete

    initialize_params {
      size  = var.disk_size
      image = var.image
    }
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
    dynamic "access_config" {
      for_each = var.access_config
      content {
        nat_ip       = access_config.value.nat_ip
        network_tier = access_config.value.metwork_tier

      }
    }
  }

  metadata_startup_script = var.startup_script

  dynamic "service_account" {
    for_each = [var.service_account]
    content {
      email  = lookup(service_account.value, "email", null)
      scopes = lookup(service_account.value, "scopes", null)
    }
  }


}
