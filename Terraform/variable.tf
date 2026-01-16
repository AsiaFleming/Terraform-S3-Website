variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "VPC CIDR Block"
  type        = string

}

variable "public-subnet-1-cidr" {
  default     = "10.0.0.0/24"
  description = "Public Subnet 1 CIDR Block"
  type        = string
}

variable "bucketname" {
  default     = "demo-asia-static-bucket-tf"
  description = "S3 Bucket Name"
  type        = string
}