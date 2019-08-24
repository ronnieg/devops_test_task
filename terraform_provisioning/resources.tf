resource "aws_vpc" "test_vpc" {
  cidr_block       = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags = {
    Name = "test_vpc"
  }
}

resource "aws_internet_gateway" "test_gateway" {
    vpc_id = "${aws_vpc.test_vpc.id}"
}

resource "aws_subnet" "subnet_test" {
    vpc_id = "${aws_vpc.test_vpc.id}"

    cidr_block = "${var.public_subnet_cidr}"
    availability_zone = "us-east-1a"

    tags = {
        Name = "test_public_subnet"
    }
}

resource "aws_security_group" "test_security_group" {
    name = "test_vpc"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"] 
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

    vpc_id = "${aws_vpc.test_vpc.id}"

    tags = {
        Name = "test_security_group"
    }
}

resource "aws_instance" "test_machine" {
  ami = "${var.image_id}"
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  vpc_security_group_ids = ["${aws_security_group.test_security_group.id}"]
  subnet_id = "${aws_subnet.subnet_test.id}"
  associate_public_ip_address = true
  source_dest_check = false
  key_name = "${var.aws-key-name}"
  root_block_device {
    volume_size = 8
  }
  tags = {
    Name = "test_machine"
  }
}

resource "aws_route_table" "us-east-1a-public" {
    vpc_id = "${aws_vpc.test_vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.test_gateway.id}"
    }

    tags = {
        Name = "Public Subnet"
        Env = "STAGING"
    }
}

resource "aws_route_table_association" "us-east-1a-public" {
    subnet_id = "${aws_subnet.subnet_test.id}"
    route_table_id = "${aws_route_table.us-east-1a-public.id}"
}
