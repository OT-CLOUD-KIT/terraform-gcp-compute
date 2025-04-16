variable "project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "instances" {
  type = list(object({
    name                   = string
    zone                   = string
    machine_type           = string
    boot_image             = string
    boot_disk_size         = number
    network                = string
    subnetwork             = string
    metadata               = map(string)
    tags                   = list(string)
    labels                 = optional(map(string), {})
    deletion_protection    = optional(bool, false)
    static_ip              = optional(string)
    service_account_email  = optional(string)
    service_account_scopes = optional(list(string), ["cloud-platform"])
    additional_disks = optional(list(object({
      source      = string
      device_name = string
    })), [])
  }))
  description = "List of instance configurations"
}
