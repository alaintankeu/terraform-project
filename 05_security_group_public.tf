
variable "ssh_from_port" {
  type = number
  default = 80
}
variable "ssh_to_port" {
  type = number
  default = 80
}
variable "tcp_protocol" {
  type = string
  default = "TCP"
}

resource "aws_security_group" "public" {
  name = "public-sg"
  description = "Public internet access"
  vpc_id = aws_vpc.main.id

}

module "security_group_rule" {
  source = "./Mod_sgroup_rule"

  security_group_id = aws_security_group.public.id
  ssh_from_port = var.ssh_from_port
  ssh_to_port = var.ssh_to_port
  tcp_protocol = var.tcp_protocol
}







