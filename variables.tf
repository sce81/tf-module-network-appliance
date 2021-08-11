variable "ami_id"                                         {}
variable "key_name"                                       {}
variable "user_data"                                      {}
variable "env"                                            {}
variable "name"                                           {}
variable "pub_subnet_ids"                                 {type = list}
variable "mgmt_subnet_ids"                                {type = list}
variable "priv_subnet_ids"                                {type = list}
variable "instance_profile"                               {}
variable "number"                                         {default  = 00}
variable "instance_type"                                  {default  = "m5.large"}
variable "disable_api_termination"                        {default  = "true"}
variable "project"                                        {default  = "shared"}
variable "pub_source_dest_check"                          {default  = true}
variable "mgmt_source_dest_check"                         {default  = true}
variable "priv_source_dest_check"                         {default  = true}
variable "pub_security_group_ids"                         {type     = list}
variable "mgmt_security_group_ids"                        {type     = list}
variable "priv_security_group_ids"                        {type     = list}
variable "extra_tags"                                     {
                                                          type = map
                                                          default = {}
                                                          }
variable "customer_owned_ipv4_pool"                       {default = null}