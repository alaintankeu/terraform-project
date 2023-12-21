# # Creating variables for security group.
# # //////////////////////////////////////////////

# variable "sg_ingress_rules" {
#   type = map
#   description = "Allow sg ingress rule"
# }

# # Creating security group resource dynamically.
# #  ////////////////////////////////////////////

# resource "aws_security_group" "dynamic_sg_loop" {
#   name        = "tf-sg"
#   description = "Allow web traffics"
#   vpc_id  = aws_vpc.main.id

# dynamic "ingress"    {
# for_each = var.sg_ingress_rules
#   content {  
    
#       description      = ingress.value.description
#       from_port        = ingress.value.from_port
#       to_port          = ingress.value.to_port
#       protocol         = ingress.value.protocol
#       cidr_blocks      = ingress.value.cidr_blocks  
#       ipv6_cidr_blocks = []
#       prefix_list_ids = []
#       security_groups = []
#       self = false
      
#       }

# }

#   egress = [
#     {
     
#       description      = "Allow all outgoing traffics"
#       from_port        = 0
#       to_port          = 0
#       protocol         = "-1"
#       cidr_blocks      = ["0.0.0.0/0"]
#       ipv6_cidr_blocks = ["::/0"]
#       prefix_list_ids = []
#       security_groups = []
#       self = false
      
#     }
#   ]

  
# }

# # Creating security group resource output.
# #  ////////////////////////////////////////////


# output "security_group_id" {

#   value = aws_security_group.dynamic_sg_loop.id    
  
# }



