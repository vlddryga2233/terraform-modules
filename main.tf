provider "google" {
  project     = var.project
  zone        = var.zone
  region      = var.region
  credentials = var.credentials
}

data "google_compute_image" "my_image" {
  family  = "debian-10"
  project = "debian-cloud"
}

resource "google_service_account" "default" {
  account_id   = "service-account-id"
  display_name = "Service Account"
}

module "instance" {
  source = "./modules/compute_engine"

  name         = "instance"
  machine_type = "n1-standard-4"
  disk_size    = 10
  image        = data.google_compute_image.my_image.self_link
  service_account = {
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}

module "template" {
  source = "./modules/instance_template"

  name         = "template"
  machine_type = "n1-standard-4"
  image        = data.google_compute_image.my_image.self_link
  service_account = {
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}
