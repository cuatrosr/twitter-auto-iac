variable "rg_location" {
  type        = string
  default     = "eastus"
  description = "The Azure Region where the Resource Group should exist."
}

variable "rg_name" {
  type        = string
  default     = "rg-twitter-auto"
  description = "The Name which should be used for this Resource Group."
}

variable "rg_tags" {
  type        = map(string)
  default     = { "Environment" : "Development" }
  description = "A mapping of tags which should be assigned to the Resource Group."

  validation {
    condition     = length(var.rg_tags) > 0
    error_message = "Tags must contain more than 1 value."
  }
}
