variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "service_name" {
  type = string
}

variable "identity" {
  type    = string
  default = null
}
