resource "google_compute_instance" "lesson_05" {
  name         = "lesson-05"
  machine_type = "f1-micro"
  zone         = "europe-west1-b"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    ssh-keys = "sergio:${file("../keys/google_key.pub")}"
  }
}


