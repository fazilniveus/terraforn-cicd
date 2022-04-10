variable "gcp_credentials_path" {
    type = string
    description = "path to gpc credentials"
    default = "/opt/ansible/inventory/simple-devops-ci-cd/service-account.json"
}

variable "project_name" {
    type = string
    description = "project name for this provision"
    default = "simple-devops"
}

variable "region" {
    type = string
    description = "region for instance deployment location"
    default = "asia-southeast1"
}

variable "zone" {
    type = string
    description = "zone referring choosen region"
    default = "asia-southeast1-b"
}

variable "instance_num" {
    description = "number production instance deployment"
    default = "1"
}

variable "instance_num_stag" {
    description = "number staging instance deployment"
    default = "1"
}

# variable "ssh_pub_key_path" {
#     type = string
#     description = "ssh public key location"
#     default = "/home/alibasaeb/.ssh/devproc.pub"
# }

# variable "ssh_username" {
#     type = string
#     description = "ssh username for login"
#     default = "alibasaeb"
# }