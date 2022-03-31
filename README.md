# work-in-progress
# terraform_template_azurevm_in_acloudguru_sandbox
# a terraform template to create an ubuntu 20.04 lts azure vm in acloudguru sandbox
# for the template to work (tested working environment), it is assumed that you have:
# (1) an acloudguru account that gives you access to acloudguru sandbox
# (2) local windows wsl ubuntu 20.04 lts terminal to run terraform commands
# (3) local windows vsc linked to wsl ubuntu 20.04 lts to preview (and amend) the terraform template
# if you run into dns issues when running terraform apply command, please see https://github.com/microsoft/WSL/issues/8022 and folow the -cont'below
# recommendations/steps therein to troubleshoot your local wsl ubuntu 20.04 lts
# steps to create azure vm in acloudguru sandbox:
# (1) login to you acloudguru account and navigate to acloudguru sandbox (ie https://learn.acloud.guru/cloud-playground/cloud-sandboxes)
# (2) select azure sandbox and follow the acloudguru instruction to login into azure internet browser session; and take note of the generated -cont'below
# azure user and password credentials (you will have to use it later)
# (3) copy the generated resource group name eg. x-xxxxxxxx-playground-sandbox shown in the azure internet browser session
# (4) logout and close the azure internet browser session
# (5) paste the copied resource group name eg. x-xxxxxxxx-playground-sandbox into the relevant field in the variables.tf file (using vsc for convenience)
# (6) run the command "az login --allow-no-subscriptions" in your local windows wsl ubuntu 20.04 lts terminal
# (7) enter the user and password (ie. generated earlier by acloudguru sandbox) after you are automatically directed to the azure internet browser session
# (8) run the usual terraform commands in your local wsl ubuntu 20.04 lts - 'fmt', 'validate', 'plan' and 'apply' (and lastly, after proceeding to -cont'below
# step no. 10 herein, 'destroy')
# (9) you can ignore the error if you were to encounter one - -cont'below 
# Error: A resource with the ID "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/x-xxxxxxxx-playground-sandbox" already exists - to -cont'below 
# be managed via Terraform this resource needs to be imported into the State. Please see the resource documentation for "azurerm_resource_group" for more information.
# (10) login again into azure internet browser session (with the earlier user and password credentials) to confirm that your resources have been created
# feel free to de-construct and re-construct the template and improve the same by collabrating to develop a shared knowledge pool
