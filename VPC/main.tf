# VPC Resource Block
resource "aws_vpc" "dev_vpc" {
  cidr_block           = var.vpc_ipv4_cidr
  instance_tenancy     = var.vpc_instance_tenancy
  enable_dns_hostnames = var.vpc_enable_dns_hostnames

  tags = var.vpc_tags
}

# VPC Public Subnet
resource "aws_subnet" "vpc_pub_subnet" {
vpc_id = aws_vpc.dev_vpc.id
cidr_block = var.pub_sub_cidr
availability_zone = var.avz["0"]
map_public_ip_on_launch = true     #instances launched into the subnet should be assigned a public IP address

tags = var.vpc_pub_subnet_tags
}

# VPC Private Subnet
/*resource "aws_subnet" "vpc_pvt_subnet" {
  
} */

# VPC Internet Gateway
resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = aws_vpc.dev_vpc.id

  tags = var.igw_tags
}

# VPC route table of Public subnet 
resource "aws_route_table" "vpc_pub_route_tbl" {
  vpc_id = aws_vpc.dev_vpc.id

  tags = var.route_tbl_tags
}

# VPC route table of Private subnet 
/*resource "aws_route_table" "vpc_pvt_route_tbl" {
  
} */

#Route in Route Table for Internet Access
resource "aws_route" "vpc_route" {
  route_table_id = aws_route_table.vpc_pub_route_tbl.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.vpc_igw.id
}

#Associate Route table to Public Subnet
resource "aws_route_table_association" "vpc_pub_route_tbl_associate" {
  subnet_id = aws_subnet.vpc_pub_subnet.id
  route_table_id = aws_route_table.vpc_pub_route_tbl.id
}

resource "aws_security_group" "vpc_sg" {
  name = var.vpc_security_group_name
  description = "Allow TCP inbound traffice"
  vpc_id = aws_vpc.dev_vpc.id

  ingress  {
    cidr_blocks = [aws_vpc.dev_vpc.cidr_block]
    ipv6_cidr_blocks = [aws_vpc.dev_vpc.ipv6_cidr_block]
    description = "TLS from VPC"
    from_port = 443
    protocol = "tcp"
    to_port = 443
  } 

  egress  {
    cidr_blocks = [ "0.0.0.0/0" ]
    ipv6_cidr_blocks = ["::/0"]
    description = "Allow TCP outbound traffic"
    from_port = 0
    protocol = "-1"
    to_port = 0
  } 

  tags = {
      Name = var.vpc_security_group_name
  }
}

#Create EC2 Instance

resource "aws_instance" "web" {
    ami                    = var.images["centos7"]
    instance_type          = var.instance_type
    subnet_id              = aws_subnet.vpc_pub_subnet.id
    key_name               = var.key_name
    user_data              = file("apache-install.sh")
    vpc_security_group_ids = [aws_security_group.vpc_sg.id]

    tags = {
        "Name" = "dev-ec2-tf"
    }
}

resource "aws_eip" "eip" {
    instance   = aws_instance.web.id
    vpc        = true
    depends_on = [aws_internet_gateway.vpc_igw]
}
