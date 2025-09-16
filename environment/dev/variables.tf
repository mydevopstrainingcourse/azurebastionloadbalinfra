variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string

}
variable "resource_group_location" {
  description = "The location of the resource group."
  type        = string
}
variable "virtual_network_name" {
  description = "The name of the virtual network"
  type        = string
}
variable "virtual_network_location" {
  description = "The location of the Virtual Network."
  type        = string
}
variable "address_space" {
  description = "Address space for Virtual Network."
  type        = list(string)
}

variable "subnet_config" {
  description = "Subnet configuration"
  type        = map(any)

}
variable "public_ip_name" {
  description = "The public ip of the network"
  type        = string
}

variable "nic_config" {
  type = map(any)

}

variable "network_interface_location" {
  description = "The location of the network interface"
  type        = string
}
variable "vm_config" {
  type = map(any)

}
variable "virtual_machine_location" {
  description = "The location of the virtual machine"
  type        = string
}
variable "nsg_config" {
  type = map(any)

}