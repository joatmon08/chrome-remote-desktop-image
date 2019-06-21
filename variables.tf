variable "project" {
  type = string
}

variable "region" {
  type = string
}

variable "prefix" {
  default = "crdhost"
}

variable "image" {
  type = string
}

variable "machine_type" {
  default = "n1-standard-1"
}

variable "crd_code" {
  type = string
}

variable "crd_pin" {
  type = string
}

variable "crd_user" {
  type = string
}

variable "public_key_file" {
  type = string
}