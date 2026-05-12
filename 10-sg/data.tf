data "aws_ssm_parameter" "vpc_id" { # We will get VPC_id value from SSM Parameter store.
    name ="/${var.project_name}/${var.environment}/vpc_id"   #vpc-07ffe793ee453f9cf
    # For SG, We will get vpc_id form SSM parameter 
}