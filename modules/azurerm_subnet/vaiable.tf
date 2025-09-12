variable "resource_group_name" {
  description = "The name of the resource group."
  type = string
  
}
variable "subnet_name" {
  description = "The name of the subnet."
  type = string
  
}
variable "virtual_network_name" {
  description = "The name of the virtual network"
  type        = string
}
variable "address_prefixes" {
  description = "The name of the address prefixes"
  type = list(string)
}
