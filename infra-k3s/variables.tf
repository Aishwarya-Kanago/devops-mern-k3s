variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 instance type (free tier: t2.micro)"
  type        = string
  default     = "t3.micro"
}

variable "key_pair_name" {
  description = "Existing EC2 keypair name to SSH into instance"
  type        = string
  default     = ""
}

variable "project_name" {
  description = "Project name prefix"
  type        = string
  default     = "devops-mern-k3s"
}