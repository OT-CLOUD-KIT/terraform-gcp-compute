module "compute_instance" {
  source     = "./module"
  project_id = var.project_id
  instances  = var.instances
}
