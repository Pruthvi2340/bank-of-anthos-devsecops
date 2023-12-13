variable "region" {
  type        = string
  description = "Region for the resource"
}

variable "location" {
  type        = string
  description = "Location represents region/zone for the resource."
}

variable "network_name" {
  type = string
}

variable "project_id" {
  type        = string
  description = "Deploying Project ID"
}
