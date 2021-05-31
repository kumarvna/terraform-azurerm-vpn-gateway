module "vpn-gateway" {
  source  = "kumarvna/vpn-gateway/azurerm"
  version = "1.1.0"

  # Resource Group, location, VNet and Subnet details
  resource_group_name  = "rg-shared-westeurope-01"
  virtual_network_name = "vnet-shared-hub-westeurope-001"
  vpn_gateway_name     = "shared-vpn-gw01"
  gateway_type         = "ExpressRoute"
  vpn_gw_generation    = "None"

  # ExpressRoute parameters i.e. when type is ExpressRoute
  # The Express Route Circuit can be in the same or in a different subscription
  gateway_connection_type  = "ExpressRoute"
  express_route_circuit_id = var.express_route_circuit_id

  # Adding TAG's to your Azure resources (Required)
  tags = {
    ProjectName  = "demo-internal"
    Env          = "dev"
    Owner        = "user@example.com"
    BusinessUnit = "CORP"
    ServiceClass = "Gold"
  }
}
