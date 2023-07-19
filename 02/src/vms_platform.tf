### Shared variables 

variable "vm_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "VMs family"
}

variable "vm_name_prefix" {
  type    = string
  default = "netology-develop-platform"
}

variable "vm_ssh" {
  type = map(any)
  default = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIInHww/moi/6QDwuL/lSmFUWOmRS/vCWSXNAjow0eb9H user@ubuntu"
  }
}

### Web VM variables

variable "vm_web_name" {
  type        = string
  default     = "web"
  description = "Web VM name"
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "Web VM platform"
}

variable "vm_web_resources" {
  type = map(any)
  default = {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }
  description = "Web VM resources"
}

### DB VM variables

variable "vm_db_name" {
  type        = string
  default     = "db"
  description = "DB VM name"
}

variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "DB VM platform"
}

variable "vm_db_resources" {
  type = map(any)
  default = {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }
  description = "DB VM resources"
}