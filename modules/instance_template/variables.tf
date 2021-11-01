variable "name" {
  default = ""
}

variable "description" {
  default = ""
}

variable "instance_description" {
  default = ""
}

variable "boot" {
  default = "true"
}

variable "machine_type" {
  default = ""
}

variable "can_ip_forward" {
  default = "false"
}

variable "tags" {
  type    = list(string)
  default = []
}

variable "auto_delete" {
  default = "true"
}

variable "image" {
  default = ""
}

variable "network" {
  default = "default"
}

variable "startup_script" {
  default = ""
}


variable "service_account" {
  type = object({
    email  = string
    scopes = set(string)
  })
}

variable "access_config" {
  type = list(object({
    nat_ip       = string
    network_tier = string
  }))
  default = []
}
