variable "aws-region" {
  type        = "string"
  description = "Amazon region"
}

variable "profile" {
  type = "string"
}

variable "shared_credentials_file" {
  type = "string"
}

variable "image_id" {
  type        = "string"
  description = "The id of the machine image (AMI) to use for the server."
}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
    description = "CIDR for the Public Subnet"
    default = "10.0.0.0/24"
}

variable "aws-key-name" {
  type        = "string"
  description = "EC2 acces key pair"
}

variable "use_public_ip" { 
    default = true 
}
