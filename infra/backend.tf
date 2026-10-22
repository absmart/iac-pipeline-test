terraform {
  # Filled in by the pipeline: -backend-config with the storage account, container and key.
  backend "azurerm" {}
}
