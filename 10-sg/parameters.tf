resource "aws_ssm_parameter" "db_sg_id" {
  name  = "/${var.project_name}/${var.environment}/db_sg_id" #This SG will store its SG id in SSM Parameter store.
  type  = "String"
  value =  module.db.sg_id
}
resource "aws_ssm_parameter" "bastion_sg_id" {
  name  = "/${var.project_name}/${var.environment}/bastion_sg_id"  #This SG will store its SG id in SSM Parameter store.
  type  = "String"
  value =  module.bastion.sg_id
}
resource "aws_ssm_parameter" "cluster_sg_id" {
  name  = "/${var.project_name}/${var.environment}/cluster_sg_id"  #This SG will store its SG id in SSM Parameter store.
  type  = "String"
  value =  module.cluster.sg_id
}
resource "aws_ssm_parameter" "node_sg_id" {
  name  = "/${var.project_name}/${var.environment}/node_sg_id"  #This SG will store its SG id in SSM Parameter store.
  type  = "String"
  value =  module.node.sg_id
}
resource "aws_ssm_parameter" "ingress_sg_id" {
  name  = "/${var.project_name}/${var.environment}/ingress_sg_id"  #This SG will store its SG id in SSM Parameter store.
  type  = "String"
  value =  module.ingress.sg_id
}