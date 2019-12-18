resource "aws_security_group" "ctops" {
  name = "ctops"
  description = "security group for ctops"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["92.51.251.123/32", "89.100.106.249/32"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["92.51.251.123/32", "89.100.106.249/32"]
  }

  egress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  vpc_id = aws_vpc.ctops.id
}

resource "aws_instance" "ctops1" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = "terraform_ec2_key"
  user_data = file("deploy/install_gitlab.sh")
  security_groups = ["${aws_security_group.ctops.id}"]
  subnet_id = aws_subnet.subnet7.id
  associate_public_ip_address = true

  tags = {
      Name = "ctops-gitlab"
      BUSINESSUNIT = "CTOPS"
      APPLICATIONENV = "GITLAB"
      APPLICATIONROLE = "CICD"
      OWNEREMAIL = "dgowran@informatica.com"
      RUNNINGSCHEDULE = "00:00:23:59:1-7"
      NAME = "GITLAB"
      POD = "CTOPS"
      BUSINESSENTITY = "CTOPS"
      SERVICENAME = "CTOPS"
      ALERTGROUP = "CTOPS"
    }

}

resource "aws_key_pair" "terraform_ec2_key" {
  key_name = "terraform_ec2_key"
  public_key = file("terraform_ec2_key.pub")
}
