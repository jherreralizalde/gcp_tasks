terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  #  credentials = file("miprimerproyecto-333317-3209bff7c059.json")

  project = "miprimerproyecto-333317"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_network" "vpc_network" {
  project                 = "miprimerproyecto-333317"
  name                    = "new-network"
  auto_create_subnetworks = false
}
resource "google_compute_subnetwork" "new_subnetwork" {
  project       = "miprimerproyecto-333317"
  name          = "new-network-subnetwork"
  ip_cidr_range = "10.0.1.0/24"
  region        = "us-central1"
  network       = google_compute_network.vpc_network.self_link
  secondary_ip_range {
    range_name    = "new-network-publick-subnetwork"
    ip_cidr_range = "192.168.20.0/24"
  }
  depends_on = [
    google_compute_network.vpc_network
  ]
}

resource "google_compute_firewall" "test_fw" {
  name    = "test-firewall"
  network = google_compute_network.vpc_network.name
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["22", "80", "8080", "1000-2000"]
  }
  source_ranges = ["35.235.240.0/20"]
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance-ubuntu"
  machine_type = "e2-standard-2"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.new_subnetwork.name
    access_config {
    }
  }
  metadata = {
    startup-script = file("${path.module}/startup.sh")
  }
}


