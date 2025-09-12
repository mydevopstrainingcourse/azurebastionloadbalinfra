variable "loadbal_name" {
  description = "The name of the load balancer"
  type = string
}
variable "loadbal_location" {
  description = "The location of the load balancer"
  type = string  
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type = string
}
variable "public_ip" {
  description = "The name of the public ip"
  type = string  
}