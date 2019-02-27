/* User Data Scripts  - file locale below called from env pwd */
/* data "template_file" "userdata" {
  template = "${file("./modules/windows-master/userdata.sh")}"
} */

terraform {
  backend "s3" {}
}

/* Lookup latest Amazon Windows AMI */
data "aws_ami" "windows_ami" {
  most_recent = true
  owners     = ["self", "amazon"]

  filter {
    name   = "name"
    values = ["*Windows_Server-*"]
  }
}
# Master Server
resource "aws_instance" "windows" {
  ami                         = "${data.aws_ami.windows_ami.image_id}"
  availability_zone           = "${var.availability_zones[0]}"
  instance_type               = "${var.instance_type}"
  user_data                   = "${data.template_file.userdata.rendered}"
  key_name                    = "windows_dev"
  vpc_security_group_ids      = ["${aws_security_group.windows_sg.id}"]
  subnet_id                   = "${var.public_subnet_ids[0]}"
  associate_public_ip_address = false

  # Config used by the Application Load Balancer
  subnet_ids                  = "${data.aws_subnet_ids.default.ids}"
  aws_ssl_certificate_arn     = "${var.aws_ssl_certificate_arn}"
  dns_zone                    = "${var.dns_zone}"
  app_dns_name                = "${var.app_dns_name}"

  tags {
    Name        = "${var.app}-${var.environment}-windows"
    Environment = "${var.environment}"
    App         = "${var.app}"
  }

  volume_tags {
    Name        = "${var.app}-${var.environment}-windows-root-vol"
    Environment = "${var.environment}"
    App         = "${var.app}"
  }
}

resource "aws_security_group" "windows_sg" {
  name        = "${var.app}-${var.environment}-windows-sg"
  description = "Security group for the windows server"
  vpc_id      = "${var.vpc_id}"

  tags {
    Name        = "${var.app}-${var.environment}-windows-sg"
    Environment = "${var.environment}"
    App         = "${var.app}"
  }

  // Ping capability
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // HTTP access
    ingress {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  
  // windows access
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    // rdp access
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // Outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" // all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
}