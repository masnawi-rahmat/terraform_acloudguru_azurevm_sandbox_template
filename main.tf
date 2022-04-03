# terraform_template_azurevm_in_acloudguru_sandbox
# this terraform is created by masnawi rahmat
# in Generation SG/Temasek Poly SGUPMSCT Cloud Support and DevOps Bootcamp cohort no 4 Yr 2022
# this terraform is created with learning purpose more than optimisation in mind
# note: 
# (1) unless necessary, make the required changes only in the accompanying variables.tf file
# (2) a reference to a resource module comes in a pair eg. "azurerm_resource_group" "main" - -cont'below
# "azurerm_resource_group" is the name of the module that comes with set perimeters -cont'below
# and "main" is just a label of your choice but must be unique when the same module -cont'below
# is subsequently invoked in the same main.tf file
# (3) please do not use this template to 'abuse' the acloudguru sandbox  

# ---cloud provider block----
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

# ----resource group name block----
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

# ----resource group vnet block----
resource "azurerm_virtual_network" "main" {
  name                = "${var.resource_group_name}-vnet"
  address_space       = ["${var.virtual_netwrok_range}"]
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}

# ----resource group subnet block----
resource "azurerm_subnet" "main" {
  name                 = "${var.resource_group_name}-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["${var.virtual_subnet_range}"]
}

# ----vm public ip block----
resource "azurerm_public_ip" "main" {
  name                = "${var.computer_name}-ip"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = var.public_ip_address_allocation
}

# ----vm network security group and rule block----
resource "azurerm_network_security_group" "main" {
  name                = "${var.resource_group_name}-nsg"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "${var.computer_name}-${var.security_rule_name}"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = var.security_port_range
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# ----vm and resource group private ip network interface config block----
resource "azurerm_network_interface" "main" {
  name                = "${var.computer_name}-nic"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "${var.resource_group_name}-ipconfig"
    subnet_id                     = azurerm_subnet.main.id
    private_ip_address_allocation = var.private_ip_address_allocation
    public_ip_address_id          = azurerm_public_ip.main.id
  }
}

# ----network interface security group block----
resource "azurerm_network_interface_security_group_association" "main" {
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = azurerm_network_security_group.main.id
}

# ----storage account random id name block----
resource "random_id" "randomid" {
  keepers = {
    # new random id for new resource group
    resource_group = "${var.resource_group_name}"
  }
  byte_length = 8
}

# ----storage account for boot diagnostics block----
resource "azurerm_storage_account" "main" {
  name                     = "${random_id.randomid.hex}sabd"
  location                 = var.resource_group_location
  resource_group_name      = var.resource_group_name
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
}

# ----ssh key block----
resource "tls_private_key" "main" {
  algorithm = var.ssh_algorithm
  rsa_bits  = var.ssh_rsa_bits
}

# ----vm block----
resource "azurerm_linux_virtual_machine" "main" {
  name                  = var.computer_name
  location              = var.resource_group_location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.main.id]
  size                  = var.computer_size

  os_disk {
    name                 = "${var.computer_name}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = var.computer_storage
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.os_version
  }

  computer_name  = var.computer_name
  admin_username = var.admin_user_name
  disable_password_authentication = var.disable_authentication
  # admin_password = var.admin_user_password
    
  admin_ssh_key {
    username   = var.admin_user_name
    public_key = tls_private_key.main.public_key_openssh
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.main.primary_blob_endpoint
  }
}
