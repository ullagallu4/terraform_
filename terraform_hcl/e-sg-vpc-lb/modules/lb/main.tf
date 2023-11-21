# ALB
resource "aws_lb" "alb" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.sg_id
  subnets            = var.public_subnets_ids

  tags = {
    Environment = "production"
  }
}

# TG
resource "aws_lb_target_group" "tg1" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

# TG Attachment
resource "aws_lb_target_group_attachment" "tga" {
  count = length(var.instance_ids)
  target_group_arn = aws_lb_target_group.tg1.arn
  target_id        = var.instance_ids[count.index]
  port             = 80
}
# Listner
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg1.arn
  }
}