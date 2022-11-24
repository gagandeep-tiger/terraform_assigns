variable "location" {
  type = string
  default = "eastus"
}

variable "prefix" {
  type = string
  default = "ag-demo"
}

variable "ssh-source-address" {
  type = string
  default = "*"
}

variable "tags" {
  type = map(string)
  default = {
    "created_by" = "gagandeep.prasad@tigeranalytics.com"
    "created_for" = "terraform-tut"
  }
}

variable "rg-tags" {
  type = map(string)
  default = {
    "created_by" = "gagandeep.prasad@tigeranalytics.com"
    "created_for" = "terraform-tut"
  }
}