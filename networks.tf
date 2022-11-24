resource "azurerm_virtual_network" "vnet" {
  name = "${var.prefix}-vnet"
  location = var.location
  resource_group_name = azurerm_resource_group.mle-cloud-training.name
  address_space = [ "10.0.0.0/16" ]
  tags = var.tags

}

resource "azurerm_subnet" "subnet_1" {
  name = "${var.prefix}-subnet_1"
  resource_group_name = azurerm_resource_group.mle-cloud-training.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = [ "10.0.1.0/24" ]
}

resource "azurerm_subnet" "subnet_2" {
  name = "${var.prefix}-subnet_2"
  resource_group_name = azurerm_resource_group.mle-cloud-training.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = [ "10.0.2.0/24" ]
}

resource "azurerm_public_ip" "public_ip_1" {
  name = "${var.prefix}-public_ip_1"
  location = var.location
  resource_group_name = azurerm_resource_group.mle-cloud-training.name
  allocation_method = "Static"
  domain_name_label = "${var.prefix}-public_ip_1"
  tags = var.tags
}

resource "azurerm_public_ip" "public_ip_2" {
  name = "${var.prefix}-public_ip_2"
  location = var.location
  resource_group_name = azurerm_resource_group.mle-cloud-training.name
  allocation_method = "Static"
  domain_name_label = "${var.prefix}-public_ip_2"
  tags = var.tags
}

# NSG1
resource "azurerm_network_security_group" "NSG_1" {
  name                = "${var.prefix}-NSG_1"
  location            = var.location
  resource_group_name = azurerm_resource_group.mle-cloud-training.name

  security_rule {
    name                       = "ssh-rule"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.ssh-source-address
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "deny-all"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = var.tags
}

# NSG2
resource "azurerm_network_security_group" "NSG_2" {
  name                = "${var.prefix}-NSG_2"
  location            = var.location
  resource_group_name = azurerm_resource_group.mle-cloud-training.name

  security_rule {
    name                       = "internal-rule"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_application_security_group_ids = [azurerm_application_security_group.ASG_1.id]
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "internal-rule"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*" 
    source_address_prefix      = "*" 
    destination_address_prefix = "*"
  }

  tags = var.tags
}