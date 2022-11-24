resource "azurerm_application_gateway" "network" {
  name                = "${var.prefix}-gateway"
  resource_group_name = azurerm_resource_group.mle-cloud-training.name
  location            = azurerm_resource_group.mle-cloud-training.location

  sku {
    name     = "Standard_Small"
    tier     = "Standard"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "gateway-ip-configuration"
    subnet_id = azurerm_subnet.mars-subnet-ag.id
  }

  frontend_port {
    name = "frontend-port"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "frontend-ip-config"
    public_ip_address_id = azurerm_public_ip.mars.id
  }

  backend_address_pool {
    name = "${var.prefix}-gateway-beap-1"
  }

  backend_address_pool {
    name = "${var.prefix}-gateway-beap-2"
  }

  backend_http_settings {
    name                  = "HttpSetting"
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = "gateway-listener"
    frontend_ip_configuration_name = "frontend-ip-config"
    frontend_port_name             = "frontend-port"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "RoutingRuleA"
    rule_type                  = "PathBasedRouting"
    http_listener_name         = "gateway-listener"
    url_path_map_name = "RoutingPath"
  }

  url_path_map {
    name = "RoutingPath"
    default_backend_address_pool_name = "frontend-pool"
    default_backend_http_settings_name = "HttpSetting"

    path_rule {
      name = "FrontendRoutingRule"
      backend_address_pool_name =  "${var.prefix}-gateway-beap-1"
      backend_http_settings_name = "HttpSetting"
      paths = [
        "/frontend/*",
      ]
    }

    path_rule {
      name = "BackendRoutingRule"
      backend_address_pool_name =  "${var.prefix}-gateway-beap-2"
      backend_http_settings_name = "HttpSetting"
      paths = [
        "/backend/*",
      ]
    }
  }
  tags = var.tags
}