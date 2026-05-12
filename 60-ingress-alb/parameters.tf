resource "aws_ssm_parameter" "web_alb_listener_arn" {
  name  = "/${var.project_name}/${var.environment}/web_alb_listener_arn" #This ARN will store its SG id in SSM Parameter store.
  type  = "String"
  value =  aws_lb_listener.http.arn
}
resource "aws_ssm_parameter" "web_alb_listener_arn_https" {
  name  = "/${var.project_name}/${var.environment}/web_alb_listener_arn_https" #This ARN will store its SG id in SSM Parameter store.
  type  = "String"
  value =  aws_lb_listener.https.arn
}
