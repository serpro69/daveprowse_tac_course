terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.35.0"
    }
  }

  required_version = "~> 1.8.0"
}

variable "default_network" { 
  type = string
  default = "default"
  description = "Default network name"
}

provider "google" {
  project = "terraform-tutorial-427310"
  region  = "europe-west1"
}

resource "google_compute_instance" "lesson_04" {
  name         = "lesson-04"
  machine_type = "f1-micro"
  zone         = "europe-west1-b"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = var.default_network

    access_config {
      // Ephemeral public IP
    }
  }

  tags = ["lesson-04"]

  metadata = {
    ssh-keys = "sergio:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOgnDSTjuUfFnpZFqDESNvIIWsDEMTEOd00Z1+Y2JjI3 serpro@disroot.org"
  }
}

# Ingress rule for SSH
resource "google_compute_firewall" "fw_ssh_ingress" {
  name    = "fw-ssh-ingress"
  network = var.default_network

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]

  target_tags = ["lesson-04"]
}

# Egress rule for all protocols (includes HTTPS and SSH)
resource "google_compute_firewall" "fw_egress" {
  name    = "fw-egress"
  network = "default"

  allow {
    protocol = "all"
    ports    = []
  }

  destination_ranges = ["0.0.0.0/0"]
  source_tags = ["lesson-04"]
}

