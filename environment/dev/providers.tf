
terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.32.0"
    }
  }

}

provider "azurerm" {
  features {}
  subscription_id = "c3408e32-e222-42c2-8c6d-9edc55d79da8"

}
