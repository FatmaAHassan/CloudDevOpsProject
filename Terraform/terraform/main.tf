terraform {
  backend "s3" {
    bucket = "cloud-devops-project-terraform-state-fatma"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

module "network" {
  source = "./modules/network"
}

module "server" {
  source    = "./modules/server"
  vpc_id    = module.network.vpc_id
  subnet_id = module.network.subnet_id
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  alarm_name          = "high-cpu-usage"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"
  dimensions = {
    InstanceId = module.server.instance_id
  }
}
