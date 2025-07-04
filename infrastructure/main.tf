# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.2.4"
}

provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "example" {
  name     = "example-resource-group"
  location = "East US"
}

# Create a storage account
resource "azurerm_storage_account" "example" {
  name                     = "examplestorage${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Generate a random string for unique storage account name
resource "random_string" "suffix" 
{
  length  = 8
  special = false
  upper   = false
}