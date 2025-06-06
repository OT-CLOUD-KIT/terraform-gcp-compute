resource "google_compute_instance" "gcp-server" {
  count        = length(var.instances)
  name         = var.instances[count.index].name
  machine_type = var.instances[count.index].machine_type
  zone         = var.instances[count.index].zone
  tags         = var.instances[count.index].tags
  project      = var.project_id

  boot_disk {
    initialize_params {
      image = var.instances[count.index].boot_image
      size  = var.instances[count.index].boot_disk_size
      type  = var.instances[count.index].boot_disk_type
    }
  }

  network_interface {
    network    = length(trim(var.instances[count.index].network, " ")) > 0 ? var.instances[count.index].network : var.default_network
    subnetwork = length(trim(var.instances[count.index].subnetwork, " ")) > 0 ? var.instances[count.index].subnetwork : var.default_subnetwork

    dynamic "access_config" {
      for_each = var.instances[count.index].enable_public_ip ? [1] : []
      content {
        nat_ip = var.instances[count.index].static_ip
      }
    }
  }

  dynamic "attached_disk" {
    for_each = var.instances[count.index].additional_disks
    content {
      source      = attached_disk.value.source
      device_name = attached_disk.value.device_name
    }
  }

  service_account {
    email  = var.instances[count.index].service_account_email
    scopes = var.instances[count.index].service_account_scopes
  }

  metadata            = var.instances[count.index].metadata
  labels              = var.instances[count.index].labels
  deletion_protection = var.instances[count.index].deletion_protection
}
