data "azurerm_network_interface" "mydatanic" {
  name                = var.nic_name
  resource_group_name = var.resource_group_name
}
data "azurerm_network_security_group" "mydatansg" {
  name                = var.nsg_name
  resource_group_name = var.resource_group_name
}