variable "aws_region" {
  description = "Region where main resources should be created."
  type        = string
  default     = "eu-west-2"
}

variable "project_prefix" {
  description = "Project prefix for naming resources."
  type        = string
  default     = "docker-multi-container"
}

variable "db_name" {
  description = "RDS name."
  type        = string
  default     = "fibvalues"
}

variable "elasticache_name" {
  description = "ElastiCache name."
  type        = string
  default     = "multi-docker-redis"
}

variable "tags" {
  description = "A map containing all the mandatory tags for the resources."
  type        = map(string)

  default = {
    Initialised = "2023-03-22"
    Project     = "docker-multi-container"
  }
}

variable "pg_password" {
  description = "Postgres password."
  type        = string
}

variable "pg_username" {
  description = "Postgres username."
  type        = string
  default     = "postgres"
}

variable "env_vars" {
  description = "values for environment variables."
  type        = map(string)

  default = {
    REDIS_HOST = "redis"
  }
}
