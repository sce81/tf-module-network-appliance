# tf-module-network-appliance
Terraform module for creating a virtual network appliance - eg: a firewall. 

Creates 3x Network Interfaces and expects 3 subnet tiers - public, management and private.  
Creates an EIP and attaches it to the primary interface (expected to be located in the public subnet).  
Expects security groups and IAM roles to be created externally to the module.  
Tested with Palo Alto Network Appliance, but should be compatible with applicances from other vendors.   
NB: Palo Altos expect the management interface to be swapped to ensure the interfaces line up as intended.  
Execute: **mgmt-interface-swap=enable** in userdata to action this change. 

##### Usage

    module "paloalto" {
      source                                        = "git@github.com:sce81/tf-module-network-appliance.git"
      count                                         = 1
      number                                        = (count.index + 1)
      env                                           = var.env
      name                                          = var.name
      project                                       = var.project
      pub_subnet_ids                                = data.terraform_remote_state.infra.outputs.primary_subnet_ids
      mgmt_subnet_ids                               = data.terraform_remote_state.infra.outputs.secondary_subnet_ids
      priv_subnet_ids                               = data.terraform_remote_state.infra.outputs.tertiary_subnet_ids
      ami_id                                        = var.ami_id
      key_name                                      = module.ssh_key.key_name
      pub_security_group_ids                        = [module.pa-sg-pub.id]
      mgmt_security_group_ids                       = [module.pa-sg-mgmt.id]
      priv_security_group_ids                       = [module.pa-sg-priv.id]
      user_data                                     = data.template_file.userdata.rendered
      instance_profile                              = module.pa-iam.instance_profile
    }
