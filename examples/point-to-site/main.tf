module "vpn-gateway" {
  source  = "kumarvna/vpn-gateway/azurerm"
  version = "1.1.0"

  # Resource Group, location, VNet and Subnet details
  resource_group_name  = "rg-shared-westeurope-01"
  virtual_network_name = "vnet-shared-hub-westeurope-001"
  vpn_gateway_name     = "shared-vpn-gw01"

  # client configuration for Point-to-Site VPN Gateway connections
  # this key here for example only. Use your own key pairs for security. 
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
