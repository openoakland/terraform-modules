resource "aws_security_group" "allowed" {
  name = "${var.namespace}-db-access"
}

resource "aws_security_group" "database" {
  name = "${var.namespace}-db"

  // Allow HTTP connections from the application instances
  ingress {
    from_port = 5432
    to_port   = 5432
    protocol  = "tcp"

    security_groups = ["${aws_security_group.allowed.id}"]
  }
}

resource "aws_db_instance" "database" {
  allocated_storage         = 20
  storage_type              = "gp2"
  engine                    = "postgres"
  engine_version            = "${var.db_engine_version}"
  instance_class            = "db.t2.micro"
  deletion_protection       = "${var.deletion_protection}"
  identifier                = "${var.namespace}"
  final_snapshot_identifier = "${var.namespace}-final"
  name                      = "${var.db_name}"
  username                  = "${var.db_username}"
  password                  = "${var.db_password}"
  publicly_accessible       = "false"
  backup_retention_period   = "7"
  backup_window             = "10:00-10:30"
  skip_final_snapshot       = "${var.skip_final_snapshot}"

  vpc_security_group_ids = [
    "${aws_security_group.database.id}",
  ]
}
