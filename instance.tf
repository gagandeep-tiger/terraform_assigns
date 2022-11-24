# VMSS-1
resource "azurerm_linux_virtual_machine_scale_set" "mars-vmss1" {
  name                = "${var.prefix}-vmss1"
  resource_group_name = azurerm_resource_group.mle-cloud-training.name
  location            = azurerm_resource_group.mle-cloud-training.location
  sku                 = "Standard_D2s_v3"
  instances           = 1
  admin_username      = "ggndp"
  
  //TODO: E-AutoScaling 

  admin_ssh_key {
    username   = "ggndp"
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
    name    = "${var.prefix}-vmss1-NIC1"
    primary = true
    network_security_group_id = azurerm_network_security_group.mars-vmss1.id
    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = azurerm_subnet.mars-subnet-internal.id
      application_gateway_backend_address_pool_ids = [for value in azurerm_application_gateway.network.backend_address_pool.*.id : value if "${var.prefix}-gateway-beap-1" == value]
    }
  }
  tags = var.tags
}

# VMSS-2
resource "azurerm_linux_virtual_machine_scale_set" "mars-vmss2" {
  name                = "${var.prefix}-vmss2"
  resource_group_name = azurerm_resource_group.mle-cloud-training.name
  location            = azurerm_resource_group.mle-cloud-training.location
  sku                 = "Standard_D2s_v3"
  instances           = 1
  admin_username      = "ggndp"

  //TODO: E-AutoScaling 

  admin_ssh_key {
    username   = "ggndp"
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
    name    = "${var.prefix}-vmss2-NIC1"
    primary = true
    network_security_group_id = azurerm_network_security_group.mars-vmss2.id

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = azurerm_subnet.mars-subnet-internal.id
      application_gateway_backend_address_pool_ids = [for value in azurerm_application_gateway.network.backend_address_pool.*.id : value if "${var.prefix}-gateway-beap-2" == value]
    }
  }
  tags = var.tags
}