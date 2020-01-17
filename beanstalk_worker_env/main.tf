data "aws_elastic_beanstalk_solution_stack" "docker" {
  most_recent = true
  name_regex  = "^64bit Amazon Linux (.*) running Docker (.*)$"
}

resource "aws_security_group" "instances" {
  name = "${var.app_name}-${var.app_instance}-worker"

  // Allow SSH access from anywhere
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
}

resource "aws_elastic_beanstalk_environment" "environment" {
  name                = var.name
  application         = var.app_name
  solution_stack_name = data.aws_elastic_beanstalk_solution_stack.docker.name
  tier                = "Worker"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = var.instance_type
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
    value     = var.key_pair
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value = join(
      ",",
      concat([aws_security_group.instances.name], var.security_groups),
    )
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-elasticbeanstalk-ec2-role"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "ServiceRole"
    value     = "aws-elasticbeanstalk-service-role"
  }

  // Stream logs to Cloudwatch, and hold them for 90 days
  setting {
    namespace = "aws:elasticbeanstalk:cloudwatch:logs"
    name      = "StreamLogs"
    value     = "true"
  }

  setting {
    namespace = "aws:elasticbeanstalk:cloudwatch:logs"
    name      = "RetentionInDays"
    value     = "90"
  }

  setting {
    namespace = "aws:elasticbeanstalk:hostmanager"
    name      = "LogPublicationControl"
    value     = "true"
  }

  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "SystemType"
    value     = "enhanced"
  }

  setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name      = "RollingUpdateEnabled"
    value     = "true"
  }

  # Define environment variables for the application.
  # TODO Terraform v0.12 introduces dynamic nested blocks to make this better
  # https://www.hashicorp.com/blog/hashicorp-terraform-0-12-preview-for-and-for-each#dynamic-nested-blocks
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = element(keys(var.environment_variables), 0)
    value = lookup(
      var.environment_variables,
      element(keys(var.environment_variables), 0),
      "",
    )
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = element(keys(var.environment_variables), 1)
    value = lookup(
      var.environment_variables,
      element(keys(var.environment_variables), 1),
      "",
    )
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = element(keys(var.environment_variables), 2)
    value = lookup(
      var.environment_variables,
      element(keys(var.environment_variables), 2),
      "",
    )
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = element(keys(var.environment_variables), 3)
    value = lookup(
      var.environment_variables,
      element(keys(var.environment_variables), 3),
      "",
    )
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = element(keys(var.environment_variables), 4)
    value = lookup(
      var.environment_variables,
      element(keys(var.environment_variables), 4),
      "",
    )
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = element(keys(var.environment_variables), 5)
    value = lookup(
      var.environment_variables,
      element(keys(var.environment_variables), 5),
      "",
    )
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = element(keys(var.environment_variables), 6)
    value = lookup(
      var.environment_variables,
      element(keys(var.environment_variables), 6),
      "",
    )
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = element(keys(var.environment_variables), 7)
    value = lookup(
      var.environment_variables,
      element(keys(var.environment_variables), 7),
      "",
    )
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = element(keys(var.environment_variables), 8)
    value = lookup(
      var.environment_variables,
      element(keys(var.environment_variables), 8),
      "",
    )
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = element(keys(var.environment_variables), 9)
    value = lookup(
      var.environment_variables,
      element(keys(var.environment_variables), 9),
      "",
    )
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = element(keys(var.environment_variables), 10)
    value = lookup(
      var.environment_variables,
      element(keys(var.environment_variables), 10),
      "",
    )
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = element(keys(var.environment_variables), 11)
    value = lookup(
      var.environment_variables,
      element(keys(var.environment_variables), 11),
      "",
    )
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = element(keys(var.environment_variables), 12)
    value = lookup(
      var.environment_variables,
      element(keys(var.environment_variables), 12),
      "",
    )
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = element(keys(var.environment_variables), 13)
    value = lookup(
      var.environment_variables,
      element(keys(var.environment_variables), 13),
      "",
    )
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = element(keys(var.environment_variables), 14)
    value = lookup(
      var.environment_variables,
      element(keys(var.environment_variables), 14),
      "",
    )
  }
}

