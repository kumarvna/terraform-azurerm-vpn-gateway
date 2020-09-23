module "vpn-gateway" {
  // source  = "kumarvna/vpn-gateway/azurerm"
  // version = "1.0.0"
  source = "../"
  # Resource Group, location, VNet and Subnet details
  resource_group_name  = "rg-shared-westeurope-01"
  virtual_network_name = "vnet-shared-hub-westeurope-001"
  vpn_gateway_name     = "shared-vpn-gw01"
  gateway_type         = "Vpn"
  #vpn_type             = "PolicyBased"
  #vpn_gw_sku           = "Basic"
  #  enable_bgp           = true
  #  bgp_peer_weight      = 0

  # local network gateway connection 
  local_networks = [
    {
      local_gw_name         = "onpremise"
      local_gateway_address = "8.8.8.8"
      local_address_space   = ["10.1.0.0/24"]
      shared_key            = "xpCGkHTBQmDvZK9HnLr7DAvH"
      ipsec_policy = {

      }
    },
  ]

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
