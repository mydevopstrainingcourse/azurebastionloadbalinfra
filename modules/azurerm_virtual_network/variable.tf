variable "resource_group_name" {
  description = "The name of the resource group."
  type = string
  
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