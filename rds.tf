
resource "aws_db_subnet_group" "subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = [aws_subnet.subnet-private-02a.id, aws_subnet.subnet-private-02b.id]

  tags = {
    Name = "rds-subnet-group"
    Environment = "${var.environment}"
  }
}

resource "aws_db_instance" "postgresql" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "15.4"
  instance_class       = "db.t3.micro"
  identifier           = "my-rds-instance"
  db_name              = "mydatabase"
  username             = "postgres"
  manage_master_user_password = true
  db_subnet_group_name = aws_db_subnet_group.subnet_group.name
  multi_az             = true
  storage_encrypted    = true
  publicly_accessible  = false
  vpc_security_group_ids = [aws_security_group.sg-01.id]
  backup_retention_period = 7
  copy_tags_to_snapshot   = true
  delete_automated_backups = true
  skip_final_snapshot = true 
  blue_green_update {
    enabled = true 
  }
  tags = {
    Name = "MyRDSInstance"
  }
}
