resource "aws_lb" "example" {
    name = var.alb_name 
    load_balancer_type = "application"
    subnets = var.subnet_ids 
    security_groups = [ aws_security_group.alb.id ]
}

resource "aws_lb_listener" "http" {
    load_balancer_arn = aws_lb.example.arn 
    port = local.http_port
    protocol = "HTTP"

    # By Default, return a simple 404 page
    default_action {
        type = "text/plain"
        message_body = "404: page not found"
        status_code = 404

    }

    resource "aws_security_group" "alb" {
        name = var.alb_name    
    }
}

# (...)
