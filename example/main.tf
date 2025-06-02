module "compute_instance" {
  source             = "./module"
  project_id         = var.project_id
  instances          = var.instances
  default_network    = var.default_network
  default_subnetwork = var.default_subnetwork
}
