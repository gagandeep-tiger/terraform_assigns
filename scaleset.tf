resource "azurerm_linux_virtual_machine_scale_set" "ascale" {
  
  name = "${var.prefix}-scaleset"
  resource_group_name = azurerm_resource_group.mle-cloud-training.name
  location = var.location
  sku = "Standard_D2s_v3"
  instances = 1
  admin_username = var.admin_username

  admin_ssh_key {
    username = var.admin_username
    public_key = file("mykey.pub")
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name = "${var.prefix}-scaleset-network-profile"
    primary = true
    network_security_group_id = azurerm_network_security_group.ascale.id

    ip_configuration {
      name = "${var.prefix}-scaleset-ipconfig"
      primary = true
      subnet_id = azurerm_subnet.ascale.id
    #   load_balancer_backend_address_pool_ids = [ "value" ] //TODO: set lb_pool
    #   load_balancer_inbound_nat_rules_ids = [ "value" ] //TODO: set nat rules
    }

  }
  
}