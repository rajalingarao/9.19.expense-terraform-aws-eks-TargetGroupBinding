variable "project_name" {
    default = "expense"
}
variable "environment" {
    default = "dev"
}
variable "common_tags" {
    default = {
        Project = "expense"
        Environment = "dev"
        Terraform = "true"
        Component = "ingress-alb"
    }
}
variable "zone_name" {
  default = "lithesh.shop"
}
variable "zone_id" {
  default = "Z012785114HGZTDQ8KSQH"
}