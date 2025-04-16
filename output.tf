output "instance_self_links" {
  description = "List of self-links for the created Compute Engine instances"
  value = [for instance in google_compute_instance.gcp-server : instance.self_link]
}
