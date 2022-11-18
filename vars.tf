variable "location" {
  type = string
  default = "eastus"
}

variable "prefix" {
  type = string
  default = "autoscaling"
}

variable "ssh-source-address" {
  type = string
  default = "*"
}
