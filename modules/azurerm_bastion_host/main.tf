resource "azurerm_bastion_host" "ankitbastion" {
  name                = var.bastion_name
  location            = var.bastion_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = data.azurerm_subnet.mysubnet.id
    public_ip_address_id = data.azurerm_public_ip.mypublicip.id
  }
}


