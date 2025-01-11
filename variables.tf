variable "name" {
  type = string
}

variable "rg" {
  type = object({
    name     = string
    location = string
    id       = string
  })
}

variable "root_records" {
  type = map(object({
    records            = optional(set(string))
    target_resource_id = optional(string)
    ttl                = optional(number)
  }))
  default  = {}
  nullable = false
}

variable "records" {
  type = map(object({
    type               = string
    records            = optional(set(string))
    target_resource_id = optional(string)
    ttl                = optional(number)
  }))
  default  = {}
  nullable = false
}