# VNET
resource "azurerm_virtual_network" "mars" {
  name                = "${var.prefix}-vnet"
  resource_group_name = azurerm_resource_group.mle-cloud-training.name
  location            = azurerm_resource_group.mle-cloud-training.location
  address_space       = ["10.0.0.0/16"]
#   dns_servers         = ["10.0.0.4", "10.0.0.5"] //TODO: L

  tags = var.tags
}

# SUBNET1
resource "azurerm_subnet" "mars-subnet-internal" {
  name                 = "${var.prefix}-subnet1"
  resource_group_name  = azurerm_resource_group.mle-cloud-training.name
  virtual_network_name = azurerm_virtual_network.mars.name
  address_prefixes     = ["10.0.1.0/24"]

#   delegation {    //TODO: L
#     name = "delegation"

#     service_delegation {
#       name    = "Microsoft.ContainerInstance/containerGroups"
#       actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
#     }
#   }
}
# SUBNET2
resource "azurerm_subnet" "mars-subnet-ag" {
  name                 = "${var.prefix}-subnet2"
  resource_group_name  = azurerm_resource_group.mle-cloud-training.name
  virtual_network_name = azurerm_virtual_network.mars.name
  address_prefixes     = ["10.0.2.0/24"]

#   delegation {    //TODO: L
#     name = "delegation"

#     service_delegation {
#       name    = "Microsoft.ContainerInstance/containerGroups"
#       actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
#     }
#   }
}

# NSG1
resource "azurerm_network_security_group" "mars-vmss1" {
  name                = "${var.prefix}-nsg1"
  resource_group_name = azurerm_resource_group.mle-cloud-training.name
  location            = azurerm_resource_group.mle-cloud-training.location

  security_rule {
    name                       = "HTTP"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "SSH"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.ssh-source-address
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "ABORT"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = var.tags
}

# NSG2
resource "azurerm_network_security_group" "mars-vmss2" {
  name                = "${var.prefix}-nsg2"
  resource_group_name = azurerm_resource_group.mle-cloud-training.name
  location            = azurerm_resource_group.mle-cloud-training.location

  security_rule {
    name                       = "HTTP"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "SSH"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.ssh-source-address
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "ABORT"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = var.tags
}

# PUBLICIP
resource "azurerm_public_ip" "mars" {
  name                = "${var.prefix}-pubip1"
  resource_group_name = azurerm_resource_group.mle-cloud-training.name
  location            = azurerm_resource_group.mle-cloud-training.location
  allocation_method   = "Static"
  domain_name_label = "${var.prefix}-mars"
  tags = var.tags
}