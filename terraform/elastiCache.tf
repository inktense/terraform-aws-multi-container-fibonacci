resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "${var.elasticache_name}"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 0
  parameter_group_name = "default.redis3.2"
  engine_version       = "3.2.10"
  port                 = 6379
  security_group_ids   = ["${aws_security_group.docker-multi-container.id}"] 
}
