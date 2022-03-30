# work-in-progress
# terraform_template_azurevm_in_acloudguru_sandbox
# a terraform template to create an ubuntu 20.04 lts azure vm in acloudguru sandbox
# steps:
# (1) login to you acloudguru account and go to https://learn.acloud.guru/cloud-playground/cloud-sandboxes
# (2) select the azure sandbox and follow the acloudguru instruction to open the azure session
# (3) copy the generated resource group name eg. x-xxxxxxxx-playground-sandbox
# (4) close the azure session
# (5) paste the copied resource group name into the relevant field in the variables.tf file
# az login --allow-no-subscriptions
# Error: A resource with the ID "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/x-xxxxxxxx-playground-sandbox" already exists - to be managed via Terraform this resource needs to be imported into the State. Please see the resource documentation for "azurerm_resource_group" for more information.
