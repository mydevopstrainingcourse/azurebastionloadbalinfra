
resource "azurerm_mssql_database" "ankit-db" {
  name         = var.sql_database_name
  server_id    = data.azurerm_mssql_server.ankit-dbserver.id
  max_size_gb  = 2
  sku_name     = "S0"
  enclave_type = "VBS"

}
