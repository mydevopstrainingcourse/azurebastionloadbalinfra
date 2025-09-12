data "azurerm_mssql_server" "ankit-dbserver" {
  name                = var.sql_server_name
  resource_group_name = var.resource_group_name
}