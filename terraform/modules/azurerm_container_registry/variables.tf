variable "cr_name" {
  type        = string
  default     = "crTwitterAuto"
  description = "Specifies the name of the Container Registry."
}

variable "rg_name" {
  type        = string
  description = "The name of the resource group in which to create the Container Registry."
}

variable "rg_location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists."
}

variable "cr_sku" {
  type        = string
  default     = "Basic"
  description = "The SKU name of the container registry."
}

variable "cr_admin_enabled" {
  type        = bool
  default     = true
  description = "Specifies whether the admin user is enabled."
}

variable "cr_tags" {
  type        = map(string)
  default     = { "Environment" : "Development" }
  description = "A mapping of tags to assign to the resource."

  validation {
    condition     = length(var.cr_tags) > 0
    error_message = "Tags must contain more than 1 value."
  }
}
