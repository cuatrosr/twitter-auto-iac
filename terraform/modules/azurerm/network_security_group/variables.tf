variable "nsg_name" {
  type        = string
  default     = "nsg-twitter-auto"
  description = "Specifies the name of the network security group."
}

variable "rg_name" {
  type        = string
  description = "The name of the resource group in which to create the network security group."
}

variable "rg_location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists."
}

variable "nsg_tags" {
  type        = map(string)
  default     = { "Environment" : "Development" }
  description = "Network Security Group tags"

  validation {
    condition     = length(var.nsg_tags) > 0
    error_message = "A mapping of tags to assign to the resource."
  }
}
