variable "vm_count" {
  description = "Number of VMs to create"
  type        = number
  default     = 1
}

variable "vm_flavor" {
  description = "Flavor of the VM"
  type        = string
  default     = "t2.micro"
}

variable "vm_image" {
  description = "AMI ID of the VM"
  type        = string
  default     = "ami-0f2b1cec72092805c"
}