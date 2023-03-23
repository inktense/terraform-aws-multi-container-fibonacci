resource "aws_db_instance" "postgres" {
  allocated_storage    = 10
  db_name              = "${var.db_name}"
  engine               = "postgres"
  engine_version       = "14.6"
  instance_class       = "db.t3.micro"
  username             = "${var.pg_username}"
  password             = "${var.pg_password}"
  skip_final_snapshot  = true
  multi_az             = false

  vpc_security_group_ids = ["${aws_security_group.docker-multi-container.id}"]
}