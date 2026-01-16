# Create Security Groups
# terraform aws create security group
resource "aws_security_group" "ssh_sg" {
  name        = "SSH Access Security Group"
  description = "Security group for SSH access"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name = "SSH Access Security Group"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.ssh_sg.id
  description       = "SSH Access"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = var.vpc_cidr
}

resource "aws_vpc_security_group_egress_rule" "eggress_ssh" {
  security_group_id = aws_security_group.ssh_sg.id
  description       = "All egress"
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"

}

resource "aws_security_group" "web_sg" {
  name        = "Web Access security Group"
  description = "Security group for web access"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name = "Web Access Security Group"
  }
}


resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.web_sg.id
  description       = "HTTP Access"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  cidr_ipv4         = var.vpc_cidr
}

resource "aws_vpc_security_group_egress_rule" "eggress_http" {
  security_group_id = aws_security_group.web_sg.id
  description       = "All egress"
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"

}