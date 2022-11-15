# instance
resource "azurerm_linux_virtual_machine" "demo-instance" {
  name = "${var.prefix}-vm-1"
  location = var.location
  resource_group_name = azurerm_resource_group.mle-cloud-training.name
  size = "Standard_D2s_v3"
  admin_username = "ggndp"

  network_interface_ids = [
      azurerm_network_interface.demo-instance.id
    ]

  admin_ssh_key {
    username = "ggndp"
    public_key = file("mykey.pub")
  }

  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}

# network interface
resource "azurerm_network_interface" "demo-instance" {
  name = "${var.prefix}-instance1"
  location = var.location
  resource_group_name = azurerm_resource_group.mle-cloud-training.name

  ip_configuration {
    name = "instance1"
    subnet_id = azurerm_subnet.demo-internal-1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.demo-instance.id
  }
}

# public Ip
resource "azurerm_public_ip" "demo-instance" {
  name = "instance1-public-ip"
  location = var.location
  resource_group_name = azurerm_resource_group.mle-cloud-training.name
  allocation_method = "Dynamic"
}

# NIC_SG_assoc
resource "azurerm_network_interface_security_group_association" "allow-ssh" {
  network_interface_id = azurerm_network_interface.demo-instance.id
  network_security_group_id = azurerm_network_security_group.allow-ssh.id
}