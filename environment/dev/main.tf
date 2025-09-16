module "resource_group" {
  source                  = "../../modules/azurerm_resource_group"
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
}

module "virtual_network" {
  depends_on               = [module.resource_group]
  source                   = "../../modules/azurerm_virtual_network"
  virtual_network_name     = var.virtual_network_name
  virtual_network_location = var.virtual_network_location
  resource_group_name      = var.resource_group_name
  address_space            = var.address_space

}

module "subnet" {
  for_each             = var.subnet_config
  depends_on           = [module.resource_group, module.virtual_network]
  source               = "../../modules/azurerm_subnet"
  subnet_name          = each.value.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = each.value.address_prefixes
}

module "bastion_public_ip" {
  source                  = "../../modules/azurerm_public_ip"
  depends_on              = [module.resource_group]
  public_ip_name          = var.public_ip_name
  resource_group_location = var.resource_group_location
  resource_group_name     = var.resource_group_name
}


module "bastionhost" {
  depends_on           = [module.resource_group, module.virtual_network, module.subnet, module.bastion_public_ip]
  source               = "../../modules/azurerm_bastion_host"
  bastion_name         = "ankitbastion"
  bastion_location     = "northeurope"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  subnet_name          = "AzureBastionSubnet"
  public_ip_name       = var.public_ip_name

}

module "nic" {
  for_each                   = var.nic_config
  source                     = "../../modules/azurerm_nic"
  depends_on                 = [module.resource_group, module.virtual_network, module.subnet]
  nic_name                   = each.value.nic_name
  network_interface_location = var.network_interface_location
  resource_group_name        = var.resource_group_name
  subnet_name                = each.value.subnet_name
  virtual_network_name       = var.virtual_network_name

}

module "network_security_group" {
  for_each                = var.nsg_config
  depends_on              = [module.resource_group, module.virtual_network, module.subnet, module.nic]
  source                  = "../../modules/azurerm_network_security_group"
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
  nsg_name                = each.value.nsg_name

}
module "network_security_group_association" {
  for_each            = var.nsg_config
  depends_on          = [module.resource_group, module.virtual_network, module.subnet, module.nic, module.network_security_group]
  source              = "../../modules/azurerm_network_security_group_association"
  nsg_name            = each.value.nsg_name
  resource_group_name = var.resource_group_name
  nic_name            = each.value.nic_name

}
module "virtual_machine" {
  depends_on             = [module.resource_group, module.virtual_network, module.subnet, module.nic]
  for_each               = var.vm_config
  source                 = "../../modules/azurerm_vm"
  vm_name                = "ankit-${each.key}-vm"
  resource_group_name    = var.resource_group_name
  network_interface_name = each.value.nic_name
  #key_vault_name         = "polaris-key"
  admin_username           = each.value.admin_username
  admin_password           = each.value.admin_password
  virtual_machine_location = var.virtual_machine_location
  publisher                = each.value.publisher
  offer                    = each.value.offer
  sku                      = each.value.sku
  custom_data              = base64encode(each.value.custom_data)
}

module "mysql_server" {
  depends_on          = [module.resource_group, module.virtual_network, module.subnet]
  source              = "../../modules/azurerm_sql_server"
  sql_server_name     = "ankitdb-server"
  resource_group_name = var.resource_group_name
  location            = "northeurope"
  #key_vault_name  = "polaris-key"
  admin_username = "dbAdmin"
  admin_password = "db#1pasS"
}

module "mysql_database" {
  depends_on          = [module.resource_group, module.virtual_network, module.subnet, module.mysql_server]
  source              = "../../modules/azurerm_sql_database"
  sql_database_name   = "ankit-database"
  sql_server_name     = "ankitdb-server"
  resource_group_name = var.resource_group_name
}
#Load Balancer
module "public_ip_loadbalancer" {
  depends_on              = [module.resource_group, module.virtual_network, module.subnet, module.resource_group]
  source                  = "../../modules/azurerm_public_ip"
  public_ip_name          = "loadbal-pip"
  resource_group_location = var.resource_group_location
  resource_group_name     = var.resource_group_name
}

module "loadbalancer" {
  depends_on          = [module.resource_group, module.virtual_machine, module.public_ip_loadbalancer]
  source              = "../../modules/azurerm_loadbalancer"
  loadbal_name        = "Ankit-LoadBalancer"
  loadbal_location    = var.resource_group_location
  resource_group_name = var.resource_group_name
  public_ip           = "loadbal-pip"

}

module "lb_nic_association" {
  for_each              = var.nic_config
  depends_on            = [module.resource_group, module.virtual_machine, module.loadbalancer, module.public_ip_loadbalancer]
  source                = "../../modules/azurerm_nic_lb_association"
  resource_group_name   = var.resource_group_name
  nic_name              = each.value.nic_name
  lb_name               = "Ankit-LoadBalancer"
  backend_pool_name     = "BackEndAddressPool"
  ip_configuration_name = "internal"
}

