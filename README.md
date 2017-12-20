# AWS NAT Gateway

This module can be used to deploy an AWS NAT Gateway.

Module Input Variables
----------------------

- `env` - The environment name
- `vpc_id` - The id of the vpc
- `name` - The name of the subnet
- `public_subnet_id` - The private route table id of the vpc
- `vpc_main_route_table_id` - The main route table id of the vpc
- `private_route_table_id` - The private route table id of the vpc

Usage 
-----

```hcl
module "nat_gateway" {
  source = "github.com/CalebMacdonaldBlack/terraform-nat-gateway"
  env = "${terraform.workspace}"
  name = "primary"
  vpc_id = "${module.vpc.id}"
  vpc_main_route_table_id = "${module.vpc.main_route_table_id}"
  private_route_table_id = "${module.vpc.private_route_table_id}"
  public_subnet_id = "${module.public_subnet.id}"
}
```

Outputs
-------
- N/A

Author
------
Created and maintained by [Fierce Ventures](https://github.com/fierceventures/)
