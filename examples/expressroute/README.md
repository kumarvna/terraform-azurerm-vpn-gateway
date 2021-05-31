# Virtual Network Gateway creation example

Terraform module to create a Virtual Network Gateway to send encrypted traffic between an Azure virtual network and an on-premises location over the public Internet. Supports both VPN and ExpressRoute gateway types. VPN configuration supports ExpressRoute (private connection), Site-to-Site and Multi-Site (IPsec/IKE VPN tunnel). Optional active-active mode and point-to-site supported as well.

## Module Usage

```hcl
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
```

## Terraform Usage

To run this example you need to execute following Terraform commands

```hcl
terraform init
terraform plan
terraform apply

```

Run `terraform destroy` when you don't need these resources.

## Outputs

Name | Description
---- | -----------
`vpn_gateway_id`|The resource ID of the virtual network gateway
`vpn_gateway_public_ip`|The public IP of the virtual network gateway
`vpn_gateway_public_ip_fqdn`|Fully qualified domain name of the virtual network gateway
