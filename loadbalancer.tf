resource "azurerm_lb" "ascale" {
    name = "${var.prefix}-lb"
    location = var.location
    resource_group_name = azurerm_resource_group.mle-cloud-training.name
 
frontend_ip_configuration {
    name = "${var.prefix}-frontend-ip"
   public_ip_address_id = azurerm_public_ip.ascale.id
 }
 tags = var.tag
}

# public-ip
resource "azurerm_public_ip" "ascale" {
  name = "${var.prefix}-public-ip"
  resource_group_name = azurerm_resource_group.mle-cloud-training.name
  location = var.location
  allocation_method = "Static"
  domain_name_label = "${var.prefix}-ascale-ip"
  tags = var.tag
}

resource "azurerm_lb_backend_address_pool" "ascale" {
  name = "${var.prefix}-lb-address-pool"
  loadbalancer_id = azurerm_lb.ascale.id
}

resource "azurerm_lb_probe" "ascale" {
  name = "${var.prefix}-lb-probe"
  loadbalancer_id = azurerm_lb.ascale.id
  protocol = "Http"
  request_path = "/"
  port = 80
}

resource "azurerm_lb_rule" "ascale" {
  name = "${var.prefix}-lb-rule"
  loadbalancer_id = azurerm_lb.ascale.id
  protocol = "Tcp"
  frontend_port = 80
  backend_port = 80
  probe_id = azurerm_lb_probe.ascale.id
  frontend_ip_configuration_name = "${var.prefix}-frontend-ip"
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.ascale.id]
}

resource "azurerm_lb_nat_pool" "ascale" {
  resource_group_name = azurerm_network_security_group.ascale.name
  name = "${var.prefix}-lb-ssh"
  loadbalancer_id = azurerm_lb.ascale.id
  protocol = "Tcp"
  frontend_port_start = 50000
  frontend_port_end = 50119
  backend_port = 22
  frontend_ip_configuration_name  = "${var.prefix}-frontend-ip"
}