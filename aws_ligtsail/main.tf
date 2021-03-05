terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.31.0"
    }
  }
}


resource "aws_lightsail_instance" "test" {
  name              = "lightsail_test"
  availability_zone = "ap-southeast-1a"
  blueprint_id      = "ubuntu_20_04"
  bundle_id         = "nano_2_0"
  key_pair_name     = "lightsail_nex4"
  tags = {
    nex4 = "lightsail_test"
  }
}

# Create a new Lightsail Key Pair
resource "aws_lightsail_key_pair" "lightsail_nex4" {
  name = "lightsail_nex4"
}

# create static ip
resource "aws_lightsail_static_ip" "test" {
  name = "lightsail_nex4_ip"
}

# attach static ip
resource "aws_lightsail_static_ip_attachment" "test" {
  static_ip_name = aws_lightsail_static_ip.test.id
  instance_name  = aws_lightsail_instance.test.id
}

