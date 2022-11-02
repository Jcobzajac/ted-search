variable "region" {
    description = "Region"
    type = string
    default = "eu-west-3"
}

variable "name" {
    description = "Name of owner"
    type = string
    default = "Jakub"
}

variable "surname" {
    description = "Surname of owner"
    type = string
    default = "Zajac"
}

variable "bootcamp" {
    type = string
    default = "Poland1"
}

variable "env" {
    type = string
    default = ""    

}
###   VPC VARIABLES   ###

variable "vpc_name" {
  description = "VPC"
  type = string 
  default = "myvpc"
}

variable "vpc_cidr_block" {
  description = "VPC CIDR Block"
  type = string 
  default = "10.0.0.0/16"
}

variable "vpc_availability_zones" {
  description = "VPC Availability Zones"
  type = list(string)
  default = ["eu-west-3a", "eu-west-3b"]
}

variable "vpc_public_subnets" {
  description = "VPC Public Subnets"
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

### EC2 INSTANCE VARIABLES   ###

variable "ec2_name" {
  description = "Application name"
  type = string 
  default = "Instance"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "instance_keypair" {
  type = string
  default = "paris-zajac"
}

variable "ami" {
  type = string
  default = "ami-0493936afbe820b28"
}
