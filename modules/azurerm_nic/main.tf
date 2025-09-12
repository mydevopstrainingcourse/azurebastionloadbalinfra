
resource "azurerm_network_interface" "mynic" {
  name                = var.nic_name
  location            = var.network_interface_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.mynicsubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}
