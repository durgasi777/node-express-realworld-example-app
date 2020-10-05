variable "env" {
  type = string
  description = "Environment"
  default = "Dev"
}

variable "region" {
  type = string     
  description = "AWS Region"
  default = "ap-southeast-2"
}

variable "key_name" {
  type = string
  description = "Pem Key"
  default = "karthik"
}