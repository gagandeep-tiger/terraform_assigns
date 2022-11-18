variable "admin_username" {
  type = string
  default = "azureuser"
}

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

variable "tag" {
  type = map(string)
  default = {
    "created_by" = "gagandeep.prasad@tigeranalytics.com"
    "created_for" = "terraform-tut"
  }
}
