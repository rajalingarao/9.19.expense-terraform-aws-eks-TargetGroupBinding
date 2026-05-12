 module "vpc" {

   #source = "../../5.9.terraform-aws-vpc-peering"
   source = "git::https://github.com/rajalingarao/5.9.terraform-aws-vpc-peering.git?ref=main"
 
    #These variables values must given by module users. 
    project_name = var.project_name
    common_tags = var.common_tags
    public_subnet_cidrs   = var.public_subnet_cidrs
    private_subnet_cidrs  = var.private_subnet_cidrs
    database_subnet_cidrs = var.database_subnet_cidrs
    is_peering_required  = var.is_peering_required
 }

 