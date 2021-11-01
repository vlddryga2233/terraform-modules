

resource "google_compute_instance_template" "default" {
  name                    = var.name
  description             = var.description
  tags                    = var.tags
  instance_description    = var.instance_description
  machine_type            = var.machine_type
  can_ip_forward          = var.can_ip_forward
  metadata_startup_script = var.startup_script
  disk {
    source_image = var.image
    auto_delete  = var.auto_delete
    boot         = var.boot
  }
  network_interface {
    network = var.network
    dynamic "access_config" {
      for_each = var.access_config
      content {
        nat_ip       = access_config.value.nat_ip
        network_tier = access_config.value.metwork_tier
      }
    }
  }
  dynamic "service_account" {
    for_each = [var.service_account]
    content {
      email  = lookup(service_account.value, "email", null)
      scopes = lookup(service_account.value, "scopes", null)
    }
  }
}
