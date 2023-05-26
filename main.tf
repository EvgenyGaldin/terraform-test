provider "aws" {
  region = "eu-central-1"
  access_key = "AKIAQZVYKKFQXZGM3EWY"
  secret_key = "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"
}

variable "subnet_cidr_block" {
  description = "subnet subnet block"
}

variable "vpc_cidr_block" {
  description = "vpc subnet block"
  type = string
}

resource "aws_vpc" "development-vpc" {
  cidr_block = var.vpc_cidr_block
  #cidr_block = var.subnet_cidr_block
  tags = {
    Name = "terraform"
  }
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id = aws_vpc.development-vpc.id
  cidr_block = var.subnet_cidr_block
  availability_zone = "eu-central-1a"
  tags = {
    Name = "terraform"
  }
}

data "aws_vpc" "existing_vpc" {
  default = true
}

resource "aws_subnet" "dev-subnet-2" {
  vpc_id = data.aws_vpc.existing_vpc.id
  cidr_block = "172.31.48.0/20"
  availability_zone = "eu-central-1a"
}

output "vpc-id" {
  value = aws_vpc.development-vpc.id
}

output "subnet1-id" {
  value = aws_subnet.dev-subnet-1.id
}

output "subnet2-id" {
  value = aws_subnet.dev-subnet-2.id
}