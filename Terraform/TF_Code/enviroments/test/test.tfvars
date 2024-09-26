location                 = "USGOV Virginia"
vnet_resource_group_name = "dev_vnet_rg"
vnet_name                = "dev-vnet"
address_space            = ["10.0.0.0/16"]
dns_servers              = ["10.0.0.4", "10.0.0.5"]
subnets = {
  subnet1 = {
    name           = "dev-subnet"
    address_prefix = "10.0.1.0/24"
  }
}
nsg_rules = {
  allow_ssh = {
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "TCP"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
flat_nsg_rules = []
tags = {
  Environment = "Dev"
}
route_table_name            = "dev-route-table"
storage_resource_group_name = "dev_storage_rg"
container_names             = ["container1", "container2"]
storage_subnet_id           = "subnet-dev-storage"
managed_identity_id         = "dev-managed-identity-id"
storage_account_name        = "devstorageaccount"
pe_subnet_id                = "dev-pe-subnet-id"
user_assigned_identity_id   = "dev-user-assigned-identity-id"
owners_principal_id         = "dev-owner-principal-id"
kv_user_assigned_identity   = "dev-kv-identity-id"
key_vault_id                = "dev-key-vault-id"
key_name                    = "dev-storage-key"
create_vm_resource_group    = true
vm_resource_group_name      = "dev_vm_rg"
vm_subnet_id                = "subnet-dev-vm"
vm_name                     = "dev-vm"
vm_size                     = "Standard_DS2_v2"
admin_username              = "adminuser"
private_ip_address          = "10.0.1.5"
image_publisher             = "Canonical"
