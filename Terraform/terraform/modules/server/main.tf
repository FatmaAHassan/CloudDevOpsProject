resource "aws_security_group" "jenkins_sg" {
  vpc_id = var.vpc_id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "jenkins_server" {
  ami           = "ami-0c55b159cbfafe1f0" # Ubuntu 22.04
  instance_type = "t2.medium"
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
  tags = { Name = "Jenkins-Server" }
}
