resource "aws_vpc" "test_vpc" {
  cidr_block = var.block1
  tags = {
    Name = var.vpcname
  }
}

resource "aws_subnet" "pubsub01" {
  vpc_id                  = aws_vpc.test_vpc.id
  cidr_block              = var.block2
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = var.pubsub01
  }
}

resource "aws_subnet" "pubsub02" {
  vpc_id                  = aws_vpc.test_vpc.id
  cidr_block              = var.block3
  availability_zone       = "us-west-2b"
  map_public_ip_on_launch = true
  tags = {
    Name = var.pubsub02
  }
}


resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.test_vpc.id
}

resource "aws_route_table" "pubroute" {
  vpc_id = aws_vpc.test_vpc.id

  route {
    cidr_block = var.block4
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
}

resource "aws_route_table_association" "routeassoc1" {
  route_table_id = aws_route_table.pubroute.id
  subnet_id      = aws_subnet.pubsub01.id
}

resource "aws_route_table_association" "routeassoc2" {
  route_table_id = aws_route_table.pubroute.id
  subnet_id      = aws_subnet.pubsub02.id
}