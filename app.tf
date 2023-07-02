module "app_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "app-sg"
  description = "Sg for app host"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "All traffic"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
  egress_cidr_blocks = [
     "0.0.0.0/0"
	]
  egress_rules = [
      "all-all"
    ]
}

resource "aws_instance" "app" {
  ami                    = "ami-053b0d53c279acc90"
  instance_type          = "t2.medium"
  key_name               = "mykey"
  subnet_id              = module.vpc.private_subnets[1]
  vpc_security_group_ids = [module.app_sg.security_group_id]

  tags = {
    Name = "App"
  }
}

