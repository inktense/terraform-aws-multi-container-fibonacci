locals {
  tags = merge(var.tags, {
    Project = var.project_prefix
  })

  env_vars = {
    PGUSER     = var.pg_username
    PGPASSWORD = var.pg_password
    PGDATABASE = var.db_name
    PGPORT     = "5432"
    PGHOST     = aws_db_instance.postgres.address
    REDIS_HOST = aws_elasticache_cluster.redis.cache_nodes.0.address
    REDIS_PORT = aws_elasticache_cluster.redis.cache_nodes.0.port
  }

}