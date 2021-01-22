# Create an Application Load Balancer
resource "aws_lb" "jenkinsalb" {
  name               = "jenkins-alb"
  load_balancer_type = "application"
  internal           = false
  subnets            = data.aws_subnet_ids.default.ids
  security_groups    = [aws_security_group.albSG.id]

}
resource "aws_lb_target_group" "asg" {
  name     = "asg-TG"
  port     = var.jenkins_port
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  # Configure Health Check for Target Group
  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "403"
    interval            = 15
    timeout             = 6
    healthy_threshold   = 3
    unhealthy_threshold = 10
  }
}

# Configure Listeners for ALB
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.jenkinsalb.arn
  port              = var.alb_port
  protocol          = "HTTP"

  # By default, return a simple 404 page
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = 404
    }
  }
}

# Provides Load balancer with a listener rule resource
resource "aws_lb_listener_rule" "asg" {
  # The ARN of the listener to which to attach the rule.
  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  condition {
    # Optional - List of paths to match
    path_pattern {
      values = ["*"]
    }
  }

  action {
    # The type of routing action. 
    type             = "forward"
    target_group_arn = aws_lb_target_group.asg.arn
  }
}

# Output
output "alb_dns_name" {
  value       = aws_lb.jenkinsalb.dns_name
  description = "The domain name of the load balancer"
}
