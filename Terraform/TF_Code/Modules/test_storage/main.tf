resource "random_string" "resource_code" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_storage_account" "storage_account" {
  name                              = "st${var.storage_account_name}${random_string.resource_code.result}"
  resource_group_name               = var.resource_group_name
  location                          = var.location
  account_tier                      = "Standard"
  account_replication_type          = "LRS"
  allow_nested_items_to_be_public   = false
  public_network_access_enabled     = false
#   enable_https_traffic_only         = true
  infrastructure_encryption_enabled = true
  min_tls_version                   = "TLS1_2"
  blob_properties {
    delete_retention_policy {
      days = 7
    }
  }
  tags = {
    environment = "gm-tma-infra"
  }
  identity {
    type = "UserAssigned"
    identity_ids = [ var.kv_user_assigned_identity]
  }
  lifecycle {
    #prevent_destroy = true
    ignore_changes = [
      tags,
      customer_managed_key
    ]
  }
}

resource "azurerm_storage_account_network_rules" "tfstate_rules" {
  storage_account_id = azurerm_storage_account.storage_account.id
  default_action             = "Deny"
  bypass                     = ["AzureServices"]
  # private_link_access {
  #   endpoint_resource_id =  azurerm_private_endpoint.storage_private_endpoint.id
  # }

  depends_on = [ azurerm_private_endpoint.storage_private_endpoint ]
}

resource "azurerm_storage_container" "containers" {
  count                 = length(var.container_names)
  name                  = "${var.storage_account_name}-${var.container_names[count.index]}"
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "private"
  # lifecycle {
  #   prevent_destroy = true
  # }

  depends_on = [ azurerm_role_assignment.storage_account_owner, azurerm_role_assignment.storage_account_contributor ]
}

resource "azurerm_private_endpoint" "storage_private_endpoint" {
  name                = "pe-${azurerm_storage_account.storage_account.name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.pe_subnet_id

  private_service_connection {
    name                           = "psc-${azurerm_storage_account.storage_account.name}"
    private_connection_resource_id = azurerm_storage_account.storage_account.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  lifecycle {
    #prevent_destroy = true
    ignore_changes = [
      tags,
      private_dns_zone_group
    ]
  }
}

resource "azurerm_role_assignment" "storage_account_contributor" {
  scope                = azurerm_storage_account.storage_account.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = var.managed_identity_id
}

resource "azurerm_role_assignment" "storage_account_owner" {
  scope                = azurerm_storage_account.storage_account.id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = var.owners_principal_id
} 

resource "azurerm_storage_account_customer_managed_key" "cmk" {
  storage_account_id = azurerm_storage_account.storage_account.id
  key_vault_id       = var.key_vault_id
  key_name           = var.key_name
  user_assigned_identity_id = var.kv_user_assigned_identity
}

# resource "azurerm_log_analytics_storage_insights" "storage_account" {
#   name                = "storage_account-storageinsightconfig"
#   resource_group_name = azurerm_resource_group.storage_account.name
#   workspace_id        = azurerm_log_analytics_workspace.storage_account.id
#   storage_account_id  = azurerm_storage_account.storage_account.id
#   storage_account_key = azurerm_storage_account_customer_managed_key.cmk.primary_access_key
# }
