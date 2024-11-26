variable "instance_type" {
  description = "AWS EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "The AMI ID for our Packer image needs to be here"
  type = string
  default = "ami-086216a3ce2ed354c"
}