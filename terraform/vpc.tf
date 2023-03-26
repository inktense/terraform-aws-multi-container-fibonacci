resource "aws_security_group" "docker-multi-container" {
  name        = var.project_prefix
  description = var.project_prefix

  ingress {
    description = "${var.project_prefix} - container communication"
    from_port   = 5432
    to_port     = 6379
    protocol    = "tcp"
    self        = true
  }

  tags = local.tags
}