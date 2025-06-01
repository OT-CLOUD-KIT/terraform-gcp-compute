## Terraform GCP Compute-Instance

[![Opstree Solutions][opstree_avatar]][opstree_homepage]<br/>[Opstree Solutions][opstree_homepage] 

  [opstree_homepage]: https://opstree.github.io/
  [opstree_avatar]: https://img.cloudposse.com/150x150/https://github.com/opstree.png

This Terraform resource creates one or more Google Compute Engine VM instances using a list defined in var.instances. Each instance can have customized properties like boot disk, additional attached disks, network settings, service account, metadata, labels, and deletion protection. 

## Architecture

<img width="600" length="800" alt="Terraform" src="https://github.com/user-attachments/assets/e3708463-f7f7-4966-863d-12d50f836ab3">


## Providers

| Name                                              | Version  |
|---------------------------------------------------|----------|
| <a name="provider_gcp"></a> [gcp](#provider\_gcp) | 5.0.0   |

## Usage

```hcl
module "compute_instance" {
  source     = "./module"
  project_id = var.project_id
  instances  = var.instances
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

## Output
| Name | Description |
|------|-------------|
|**instance_self_links**| List of self-links for the created Compute Engine instances | 
                                                                                                                  
