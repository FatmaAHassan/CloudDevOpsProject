variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}
variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}
