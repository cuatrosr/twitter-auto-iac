variable "vnet_name" {
  type        = string
  default     = "vnet-twitter-auto"
  description = "The name of the virtual network."
}

variable "rg_name" {
  type        = string
  description = " The name of the resource group in which to create the virtual network."
}

variable "rg_location" {
  type        = string
  description = "The location/region where the virtual network is created."
}

variable "vnet_address_space" {
  type        = string
  default     = "10.0.0.0/16"
  description = "The address space that is used the virtual network."
}

variable "vnet_tags" {
  type        = map(string)
  default     = { "Environment" : "Development" }
  description = "Virtual Network tags"

  validation {
    condition     = length(var.vnet_tags) > 0
    error_message = "A mapping of tags to assign to the resource."
  }
}
