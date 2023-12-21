variable "security_group_id" {}
variable "ssh_from_port" {}
variable "ssh_to_port" {}
variable "tcp_protocol" {}




resource "aws_security_group_rule" "public_ingress" {
  type        = "ingress"
  from_port   = var.ssh_from_port
  to_port     = var.ssh_to_port
  protocol    = var.tcp_protocol
  cidr_blocks = ["0.0.0.0/0"]
 
  security_group_id = var.security_group_id
}