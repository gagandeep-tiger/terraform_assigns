# VM-1
resource "azurerm_linux_virtual_machine" "vm_1" {
  name                = "${var.prefix}-vm_1"
  resource_group_name = azurerm_resource_group.mle-cloud-training.name
  location            = var.location
  size                = "Standard_F2"
  admin_username      = "ggndp"

  network_interface_ids = [azurerm_network_interface.NIC_1]


  admin_ssh_key {
    username   = "ggndp"
    public_key = file("mykey.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  tags = var.tags
}
# NIC-1
resource "azurerm_network_interface" "NIC_1" {
  name                = "${var.prefix}-NIC_1"
  resource_group_name = azurerm_resource_group.mle-cloud-training.name
  location            = var.location

  ip_configuration {
    name                          = "external-facing"
    subnet_id                     = azurerm_subnet.subnet_1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.public_ip_1.id
  }
  
  tags = var.tags
}


# VM-2
resource "azurerm_linux_virtual_machine" "vm_2" {
  name                = "${var.prefix}-vm_2"
  resource_group_name = azurerm_resource_group.mle-cloud-training.name
  location            = var.location
  size                = "Standard_F2"
  admin_username      = "ggndp"

  network_interface_ids = [azurerm_network_interface.NIC_2]


  admin_ssh_key {
    username   = "ggndp"
    public_key = file("mykey.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  tags = var.tags
}
# NIC-2
resource "azurerm_network_interface" "NIC_2" {
  name                = "${var.prefix}-NIC_2"
  resource_group_name = azurerm_resource_group.mle-cloud-training.name
  location            = var.location

  ip_configuration {
    name                          = "external-facing"
    subnet_id                     = azurerm_subnet.subnet_1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.public_ip_2.id
  }

  tags = var.tags
}

# NI_NSG_ASS-1 && NI_NSG_ASS-2
resource "azurerm_network_interface_security_group_association" "NI_NSG_ASS_1" {
  network_interface_id      = azurerm_network_interface.NIC_1.id
  network_security_group_id = azurerm_network_security_group.NSG_1.id
}

resource "azurerm_network_interface_security_group_association" "NI_NSG_ASS_2" {
  network_interface_id      = azurerm_network_interface.NIC_1.id
  network_security_group_id = azurerm_network_security_group.NSG_1.id
}

# ASG-I
resource "azurerm_application_security_group" "ASG_1" {
  name                = "${var.prefix}-ASG_1"
  location            = var.location
  resource_group_name = azurerm_resource_group.mle-cloud-training.name

  tags = var.tags
}

# NI_ASG_ASS-2 && NI_ASG_ASS-1
resource "azurerm_network_interface_application_security_group_association" "NI_ASG_ASS_1" {
  network_interface_id          = azurerm_network_interface.NIC_1.id
  application_security_group_id = azurerm_application_security_group.ASG_1.id
}

resource "azurerm_network_interface_application_security_group_association" "NI_ASG_ASS_2" {
  network_interface_id          = azurerm_network_interface.NIC_2.id
  application_security_group_id = azurerm_application_security_group.ASG_1.id
}


# VM-3
resource "azurerm_linux_virtual_machine" "vm_3" {
  name                = "${var.prefix}-vm_3"
  resource_group_name = azurerm_resource_group.mle-cloud-training.name
  location            = var.location
  size                = "Standard_F2"
  admin_username      = "ggndp"

  network_interface_ids = [azurerm_network_interface.NIC_3]

  admin_ssh_key {
    username   = "ggndp"
    public_key = file("mykey.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  tags = var.tags
}
# NIC-3
resource "azurerm_network_interface" "NIC_3" {
  name                = "${var.prefix}-NIC_3"
  resource_group_name = azurerm_resource_group.mle-cloud-training.name
  location            = var.location

  ip_configuration {
    name                          = "external-facing"
    subnet_id                     = azurerm_subnet.subnet_2.id
    private_ip_address_allocation = "Dynamic"
  }
  
  tags = var.tags
}

# NI_NSG_ASS-3
resource "azurerm_network_interface_security_group_association" "NI_NSG_ASS_3" {
  network_interface_id      = azurerm_network_interface.NIC_3.id
  network_security_group_id = azurerm_network_security_group.NSG_2.id
}

