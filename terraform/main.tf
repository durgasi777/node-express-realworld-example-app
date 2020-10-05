resource "aws_instance" "node-express" {
  count                       = 1
  ami                         = "ami-0b216a9fc227ebf67"
  instance_type               = "t2.small"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.amazon-linux.id]
  user_data_base64            = base64encode(data.template_file.userdata.rendered)
  key_name                    = var.key_name

  tags = {
    Name = "node-express-app"
    Environment = var.env
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = "${file("~/.ssh/karthik.pem")}"
	  timeout   	= "2m"
  }
}

resource "aws_security_group" "amazon-linux" {
  name        = "amazon-linux-security-group"
  description = "Allow Custom TCP and SSH traffic"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Custom TCP"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Custom TCP"
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform"
  }
}