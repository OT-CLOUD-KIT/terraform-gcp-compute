## Terraform GCP Compute-Instance

[![Opstree Solutions][opstree_avatar]][opstree_homepage]<br/>[Opstree Solutions][opstree_homepage] 

  [opstree_homepage]: https://opstree.github.io/
  [opstree_avatar]: https://img.cloudposse.com/150x150/https://github.com/opstree.png

This Terraform resource creates one or more Google Compute Engine (GCE) VM instances using the list provided in `var.instances`.

Each instance supports custom configuration, including:
- Boot disk (size, type, image)
- Additional attached disks
- Network and subnetwork configuration
- Static or dynamic public IP allocation
- Service account with defined scopes
- Metadata, labels, and deletion protection

### Network/Subnetwork Logic:
The `network_interface` block uses conditional logic to support both per-instance and shared networking configurations:

- If the instance object contains non-empty `network` and `subnetwork` values, those are used.
- Otherwise, it falls back to `var.default_network` and `var.default_subnetwork`.

This allows:
- Flexible use of **custom network/subnetwork per instance**, or
- A **common shared network** for all instances using `default_*` values.

### Data Block Integration:
If the network or subnetwork is managed by a separate module or already exists (outside this module), you can use Terraform `data` blocks to fetch their self-links like this:

```hcl
default_network = data.google_compute_network.default.self_link
default_network = data.google_compute_subnetwork.default.self_link

```


## Architecture

<img width="600" length="800" alt="Terraform" src="https://github.com/user-attachments/assets/e3708463-f7f7-4966-863d-12d50f836ab3">


## Providers

| Name                                              | Version  |
|---------------------------------------------------|----------|
| <a name="provider_gcp"></a> [gcp](#provider\_gcp) | 5.0.0   |

## Usage

```hcl
module "compute_instance" {
  source             = "./module"
  project_id         = var.project_id
  instances          = var.instances
  default_network    = var.default_network
  default_subnetwork = var.default_subnetwork
}

# Variable values

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

```

## Inputs

| Name | Description | Type | Default | Required | 
|------|-------------|:----:|---------|:--------:|
|**project_id**| The ID of the project for which the Compute resource is to be configured | string | { } | yes| 
|**instances**| List of instance configurations | list(object) | [ ] | yes | 
|**default_network**| Global network to use if not provided in instance | string | { } | yes| 
|**default_subnetwork**| Global subnetwork to use if not provided in instance | list(object) | { } | yes | 

## Output
| Name | Description |
|------|-------------|
|**instance_self_links**| List of self-links for the created Compute Engine instances | 
|**public_ips**| Public IP addresses of the GCP VM instances | 
                                                                                                                  
