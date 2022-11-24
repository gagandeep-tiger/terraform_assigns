variable "location" {
  type = string
  default = "eastus"
}

variable "prefix" {
  type = string
  default = "nsg-demo"
}

variable "ssh-source-address" {
  type = string
  default = "*"
}

variable "rg-tags" {
  type = map(string)
  default = {
    "created_by" = "gagandeep.prasad@tigeranalytics.com"
    "created_for" = "terraform-tut"
  }
}

variable "tags" {
  type = map(string)
  default = {
    "created_by" = "gagandeep.prasad@tigeranalytics.com"
    "created_for" = "terraform-tut"
  }
}