resource "aws_vpc" "dev_vpc" {
    cidr_block = "10.0.0.0/16"
  
}

resource "aws_subnet" "privatesub" {
    vpc_id = aws_vpc.dev_vpc.id
    cidr_block = "10.0.0.0/24"
  
}

resource "aws_subnet" "publicsub" {
  vpc_id = aws_vpc.dev_vpc.id
  cidr_block = "10.0.128.0/24"
}

resource "aws_internet_gateway" "devgateway" {
  vpc_id = aws_vpc.dev_vpc.id
}

resource "aws_route_table" "publicrtb" {
  vpc_id = aws_vpc.dev_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.devgateway.id
  }
}

resource "aws_route_table" "privatertb" {
  vpc_id = aws_vpc.dev_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
  }
}

resource "aws_route_table_association" "publicassos" {
  subnet_id = aws_subnet.publicsub.id
  route_table_id = aws_route_table.publicrtb.id
}

resource "aws_route_table_association" "privateassos" {
  subnet_id = aws_subnet.privatesub.id
  route_table_id = aws_route_table.privatertb.id
}