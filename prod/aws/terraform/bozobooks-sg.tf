resource "aws_security_group" "bozobooks_node_group_one" {
  name_prefix = "bozobooks_node_group_one"
  vpc_id      = module.bozobooks_vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/8",
    ]
  }
}

resource "aws_security_group" "bozobooks_node_group_two" {
  name_prefix = "bozobooks_node_group_two"
  vpc_id      = module.bozobooks_vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "192.168.0.0/16",
    ]
  }
}