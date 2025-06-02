output "instance_self_links" {
  value = [for instance in google_compute_instance.gcp-server : instance.self_link]
}

output "public_ips" {
  description = "Public IP addresses of the GCP VM instances"
  value = [
    for instance in google_compute_instance.gcp-server :
    instance.network_interface[0].access_config[0].nat_ip
    if length(instance.network_interface[0].access_config) > 0
  ]
}
