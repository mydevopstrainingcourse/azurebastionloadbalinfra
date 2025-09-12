variable "resource_group_name" {
  description="The name of the resource group"
  type = string
}

variable "virtual_machine_location" {
  description="The location of the virtual machine"
  type = string
}
variable "vm_name" {
  description="The name of the virtual machine"
  type = string
}
/*variable "key_vault_name" {
  type = string
}*/
variable "admin_username" {
  type = string
}
variable "admin_password" {
  type = string
}

variable "network_interface_name" {
  type        = string
}
variable "publisher" {
  type        = string
}
variable "offer" {
  type        = string
}
variable "sku" {
  type        = string
}

variable "custom_data" {
  type        = string
}
