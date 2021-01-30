resource "google_service_account" "default" {
  account_id   = "vscode-server"
  display_name = "VScode"
}
data "google_compute_zones" "available" {
}

data "google_compute_network" "default" {
  name = var.network_name
}

resource "google_compute_firewall" "default" {
  name    = "vscode-server"
  network = data.google_compute_network.default.name


  allow {
    protocol = "tcp"
    ports    = ["443", "22"]
  }

  target_service_accounts = [google_service_account.default.email]
}

resource "google_compute_instance" "default" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = data.google_compute_zones.available.names[0]


  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
      type  = "pd-ssd"
      size  = 20
    }
  }

  network_interface {
    subnetwork = data.google_compute_network.default.subnetworks_self_links[0]
    # network = "second"

    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    service_name = "VScode-server"
    ssh-keys     = "${var.gce_ssh_user}:${file(var.gce_ssh_pub_key_file)}"
  }


  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}