module "test_network" {
  source                   = "../../modules/test_network"
  vnet_resource_group_name = var.vnet_resource_group_name
  location                 = var.location
  vnet_name                = var.vnet_name
  address_space            = var.address_space
  dns_servers              = var.dns_servers
  subnets                  = var.subnets
  nsg_rules                = var.nsg_rules
  flat_nsg_rules           = var.flat_nsg_rules
  tags                     = var.tags
  route_table_name         = var.route_table_name

}

module "test_storage" {
  source                    = "../../modules/test_storage"
  resource_group_name       = var.storage_resource_group_name
  container_names           = var.container_names
  location                  = var.location
  managed_identity_id       = var.managed_identity_id
  storage_account_name      = var.storage_account_name
  pe_subnet_id              = var.pe_subnet_id
  owners_principal_id       = var.owners_principal_id
  kv_user_assigned_identity = var.kv_user_assigned_identity
  key_vault_id              = var.key_vault_id
  key_name                  = var.key_name
}

module "test_vm" {
  source                   = "../../modules/test_vm"
  location                 = var.location
  create_vm_resource_group = var.create_vm_resource_group
  vm_resource_group_name   = var.vm_resource_group_name
  subnet_id                = var.vm_subnet_id
  vm_name                  = var.vm_name
  vm_size                  = var.vm_size
  admin_username           = var.admin_username
  private_ip_address       = var.private_ip_address
  image_publisher          = var.image_publisher
  image_offer              = var.image_offer
  image_sku                = var.image_sku
  image_version            = var.image_version
  #disk_encryption_set_id   = var.disk_encryption_set_id
  ssh_key_name        = var.ssh_key_name
  key_vault_id        = var.key_vault_id
  managed_identity_id = var.managed_identity_id
  #tags                = "test"
  vm_subnet_id = "hh"
}
