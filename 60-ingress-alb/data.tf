data "aws_ssm_parameter" "ingress_sg_id" {
    name ="/${var.project_name}/${var.environment}/ingress_sg_id" # we will get this value from security group.
}
data "aws_ssm_parameter" "public_subnet_ids" {
    name ="/${var.project_name}/${var.environment}/public_subnet_ids" # We will get this value from VPC
}
data "aws_ssm_parameter" "acm_certificate_arn" {
    name ="/${var.project_name}/${var.environment}/acm_certificate_arn" # We will get this value from VPC
}
data "aws_ssm_parameter" "vpc_id" {
    name ="/${var.project_name}/${var.environment}/vpc_id" # We will get this value from VPC
}