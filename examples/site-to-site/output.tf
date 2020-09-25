output "vpn_gateway_id" {
  description = "The resource ID of the virtual network gateway"
  value       = module.vpn-gateway.vpn_gateway_id
}

output "vpn_gateway_public_ip" {
  description = "The public IP of the virtual network gateway"
  value       = module.vpn-gateway.vpn_gateway_public_ip
}

output "vpn_gateway_public_ip_fqdn" {
  description = "Fully qualified domain name of the virtual network gateway"
  value       = module.vpn-gateway.vpn_gateway_public_ip_fqdn
}

