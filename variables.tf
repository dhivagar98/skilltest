variable "gcp_project_id" {
  type = string
  description = "The id of th eproject in which the resource belongs"
  default = "<your project id>"
}
variable "gcp_region" {
  type = string 
  default = "us-central"
}

variable "bucket_name" {
  type = string
  default = "dhiva_bucket"
}
