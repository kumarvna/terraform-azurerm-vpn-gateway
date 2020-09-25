output "vpn_gateway_id" {
  description = "The resource ID of the virtual network gateway"
  value       = azurerm_virtual_network_gateway.vpngw.id
}

output "vpn_gateway_public_ip" {
  description = "The public IP of the virtual network gateway"
  value       = flatten(concat([azurerm_public_ip.pip_gw.ip_address], [var.enable_active_active != null ? azurerm_public_ip.pip_aa.*.ip_address : null]))
}

output "vpn_gateway_public_ip_fqdn" {
  description = "Fully qualified domain name of the virtual network gateway"
  value       = flatten(concat([azurerm_public_ip.pip_gw.fqdn], [var.enable_active_active != null ? azurerm_public_ip.pip_aa.*.fqdn : null]))
}
