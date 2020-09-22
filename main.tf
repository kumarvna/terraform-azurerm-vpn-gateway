#----------------------------------------------------------
# Resource Group, VNet, Subnet selection & Random Resources
#----------------------------------------------------------
data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_subnet" "snet" {
  name                 = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_resource_group.rg.name
}

data "azurerm_log_analytics_workspace" "logws" {
  count               = var.log_analytics_workspace_name != null ? 1 : 0
  name                = var.log_analytics_workspace_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_storage_account" "storeacc" {
  count               = var.hub_storage_account_name != null ? 1 : 0
  name                = var.hub_storage_account_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "random_string" "str" {
  count   = var.enable_public_ip_address == true ? var.instances_count : 0
  length  = 6
  special = false
  upper   = false
  keepers = {
    domain_name_label = var.virtual_machine_name
  }
}

#-----------------------------------
# Public IP for Virtual Machine
#-----------------------------------
resource "azurerm_public_ip" "pip_gw" {
  name                = lower("${var.vpn_gateway_name}-${data.azurerm_resource_group.rg.location}-gw-pip")
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  allocation_method   = var.public_ip_allocation_method
  sku                 = var.public_ip_sku
  domain_name_label   = format("gw%s%s", lower(replace(var.vpn_gateway_name, "/[[:^alnum:]]/", "")), random_string.str[count.index].result)
  tags                = merge({ "ResourceName" = lower("${var.vpn_gateway_name}-${data.azurerm_resource_group.rg.location}-gw-pip") }, var.tags, )
}


resource "azurerm_public_ip" "pip_aa" {
  name                = lower("${var.vpn_gateway_name}-${data.azurerm_resource_group.rg.location}-gw-aa-pip")
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = format("gwaa%s%s", lower(replace(var.vpn_gateway_name, "/[[:^alnum:]]/", "")), random_string.str[count.index].result)
  tags                = merge({ "ResourceName" = lower("${var.vpn_gateway_name}-${data.azurerm_resource_group.rg.location}-gw-aa-pip") }, var.tags, )
}

