# Virtual Network Gateway creation example

Terraform module to create a Virtual Network Gateway to send encrypted traffic between an Azure virtual network and an on-premises location over the public Internet. Supports both VPN and ExpressRoute gateway types. VPN configuration supports ExpressRoute (private connection), Site-to-Site and Multi-Site (IPsec/IKE VPN tunnel). Optional active-active mode and point-to-site supported as well.

## Module Usage

### ExpressRoute VPN Gateway (private connection)

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

### Site-to-Site VPN Gateway (IPsec/IKE VPN tunnel)

```hcl
module "vpn-gateway" {
  source  = "kumarvna/vpn-gateway/azurerm"
  version = "1.1.0"

  # Resource Group, location, VNet and Subnet details
  # IPSec Site-to-Site connection configuration requirements
  resource_group_name  = "rg-shared-westeurope-01"
  virtual_network_name = "vnet-shared-hub-westeurope-001"
  vpn_gateway_name     = "shared-vpn-gw01"
  gateway_type         = "Vpn"

  # local network gateway connection
  local_networks = [
    {
      local_gw_name         = "onpremise"
      local_gateway_address = "8.8.8.8"
      local_address_space   = ["10.1.0.0/24"]
      shared_key            = "xpCGkHTBQmDvZK9HnLr7DAvH"
    },
  ]

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

### Point-to-Site VPN Gateway

```hcl
module "vpn-gateway" {
  source  = "kumarvna/vpn-gateway/azurerm"
  version = "1.1.0"

  # Resource Group, location, VNet and Subnet details
  resource_group_name  = "rg-shared-westeurope-01"
  virtual_network_name = "vnet-shared-hub-westeurope-001"
  vpn_gateway_name     = "shared-vpn-gw01"

  # client configuration for Point-to-Site VPN Gateway connections
  vpn_client_configuration = {
    address_space        = "10.1.0.0/24"
    vpn_client_protocols = ["SSTP", "IkeV2"]
    certificate          = <<EOF
MIIDnjCCAoagAwIBAgIhAKB7fd2/hLLoXJHF57TGm7ACkjrWrtgb+KnO+mMsvCw/
MA0GCSqGSIb3DQEBBQUAMGUxCTAHBgNVBAYTADEQMA4GA1UECgwHZXhhbXBsZTEJ
MAcGA1UECwwAMRQwEgYDVQQDDAtleGFtcGxlLmNvbTEPMA0GCSqGSIb3DQEJARYA
MRQwEgYDVQQDDAtleGFtcGxlLmNvbTAeFw0yMDA5MjQyMDAxMDBaFw0yMTA5MjUy
MDAxMDBaME8xCTAHBgNVBAYTADEQMA4GA1UECgwHZXhhbXBsZTEJMAcGA1UECwwA
MRQwEgYDVQQDDAtleGFtcGxlLmNvbTEPMA0GCSqGSIb3DQEJARYAMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAudme3h7l52ZrCX9uMYtsaJQikuPFCPFw
mZFNCkILDoox03Ag4u+qPcS/Z3pT3QJQrM4Vy/I6K2ZnTWCTUhdh4QD69YPotcvC
/0UBDkaZXO0XHMdqoWJFeqDF0WXvI+Suo2nxmx1lRNc5jZi36VW4SwzDdm31LfWI
7FCDFyBQc3aBgc2SFxWkU0IKsLUnmfXIyWbBYioKcAUj7OuD9MY3TGrKB1xwjHxa
abFQzuPFKTkLMmlXCBWweSS8XJXlnY6gvc1jAz6Vq3KET7V83ZCDVaikKeIstG+y
DFp/Bs+CxMLi0k4nv0fHyXo9dCDkXQlYPgyENi+jo6KLxFdlxa3rmQIDAQABo08w
TTAdBgNVHQ4EFgQUwMSixpf56/TXQNUvGwr/S4dpOlkwHwYDVR0jBBgwFoAUwMSi
xpf56/TXQNUvGwr/S4dpOlkwCwYDVR0RBAQwAoIAMA0GCSqGSIb3DQEBBQUAA4IB
AQCB3UGnJb3k2Sx1m47TQgPnQI3T16XIFsGHMivvwGuxIYz1hZrDhQ/2EepnLicK
oPalygS0ko/1r3xGHcn1Ei/0N4SQTrRMfn4pjvXRGx+Rs2Nl9E3PUAMMcEuqW1Pa
cUQrkEdlGg0t0fBtTpUHqyUFh0xU6Qlk2CIZdo2NaDoI6xpYYJtXqJWtTvOTe5op
MOyajCaVrAXxY4Kk53Yrl1+yhbL+x4JNMrdO4wAn0bR0Teawm1y1WFsu9OHMoZzX
Dgos8H06PH6rPvvvI1IFv3l5flPei3+YaO8m67nINbicW4BkBFwoxqjRnkCjZ+y0
38xRFiD0G8J0rE6wPB/9sAwP
EOF
  }
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
