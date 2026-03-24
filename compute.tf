resource "aws_instance" "websever" {
  ami = ""
  associate_public_ip_address = true
  instance_type = t2.micro
  security_groups = [ aws_security_group.serverSG.id ]
  subnet_id = aws_subnet.privatesub.id

  root_block_device {
    delete_on_termination = true
    volume_size = 5
    volume_type = "gp2"
  }
}

resource "aws_security_group" "serverSG" {
  name = "serversg"
  vpc_id = aws_vpc.dev_vpc.id

}

resource "aws_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.serverSG.id
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 443
  to_port = 443
  ip_protocol = "tcp"

}

resource "aws_lb" "devalb" {
  name = "dev-ALBs"
  internal = false
  load_balancer_type = "application"
  subnets = aws

}



