data "cloudflare_zone" "external_domain" {
  count = local.create_dns_records ? 1 : 0
  depends_on = [
    data.kubernetes_config_map.network_context,
  ]
  filter = {
    name = local.external_domain
  }
}

resource "cloudflare_dns_record" "homeassistant" {
  count = local.create_dns_records && module.homeassistant_environment[0].homeassistant_ingress_enabled ? 1 : 0
  depends_on = [
    data.kubernetes_config_map.network_context,
    data.cloudflare_zone.external_domain,
    module.homeassistant_environment
  ]
  zone_id = data.cloudflare_zone.external_domain[0].id
  name = module.homeassistant_environment[0].homeassistant_ingress_address
  ttl = local.dns_ttl_seconds
  proxied = local.dns_records_proxy_enabled
  type = "A"
  content = local.external_ingress_ip
  comment = local.dns_records_default_comment
}

resource "cloudflare_dns_record" "homeassistant_codeserver" {
  count = local.create_dns_records && module.homeassistant_environment[0].codeserver_ingress_enabled ? 1 : 0
  depends_on = [
    data.kubernetes_config_map.network_context,
    data.cloudflare_zone.external_domain,
    module.homeassistant_environment
  ]
  zone_id = data.cloudflare_zone.external_domain[0].id
  name = module.homeassistant_environment[0].codeserver_ingress_address
  ttl = local.dns_ttl_seconds
  proxied = local.dns_records_proxy_enabled
  type = "A"
  content = local.external_ingress_ip
  comment = local.dns_records_default_comment
}

resource "cloudflare_dns_record" "homeassistant_zigbee2mqtt" {
  count = local.create_dns_records && module.homeassistant_environment[0].zigbee2mqtt_ingress_enabled ? 1 : 0
  depends_on = [
    data.kubernetes_config_map.network_context,
    data.cloudflare_zone.external_domain,
    module.homeassistant_environment
  ]
  zone_id = data.cloudflare_zone.external_domain[0].id
  name = module.homeassistant_environment[0].zigbee2mqtt_ingress_address
  ttl = local.dns_ttl_seconds
  proxied = local.dns_records_proxy_enabled
  type = "A"
  content = local.external_ingress_ip
  comment = local.dns_records_default_comment
}
