resource "aws_security_group" "frontend_sg" {
    name        = "ramp_up_tf_andreslopezb_bastion"
    description = "Allow rules for Bastion Instances in Terraform"
    vpc_id      = "vpc-0e4d44423fe7413d9"
  
    egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

}

resource "aws_security_group_rule" "frontend_ingress_rules" {
    count = length(var.frontend_sg_ingress_rules)

    type              = "ingress"
    description       = var.frontend_sg_ingress_rules[count.index].description
    from_port         = var.frontend_sg_ingress_rules[count.index].from_port
    to_port           = var.frontend_sg_ingress_rules[count.index].to_port
    protocol          = var.frontend_sg_ingress_rules[count.index].protocol
    cidr_blocks       = [var.frontend_sg_ingress_rules[count.index].cidr_block]
    security_group_id = aws_security_group.frontend_sg.id
}

variable "frontend_sg_ingress_rules" {
    description = "List of outbound rules for Bastion instances"

    type = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_block  = string
      description = string
    }))

    default     = [
        {
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_block  = "0.0.0.0/0"
          description = "Rule for SSH connection from admin IP for Frontend Instances"
        },
        {
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_block  = "0.0.0.0/0"
          description = "Rule for HTTP connections for Frontend Instances"
        },
    ]
}