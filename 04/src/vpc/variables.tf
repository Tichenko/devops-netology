variable "vpc_name" {
  type    = string
  default = "vpc-net"
}

variable "vpc_subnet_name" {
  type = string
  default = "vpc-subnet"
}

variable "zone" {
  type = string
} 

variable "default_cidr" {
  type = list(string)
  default = ["10.0.1.0/24"]
}