variable "ni_id" {
  type        = string
  description = "The ID of the Network Interface."
}

variable "nsg_id" {
  type        = string
  description = "The ID of the Network Security Group which should be attached to the Network Interface."
}
