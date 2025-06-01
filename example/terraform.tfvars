region = "us-central1"

project_id = "nw-opstree-dev-landing-zone"

instances = [
  {
    name           = "instance-1"
    zone           = "us-central1-a"
    machine_type   = "e2-medium"
    boot_image     = "debian-cloud/debian-11"
    boot_disk_size = 20
    boot_disk_type = "pd-balanced"
    network        = "default"
    subnetwork     = "default"
    metadata = {
      startup-script = "echo Hello from GCP"
    }
    tags                   = ["frontend"]
    labels                 = { env = "dev" }
    deletion_protection    = false
    enable_public_ip       = true
    static_ip              = null
    service_account_email  = "service-account"
    service_account_scopes = ["cloud-platform"]
    additional_disks       = []
  },
  {
    name           = "instance-2"
    zone           = "us-central1-a"
    machine_type   = "e2-small"
    boot_image     = "debian-cloud/debian-11"
    boot_disk_size = 10
    boot_disk_type = "pd-standard"
    network        = "default"
    subnetwork     = "default"
    metadata = {
      startup-script = "echo Hello from GCP"
    }
    tags                   = ["backend"]
    labels                 = { env = "qa" }
    deletion_protection    = false
    enable_public_ip       = false
    static_ip              = null
    service_account_email  = null
    service_account_scopes = ["cloud-platform"]
    additional_disks       = []
  }
]
