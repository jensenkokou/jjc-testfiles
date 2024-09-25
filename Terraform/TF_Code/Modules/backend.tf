/* terraform {
  backend "azurerm" {
    resource_group_name  = var.resource_group_name       # Can be passed via `-backend-config=`"resource_group_name=<resource group name>"` in the `init` command.
    storage_account_name = var.storage_account_name                           # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "mdatfstate"                               # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                  = "prod.terraform.tfstate"                # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
    use_msi              = true                                    # Can also be set via `ARM_USE_MSI` environment variable.
    client_id            = "00000000-0000-0000-0000-000000000000"  # Can also be set via `ARM_CLIENT_ID` environment variable.
    subscription_id      = "00000000-0000-0000-0000-000000000000"  # Can also be set via `ARM_SUBSCRIPTION_ID` environment variable.
    tenant_id            = "00000000-0000-0000-0000-000000000000"  # Can also be set via `ARM_TENANT_ID` environment variable.
  }
}


 We will make the bottom 4 enviromental varibales. 


\*
