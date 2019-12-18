################ VPC #################
resource "aws_vpc" "ctops" {
  cidr_block           = var.ctops_vpc_cidr
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "ctops"
  }
}

################# Subnets #############
resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.ctops.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.availability_zone1

  tags = {
    Name = "ctops-subnet-1"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.ctops.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = var.availability_zone2

  tags = {
    Name = "ctops-subnet-2"
  }
}

resource "aws_subnet" "subnet3" {
  vpc_id            = aws_vpc.ctops.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = var.availability_zone1

  tags = {
    Name = "ctops-elb-subnet-1"
  }
}

resource "aws_subnet" "subnet4" {
  vpc_id            = aws_vpc.ctops.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = var.availability_zone2

  tags = {
    Name = "ctops-elb-subnet-2"
  }
}

resource "aws_subnet" "subnet5" {
  vpc_id            = aws_vpc.ctops.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = var.availability_zone1

  tags = {
    Name = "ctops-db-subnet-1"
  }
}

resource "aws_subnet" "subnet6" {
  vpc_id            = aws_vpc.ctops.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = var.availability_zone2

  tags = {
    Name = "ctops-db-subnet-2"
  }
}

resource "aws_subnet" "subnet7" {
  vpc_id            = aws_vpc.ctops.id
  cidr_block        = "10.0.7.0/24"
  availability_zone = var.availability_zone1

  tags = {
    Name = "ctops-nat-subnet-1"
  }
}

resource "aws_subnet" "subnet8" {
  vpc_id            = aws_vpc.ctops.id
  cidr_block        = "10.0.8.0/24"
  availability_zone = var.availability_zone2

  tags = {
    Name = "ctops-nat-subnet-2"
  }
}

######## IGW ###############
resource "aws_internet_gateway" "ctops-igw" {
  vpc_id = aws_vpc.ctops.id

  tags = {
    Name = "ctops-igw"
  }
}

########### NAT ##############
resource "aws_eip" "nat" {
}

resource "aws_nat_gateway" "ctops-natgw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.subnet8.id

  tags = {
    Name = "ctops-nat"
  }
}

############# Route Tables ##########

resource "aws_route_table" "ctops-public-rt" {
  vpc_id = aws_vpc.ctops.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ctops-igw.id
  }

  tags = {
    Name = "ctops-public-rt"
  }
}

resource "aws_route_table" "ctops-private-rt" {
  vpc_id = aws_vpc.ctops.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ctops-natgw.id
  }

  tags = {
    Name = "ctops-private-rt"
  }
}

######### PUBLIC Subnet assiosation with rotute table    ######
resource "aws_route_table_association" "public-assoc-1" {
  subnet_id      = aws_subnet.subnet3.id
  route_table_id = aws_route_table.ctops-public-rt.id
}

resource "aws_route_table_association" "public-assoc-2" {
  subnet_id      = aws_subnet.subnet4.id
  route_table_id = aws_route_table.ctops-public-rt.id
}

resource "aws_route_table_association" "public-assoc-3" {
  subnet_id      = aws_subnet.subnet7.id
  route_table_id = aws_route_table.ctops-public-rt.id
}

resource "aws_route_table_association" "public-assoc-4" {
  subnet_id      = aws_subnet.subnet8.id
  route_table_id = aws_route_table.ctops-public-rt.id
}

########## PRIVATE Subnets assiosation with rotute table ######
resource "aws_route_table_association" "private-assoc-1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.ctops-private-rt.id
}

resource "aws_route_table_association" "private-assoc-2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.ctops-private-rt.id
}

resource "aws_route_table_association" "private-assoc-3" {
  subnet_id      = aws_subnet.subnet5.id
  route_table_id = aws_route_table.ctops-private-rt.id
}

resource "aws_route_table_association" "private-assoc-4" {
  subnet_id      = aws_subnet.subnet6.id
  route_table_id = aws_route_table.ctops-private-rt.id
}
