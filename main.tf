{\rtf1\ansi\ansicpg1252\cocoartf1504\cocoasubrtf830
{\fonttbl\f0\fmodern\fcharset0 Courier;}
{\colortbl;\red255\green255\blue255;\red0\green0\blue0;}
{\*\expandedcolortbl;;\cssrgb\c0\c0\c0;}
\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\deftab720
\pard\pardeftab720\partightenfactor0

\f0\fs26 \cf0 \expnd0\expndtw0\kerning0
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\
# DEPLOY A SINGLE EC2 INSTANCE\
# This template runs a simple "Hello, World" web server on a single EC2 Instance\
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\
\
# ------------------------------------------------------------------------------\
# CONFIGURE OUR AWS CONNECTION\
# ------------------------------------------------------------------------------\
\
provider "aws" \{\
  region = "us-east-1"\
\}\
\
# ---------------------------------------------------------------------------------------------------------------------\
# DEPLOY A SINGLE EC2 INSTANCE\
# ---------------------------------------------------------------------------------------------------------------------\
\
resource "aws_instance" "example" \{\
  # Ubuntu Server 14.04 LTS (HVM), SSD Volume Type in us-east-1\
  # i3 large instance type for high computational performance\
  ami = "ami-2d39803a"\
  instance_type = \'93i3.large\'94\
  vpc_security_group_ids = ["$\{aws_security_group.instance.id\}"]\
\
  user_data = <<-EOF\
              #!/bin/bash\
              echo "Hello" > index.html\
              nohup busybox httpd -f -p "$\{var.server_port\}" &\
              EOF\
\
  tags \{\
    Name = "terraform-example"\
  \}\
\}\
\
# CREATE THE SECURITY GROUP THAT'S APPLIED TO THE EC2 INSTANCE\
\
resource "aws_security_group" "instance" \{\
  name = "terraform-example-instance"\
\
  # Inbound HTTP from anywhere\
  ingress \{\
    from_port = "$\{var.server_port\}"\
    to_port = "$\{var.server_port\}"\
    protocol = "tcp"\
    cidr_blocks = ["0.0.0.0/0"]\
  \}\
\}}