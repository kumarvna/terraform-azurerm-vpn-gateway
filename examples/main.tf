module "vpn-gateway" {
  // source  = "kumarvna/vpn-gateway/azurerm"
  // version = "1.0.0"
  source = "../"
  # Resource Group, location, VNet and Subnet details
  resource_group_name  = "rg-demo-westeurope-01"
  virtual_network_name = "vnet-demo-westeurope-001"
  vpn_gateway_name     = "demo-vpn-gw-share"
  gateway_type         = "Vpn"
  #  vpn_gw_sku           = "Basic"
  enable_active_active = true
  enable_bgp           = true


  # (Optional) To enable Azure Monitoring and install log analytics agents
  #  log_analytics_workspace_name = var.log_analytics_workspace_id
  #  hub_storage_account_name     = var.hub_storage_account_id

  # Adding TAG's to your Azure resources (Required)
  tags = {
    ProjectName  = "demo-internal"
    Env          = "dev"
    Owner        = "user@example.com"
    BusinessUnit = "CORP"
    ServiceClass = "Gold"
  }
}
