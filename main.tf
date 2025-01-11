resource "azurerm_dns_zone" "this" {
  name                = var.name
  resource_group_name = var.rg.name

  lifecycle {
    ignore_changes = [
      tags["business_unit"],
      tags["environment"],
      tags["product"],
      tags["subscription_type"],
    ]
  }
}

module "records" {
  source              = "app.terraform.io/ptonini-org/dns-record/azurerm"
  version             = "~> 1.0.0"
  for_each            = var.records
  zone_name           = azurerm_dns_zone.this.name
  resource_group_name = azurerm_dns_zone.this.resource_group_name
  name                = each.key
  type                = each.value.type
  records             = each.value.records
  target_resource_id  = each.value.target_resource_id
  ttl                 = each.value.ttl
}

module "root_records" {
  source              = "app.terraform.io/ptonini-org/dns-record/azurerm"
  version             = "~> 1.0.0"
  for_each            = var.root_records
  zone_name           = azurerm_dns_zone.this.name
  resource_group_name = azurerm_dns_zone.this.resource_group_name
  name                = "@"
  type                = each.key
  records             = each.value.records
  target_resource_id  = each.value.target_resource_id
  ttl                 = each.value.ttl
}