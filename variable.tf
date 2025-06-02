variable "project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "default_network" {
  type        = string
  description = "Global network to use if not provided in instance"
  default     = null
}

variable "default_subnetwork" {
  type        = string
  default     = null
  description = "Global subnetwork to use if not provided in instance"
}

variable "instances" {
  type = list(object({
    name                   = string
    zone                   = string
    machine_type           = string
    boot_image             = string
    boot_disk_size         = number
    boot_disk_type         = optional(string, "pd-standard") # default value can be given
    network                = string
    subnetwork             = string
    metadata               = map(string)
    tags                   = list(string)
    labels                 = optional(map(string), {})
    deletion_protection    = optional(bool, false)
    enable_public_ip       = optional(bool, true)
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
