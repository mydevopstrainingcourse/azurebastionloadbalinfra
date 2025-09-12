variable "resource_group_name" {
  description = "The name of the resource group."
  type = string
  
}
variable "nic_name" {
  description = "The name of the nic."
  type = string
}
variable "network_interface_location" {
  description = "The location of the nic."
  type = string
}

variable "subnet_name" {
  description = "The name of the subnet."
  type = string
}
variable "virtual_network_name" {
  description = "The name of the virtual network."
  type = string
}