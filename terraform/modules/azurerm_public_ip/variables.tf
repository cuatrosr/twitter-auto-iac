variable "pubip_name" {
  type        = string
  default     = "pubip-twitter-auto"
  description = "Specifies the name of the Public IP."
}

variable "rg_name" {
  type        = string
  description = "The name of the Resource Group where this Public IP should exist."
}

variable "rg_location" {
  type        = string
  description = "Specifies the supported Azure location where the Public IP should exist."
}

variable "pubip_allocation_method" {
  type        = string
  default     = "Static"
  description = "Defines the allocation method for this IP address."
}

variable "pubip_tags" {
  type        = map(string)
  default     = { "Environment" : "Development" }
  description = "Public Ip tags"

  validation {
    condition     = length(var.pubip_tags) > 0
    error_message = "A mapping of tags to assign to the resource."
  }
}
