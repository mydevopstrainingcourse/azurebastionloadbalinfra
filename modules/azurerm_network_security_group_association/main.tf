resource "azurerm_network_interface_security_group_association" "nsgassociation" {
  network_interface_id      = data.azurerm_network_interface.mydatanic.id
  network_security_group_id = data.azurerm_network_security_group.mydatansg.id

}