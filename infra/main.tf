# End-to-end test of IaC Pipeline Planner: one network security group per environment.

terraform {
  required_version = ">= 1.10"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
}

variable "environment" {
  type = string
}

variable "resource_group_name" {
  type = string
}

data "azurerm_resource_group" "workload" {
  name = var.resource_group_name
}

resource "azurerm_network_security_group" "test" {
  name                = "e2e-${var.environment}-eus2-01-nsg"
  resource_group_name = data.azurerm_resource_group.workload.name
  location            = data.azurerm_resource_group.workload.location

  tags = {
    purpose = "iac-pipeline-planner end-to-end test"
  }
}

output "nsg_id" {
  value = azurerm_network_security_group.test.id
}
