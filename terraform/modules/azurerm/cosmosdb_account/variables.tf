variable "rg_location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists."
}

variable "rg_name" {
  type        = string
  description = "The name of the resource group in which to create the Mongo db."
}

variable "of_type" {
  type        = string
  default     = "Standard"
  description = "The name of the Mongo db type"
}
variable "db_kind" {
  type        = string
  default     = "MongoDB"
  description = "The kind of the azure cosmodb account"
}
