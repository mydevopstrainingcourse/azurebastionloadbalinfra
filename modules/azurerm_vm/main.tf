resource "azurerm_linux_virtual_machine" "ankit_linux_vm" {
  name                            = var.vm_name
  resource_group_name             = var.resource_group_name
  location                        = var.virtual_machine_location
  size                            = "Standard_B1s"
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = false
  network_interface_ids = [
    data.azurerm_network_interface.ankit_nic.id
  ]


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = "latest"
  }
   custom_data = var.custom_data
}