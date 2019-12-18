variable "aws_region" {
  description = "EC2 Region for the VPC"
  default     = "eu-west-1"
}

variable "availability_zone1" {
  description = "Avaialbility Zones"
  default     = "eu-west-1a"
}

variable "availability_zone2" {
  description = "Avaialbility Zones"
  default     = "eu-west-1b"
}

variable "ctops_vpc_cidr" {
  description = "CIDR of the VPC"
  default     = "10.0.0.0/16"
}

variable "key_name" {
  description = "ssh_keyname"
  default     = "ctops"
}

variable "instance_type" {
  description = "ec2 instance type"
  default     = "t2.micro"
}

variable "ami" {
  description = "AMI to reference"
  default     = "ami-02df9ea15c1778c9c"
}
