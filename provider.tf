variable "do_token" {}
variable "pub_key_path" {
  default = "~/.ssh/id_rsa.pub"
}
variable "pvt_key_path" {
  default = "~/.ssh/id_rsa"
}
variable "ssh_fingerprint" {}

provider "digitalocean" {
  token = "${var.do_token}"
}

