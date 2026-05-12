#First creating security group with modules
#Second attaching dependent ports to security group using aws Security group rule
module "db" {
#source ="../../5.12.terraform-aws-securitygroup"
source ="git::https://github.com/rajalingarao/5.12.terraform-aws-securitygroup.git?ref=main"
project_name = var.project_name
environment =  var.environment
sg_description = "SG for DB MySQL Instances"
vpc_id =  data.aws_ssm_parameter.vpc_id.value #We are getting the vpc_id from SSM parameter for DB Security group
common_tags = var.common_tags
sg_name = "db"
}
module "ingress" {
#source ="../../5.12.terraform-aws-securitygroup"
source ="git::https://github.com/rajalingarao/5.12.terraform-aws-securitygroup.git?ref=main"
project_name = var.project_name
environment =  var.environment
sg_description = "SG for Ingress Controller"
vpc_id =  data.aws_ssm_parameter.vpc_id.value #We are getting the vpc_id from SSM parameter for Backend Security group
common_tags = var.common_tags
sg_name = "ingress"
}
module "cluster" {
#source ="../../5.12.terraform-aws-securitygroup"
source ="git::https://github.com/rajalingarao/5.12.terraform-aws-securitygroup.git?ref=main"
project_name = var.project_name
environment =  var.environment
sg_description = "SG for EKS Control Plane"
vpc_id =  data.aws_ssm_parameter.vpc_id.value #We are getting the vpc_id from SSM parameter for Backend Security group
common_tags = var.common_tags
sg_name = "eks-control-plane"
}
module "node" {
#source ="../../5.12.terraform-aws-securitygroup"
source ="git::https://github.com/rajalingarao/5.12.terraform-aws-securitygroup.git?ref=main"
project_name = var.project_name
environment =  var.environment
sg_description = "SG for EKS node"
vpc_id =  data.aws_ssm_parameter.vpc_id.value #We are getting the vpc_id from SSM parameter for Backend Security group
common_tags = var.common_tags
sg_name = "eks-node"
}
module "bastion" {
#source ="../../5.12.terraform-aws-securitygroup"
source ="git::https://github.com/rajalingarao/5.12.terraform-aws-securitygroup.git?ref=main"
project_name = var.project_name
environment =  var.environment
sg_description = "SG for Bastion Instances"
vpc_id =  data.aws_ssm_parameter.vpc_id.value #We are getting the vpc_id from SSM parameter for Bastion Security group
common_tags = var.common_tags
sg_name = "bastion"
}

# #Bastion can be accessed from public
resource "aws_security_group_rule" "bastion_public" {
    type = "ingress"
    from_port = 22
    to_port =  22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = module.bastion.sg_id
}
#EKS Cluster can be accessed from bastion host
resource "aws_security_group_rule" "cluster_bastion" {
    type = "ingress"
    from_port = 443
    to_port =  443
    protocol = "tcp"
    source_security_group_id = module.bastion.sg_id # source is where you are getting traffic from.
    security_group_id = module.cluster.sg_id  
}
# #EKS Cluster plane accepting all traffic from nodes
resource "aws_security_group_rule" "cluster_node" {
    type = "ingress"
    from_port = 0
    to_port =  65535
    protocol = "-1" # All traffic
    source_security_group_id = module.node.sg_id # source is where you are getting traffic from.
    security_group_id = module.cluster.sg_id  
}
#EKS nodes accepting all traffic from control plane
resource "aws_security_group_rule" "node_cluster" {
    type = "ingress"
    from_port = 0
    to_port =  65535
    protocol = "-1" # All traffic
    source_security_group_id = module.cluster.sg_id 
    security_group_id = module.node.sg_id  
}
# #EKS nodes should accept all traffic from nodes with in VPC CIDR range
resource "aws_security_group_rule" "node_vpc" { #expense-vpc VPC CIDR
    type = "ingress"
    from_port = 0
    to_port =  65535
    protocol = "-1" # All traffic
    cidr_blocks = ["10.0.0.0/16"]  #expense-vpc VPC CIDR
    security_group_id = module.node.sg_id  
}
# #RDS accepting connections from bastion
resource "aws_security_group_rule" "db_bastion" {
    type = "ingress"
    from_port = 3306
    to_port =  3306
    protocol = "tcp" # All traffic
    source_security_group_id = module.bastion.sg_id # source is where you are getting traffic from.
    security_group_id = module.db.sg_id  
}
# #DB should accept connections from EKS nodes
resource "aws_security_group_rule" "db_node" {
    type = "ingress"
    from_port = 3306
    to_port =  3306
    protocol = "tcp" # All traffic
    source_security_group_id = module.node.sg_id # source is where you are getting traffic from.
    security_group_id = module.db.sg_id  
}
#Ingress ALB accepting traffic on 443
resource "aws_security_group_rule" "ingress_public_https" {
    type = "ingress"
    from_port = 443
    to_port =   443
    protocol = "tcp" # All traffic
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = module.ingress.sg_id  
}
#Ingress ALB accepting traffic on 80
resource "aws_security_group_rule" "ingress_public_http" {
    type = "ingress"
    from_port = 80
    to_port =   80
    protocol = "tcp" # All traffic
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = module.ingress.sg_id  
}
# #Node is accepting  traffic from ingress
resource "aws_security_group_rule" "node_ingress" {
    type = "ingress"
    from_port = 30000
    to_port =  32768
    protocol = "tcp" #All traffic
    source_security_group_id = module.ingress.sg_id # source is where you are getting traffic from.
    security_group_id = module.node.sg_id  
}
#EKS Cluster accepting all traffic from jenkins agent
# resource "aws_security_group_rule" "jenkins-agent_cluster" {
#     type = "ingress"
#     from_port = 0
#     to_port =  65535
#     protocol = "-1" # All traffic
#     cidr_blocks = ["172.31.0.0/16"]
#     security_group_id = module.cluster.sg_id  
# }