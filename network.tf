# VNet
resource "azurerm_virtual_network" "ascale" {
  
  name = "${var.prefix}-vnet"
  resource_group_name = azurerm_resource_group.mle-cloud-training.name
  location = var.location

  address_space = ["10.0.0.0/16"]

  tags = var.tag
}

# SubNet
resource "azurerm_subnet" "ascale" {
  
  name = "${var.prefix}-subnet"
  resource_group_name = azurerm_resource_group.mle-cloud-training.name
  virtual_network_name = azurerm_virtual_network.ascale.name

  address_prefixes = [ "10.0.1.0/24" ]
}

# NSG
resource "azurerm_network_security_group" "ascale" {
  
  name = "${var.prefix}-nsg"
  resource_group_name = azurerm_resource_group.mle-cloud-training.name
  location = var.location

  

  security_rule {
    access = "Allow"
    description = "loadbalancer-nsg-allow"
    destination_address_prefix = "*"
    destination_port_range = "80"
    direction = "Inbound"
    name = "HTTP"
    priority = 1001
    protocol = "Tcp"
    source_address_prefix = "*"
    source_port_range = "*"
  }
  security_rule {
    access = "Allow"
    description = "loadbalancer-nsg-ssh"
    destination_address_prefix = "*"
    destination_port_range = "22"
    direction = "Inbound"
    name = "SSH"
    priority = 1002
    protocol = "Tcp"
    source_address_prefix = var.ssh-source-address
    source_port_range = "22"
  }
  security_rule {
    access = "Deny"
    description = "loadbalancer-nsg-deny"
    destination_address_prefix = "*"
    destination_port_range = "*"
    direction = "Inbound"
    name = "HTTP-Deny"
    priority = 1003
    protocol = "*"
    source_address_prefix = "*"
    source_port_range = "*"
  }
  tags = var.tag
}

