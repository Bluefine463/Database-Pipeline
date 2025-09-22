variable "prefix" {
  description = "Resource name prefix"
  type        = string
  default     = "msdemo"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "Central India"
}

variable "acr_name" {
  description = "ACR name (must be globally unique)"
  type        = string
}

variable "postgres_admin_username" {
  type    = string
  default = "pgadmin"
}

variable "postgres_admin_password" {
  description = "Postgres admin password (sensitive)"
  type        = string
  sensitive   = true
}

variable "postgres_name" {
  type    = string
  default = "pg-msdemo"
}

variable "postgres_db_name" {
  type    = string
  default = "usersdb"
}
