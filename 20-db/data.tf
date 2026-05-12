data "aws_ssm_parameter" "db_sg_id" {
    name ="/${var.project_name}/${var.environment}/db_sg_id"   # we will get this id form security group.
}
data "aws_ssm_parameter" "db_subnet_group_name" { #We created this group in VPC for RDS Subnet groups.
    name ="/${var.project_name}/${var.environment}/db_subnet_group_name" # We will get this id from VPC
}
