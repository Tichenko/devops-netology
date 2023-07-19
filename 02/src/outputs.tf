output "output" {
  value = {
    "web" = "${yandex_compute_instance.web.network_interface[0].nat_ip_address}"
    "db"  = "${yandex_compute_instance.db.network_interface[0].nat_ip_address}"
  }
}