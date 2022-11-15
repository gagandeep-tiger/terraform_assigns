variable "location" {
  type = string
  default = "eastus"
}

variable "prefix" {
  type = string
  default = "demo"
}

variable "ssh-source-address" {
  type = string
  default = "*"
}