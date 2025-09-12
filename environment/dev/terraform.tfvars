resource_group_name      = "ankit_devrg_lb_bas"
resource_group_location  = "northeurope"
virtual_network_name     = "ankit_vnet"
virtual_network_location = "northeurope"
address_space            = ["192.168.0.0/16"]
subnet_config = {
  "frontend" = {
    subnet_name      = "ankit_subnet_frontend"
    address_prefixes = ["192.168.1.0/24"]
  }
  "backend" = {
    subnet_name      = "ankit_subnet_backend"
    address_prefixes = ["192.168.2.0/24"]
  }
  "bastion" = {
    subnet_name      = "AzureBastionSubnet"
    address_prefixes = ["192.168.3.0/26"]
  }
}
public_ip_name = "bastionpublicip"
nic_config = {
  "frontend1" = {
    nic_name    = "nic-frontend1"
    subnet_name = "ankit_subnet_frontend"
  }
  "frontend2" = {
    nic_name    = "nic-frontend2"
    subnet_name = "ankit_subnet_frontend"
  }

  "backend" = {
    nic_name    = "nic-backend"
    subnet_name = "ankit_subnet_backend"
  }
}
network_interface_location = "northeurope"

vm_config = {
  "frontend1" = {
    nic_name       = "nic-frontend1"
    admin_username = "frontendAdmin"
    admin_password = "frontend#1Pass"
    publisher      = "Canonical"
    offer          = "0001-com-ubuntu-server-jammy"
    sku            = "22_04-lts"
    custom_data    = <<-EOF
        #!/bin/bash
        sudo apt update
        sudo apt install -y nginx
        sudo systemctl enable nginx
        sudo systemctl start nginx
      EOF
  }

  "frontend2" = {
    nic_name       = "nic-frontend2"
    admin_username = "frontendAdmin"
    admin_password = "frontend#1Pass"
    publisher      = "Canonical"
    offer          = "0001-com-ubuntu-server-jammy"
    sku            = "22_04-lts"
    custom_data    = <<-EOF
        #!/bin/bash
        sudo apt update
        sudo apt install -y nginx
        sudo systemctl enable nginx
        sudo systemctl start nginx
      EOF
  }


  "backend" = {
    nic_name       = "nic-backend"
    admin_username = "backendAdmin"
    admin_password = "backend#1Pass"
    publisher      = "Canonical"
    offer          = "0001-com-ubuntu-server-focal"
    sku            = "20_04-lts"
    custom_data    = <<-EOF
        #!/bin/bash
        sudo apt update
        sudo apt install -y python3 python3-pip
      EOF

  }
}
virtual_machine_location = "northeurope"