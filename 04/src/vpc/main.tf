resource "yandex_vpc_network" "vpc_net" {
  description = "Create network"
  name = var.vpc_name
}

resource "yandex_vpc_subnet" "vpc_subnet" {
  description = "Create subnet"
  name           = var.vpc_subnet_name
  zone           = var.zone
  network_id     = yandex_vpc_network.vpc_net.id
  v4_cidr_blocks = var.default_cidr
}