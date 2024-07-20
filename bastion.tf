resource "aws_instance" "bastion" {
  ami           = "ami-06c68f701d8090592"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet-public-01a.id
  vpc_security_group_ids = [aws_security_group.bastion.id]
  key_name      = "test"
  associate_public_ip_address = true
  
  user_data = <<-EOF
             #!/bin/bash
             sudo dnf install -y postgresql15 postgresql15-server
             sudo postgresql-setup --initdb
             sudo systemctl start postgresql
             sudo systemctl enable postgresql
             EOF

  tags = {
    Name = "BastionHost"
    Environment = "${var.environment}"
  }
}

