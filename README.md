\# terraform_template_azurevm_in_acloudguru_sandbox <br />
\# a terraform template to deploy an ubuntu 20.04 lts azure vm in acloudguru sandbox <br />
\# for the template to work (in a tested working environment), it is assumed that you have: <br />
\# (1) an acloudguru account that gives you access to acloudguru sandbox <br />
\# (2) local windows wsl ubuntu 20.04 lts terminal to run terraform commands <br />
\# (3) local windows vsc linked to wsl ubuntu 20.04 lts to preview (and amend) terraform template <br />
\# (4) and more importantly, no evil intention to 'abuse' the acloudguru sandbox <br />
\# if you run into dns issues when running terraform 'apply' command, please see https://github.com/microsoft/WSL/issues/8022 and follow the recommendations/steps therein to troubleshoot your local wsl ubuntu 20.04 lts <br />
\# steps to create azure vm in acloudguru sandbox: <br />
\# (1) login to you acloudguru account and navigate to acloudguru sandbox (ie https://learn.acloud.guru/cloud-playground/cloud-sandboxes) <br />
\# (2) select azure sandbox and follow the acloudguru instruction to login into azure internet browser session; and take note of the generated azure user and password credentials (you will have to use it later) <br />
\# (3) copy the generated resource group name eg. x-xxxxxxxx-playground-sandbox shown in the azure internet browser session <br />
\# (4) logout and close the azure internet browser session <br />
\# (5) paste the copied resource group name eg. x-xxxxxxxx-playground-sandbox into the relevant field in the variables.tf file (using vsc for convenience) <br />
\# (6) run the command "az login --allow-no-subscriptions" in your local windows wsl ubuntu 20.04 lts terminal <br />
\# (7) enter the user and password (ie. generated earlier by acloudguru sandbox) after you are automatically directed to the azure internet browser session <br />
\# (8) run the usual terraform commands in your local wsl ubuntu 20.04 lts - 'fmt', 'validate', 'plan' and 'apply' (and lastly, after proceeding to step no. 10 herein, 'destroy') <br />
\# (9) you can ignore this error if you were to encounter it - <br /> 
\# Error: A resource with the ID "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/x-xxxxxxxx-playground-sandbox" already exists - to be managed via Terraform this resource needs to be imported into the State. Please see the resource documentation for "azurerm_resource_group" for more information. <br />
\# (10) login again into azure internet browser session (with the earlier user and password credentials) to confirm that your resources have been created <br />
<br />
\# feel free to de-construct and re-construct the template and improve on the same by collaborating with the view of developing a shared knowledge pool
