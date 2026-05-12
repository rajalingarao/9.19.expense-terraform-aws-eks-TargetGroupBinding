
#This parameter is used in Security group creation
resource "aws_ssm_parameter" "vpc_id" {
  name  = "/${var.project_name}/${var.environment}/vpc_id" # vpc will store its vpc id in SSM Parameter store.
  type  = "String"
  value =  module.vpc.vpc_id # here vpc_id is vpc exposed output
}

# These are parameters useful for bastion server
resource "aws_ssm_parameter" "public_subnet_ids" {
  name  = "/${var.project_name}/${var.environment}/public_subnet_ids" # vpc will store its public subnet ids id in SSM Parameter store.
  type  = "StringList"
  #value =  module.vpc.public_subnet_ids
   value = join(",",module.vpc.public_subnet_ids) # Converting String to StringList
}

#["id1","id2"] terraform format, 
#id1, id2 --> AWS SSM format ,
resource "aws_ssm_parameter" "private_subnet_ids" {
  name  = "/${var.project_name}/${var.environment}/private_subnet_ids" # vpc will store its private subnet ids id in SSM Parameter store.
  type  = "StringList"
  #value =  module.vpc.private_subnet_ids
  value = join(",",module.vpc.private_subnet_ids) # Converting String to StringList
}

# These are parameters useful for database server
resource "aws_ssm_parameter" "db_subnet_group_name" { # vpc will store its db subnet group name in SSM Parameter store.
  name  = "/${var.project_name}/${var.environment}/db_subnet_group_name"
  type  = "String"
  value =  module.vpc.database_subnet_group_name
}