terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.31.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  skip_provider_registration = "true"
  features {}
}

resource "azurerm_resource_group" "mle-cloud-training" {
  name = "mle-cloud-training"
  location = var.location
  tags = {
        " created_by": "anitha.srinivasa"
        " created_for": "MLE Cloud Training"
        "POC": "Sheik Dawood, Bhagirathi Hedge, Senganal"
    }
}