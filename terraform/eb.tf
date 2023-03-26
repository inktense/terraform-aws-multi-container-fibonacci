# module "elastic_beanstalk_application" {
#   source = "cloudposse/elastic-beanstalk-application/aws"
#   # Cloud Posse recommends pinning every module to a specific version
#   version = "0.11.1"

#   name        = var.project_prefix
#   description = "Multi Docker container Fibonaci calculator"

#   context = module.this.context
# }

# module "elastic-beanstalk-environment" {
#   source  = "cloudposse/elastic-beanstalk-environment/aws"
#   version = "0.11.1"
#   region  = var.region
#   name    = "Dockermulticontainer-env"

#   solution_stack_name                = "64bit Amazon Linux 2 v3.5.5 running Docker"
#   elastic_beanstalk_application_name = module.elastic_beanstalk_application.elastic_beanstalk_application_name
#   # insert the 5 required variables here

#   env_vars = local.env_vars

# }







resource "aws_elastic_beanstalk_application" "app" {
  name        = var.project_prefix
  description = "Multi Docker container Fibonaci calculator"
}

resource "aws_elastic_beanstalk_environment" "env" {
  name                = "Dockermulticontainer-env"
  application         = var.project_prefix
  solution_stack_name = "64bit Amazon Linux 2 v3.5.5 running Docker"

  tier = "WebServer"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t2.micro"
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = 1
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-elasticbeanstalk-ec2-role"
  }

  # Add environment variables
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "PGUSER"
    value     = var.pg_username
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "PGPASSWORD"
    value     = var.pg_password
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "PGDATABASE"
    value     = var.db_name
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "PGHOST"
    value     = aws_db_instance.postgres.address
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "REDIS_HOST"
    value     = aws_elasticache_cluster.redis.cache_nodes.0.address
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "REDIS_PORT"
    value     = aws_elasticache_cluster.redis.cache_nodes.0.port
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "PGPORT"
    value     = "5432"
  }



  # Add security group to allow access to RDS and ElastiCache
  setting {
    namespace = "aws:ec2:securitygroups"
    name      = "securitygroups"
    value     = aws_security_group.docker-multi-container.id
  }

  tags = local.tags
}