# terraform_template_azurevm_in_acloudguru_sandbox
a terraform template to deploy an ubuntu 20.04 lts azure vm in acloudguru sandbox
# this terraform is created by masnawi rahmat
# in Generation SG/Temasek Poly SGUPMSCT Cloud Support and DevOps Bootcamp cohort no 4 Yr 2022
# this terraform is created with learning purpose more than optimisation in mind
# note:
# (1) description is only a label not interpreted by terraform 
# (2) default is a set value which is interpreted by terraform 

# ---------resource group specs--------- # 
variable "resource_group_name" {
  description = "generated resource group name" # insert the acloudguru system generated resource group name -cont'below
  # [eg. x-xxxxxxxx-playground-sandbox]
  default     = "x-xxxxxxxx-playground-sandbox"
}

variable "resource_group_location" {
  description = "geo location of the resource group" # eastus is the default for acloudguru sandbox subscription
  default     = "eastus"
}

# ---------vm specs--------- #
variable "computer_name" {
  description = "vm name" # any name of your choice
  default     = "testserver"
}

variable "computer_size" {
  description = "vm size" # the azure vm size code [sometimes strictly tied to acloudguru subscription and geo location]
  default     = "Standard_D2s_v3"
}

variable "computer_storage" {
  description = "storage type" # the azure storage type code [sometimes strictly tied acloudguru subscription and geo location]
  default     = "Premium_LRS"
}

# ---------vm os/image specs--------- # os/image of your choice [sometimes strictly tied acloudguru subscription]
variable "publisher" {
  description = "os/image publisher"
  default     = "canonical"
}

variable "offer" {
  description = "os/image offer"
  default     = "0001-com-ubuntu-server-focal"
}

variable "sku" {
  description = "os/image sku"
  default     = "20_04-lts-gen2"
}

variable "os_version" {
  description = "os/image version"
  default     = "latest"
}

# ---------vm network specs--------- #
variable "virtual_netwrok_range" {
  description = "resource group private ip address range"
  default     = "10.0.0.0/16"
}

variable "virtual_subnet_range" {
  description = "resource group private subnet address range"
  default     = "10.0.0.0/24"
}

variable "private_ip_address_allocation" {
  description = "dynamic or static address allocation" # you have to explicitly specify the private ip address if you select "Static"
  default     = "Dynamic"
}

variable "public_ip_address_allocation" {
  description = "dynamic or static address allocation"
  default     = "Static"
}

# ---------security rule specs--------- #
variable "security_rule_name" {
  description = "'AllowAllOutbound' or 'SSH' traffic" # this is just a label and to comment out 'ssh key specs' section if -cont'below
  # "AllowAllOutbound" is selected (and you have to set 'disable_authentication' in 'admin user login account specs' section to 'false' ) 
  default     = "SSH"
}

variable "security_port_range" {
  description = "inbound port range" # set default to "*" if "AllowAllOutbound" is selected 
  default     = "22"
}

# ---------storage boot diagnostic specs--------- #
variable "account_tier" {
  description = "account storage tier" # the azure storage type code [sometimes strictly tied acloudguru subscription and geo location]
  default     = "Standard"
}

variable "account_replication_type" {
  description = "storage replication type" # the azure storage type code [sometimes strictly tied acloudguru subscription and -cont'below
  # geo location]
  default     = "LRS"
}

# ---------ssh key specs--------- #
variable "ssh_algorithm" {
  description = "RSA or ECDSA key algorithm" # ssh security algorithm of your choice
  default     = "RSA"
}

variable "ssh_rsa_bits" { # set default to 4096 for is "RSA" is selected
  description = "ssh key size"
  default     = "4096"
}

# ---------admin user login account specs--------- #
variable "admin_user_name" {
  description = "admin user name" # set default to "azureuser" or "your_own_user_name" or any other name of your choice 
  default     = "azureuser"
}

variable "disable_authentication" {
  description = "enable or disable password authentication" # if set to false, uncomment 'admin_password' field -cont'below
  # in vm block section in the main.tf file  
  default     = "true"
}

variable "admin_user_password" {
  description = "set the default password for admin_user" # insert default password of your choice to access vm -cont'below
  # and this variable is only activated if 'disable_authentication' in the 'admin user login account specs' is set to 'false' 
  default = "password1234"
}
