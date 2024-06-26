terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.35.0"
    }
  }

  required_version = "~> 1.8.0"
}

provider "google" {
  project = "terraform-tutorial-427310"
  region  = "europe-west1"
}

resource "google_compute_instance" "lesson_03" {
  name         = "lesson-03"
  machine_type = "f1-micro"
  zone         = "europe-west1-b"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
  }

  tags = ["lesson-03-instance"]
}
