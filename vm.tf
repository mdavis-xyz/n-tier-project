resource "digitalocean_droplet" "vibrato-test" {
    image = "ubuntu-18-04-x64"
    name = "vibrato-test"
    region = "sgp1"
    size = "512mb"
    ssh_keys = [
      "${var.ssh_fingerprint}"
    ]
    connection {
        user = "root"
        type = "ssh"
        private_key = "${file(var.pvt_key_path)}"
        timeout = "2m"
        host = "${digitalocean_droplet.vibrato-test.ipv4_address}"
    }
    provisioner "remote-exec" {
    inline = [
      "touch test-remote-exec.txt"
    ]
  }
}

output "ip" {
  value = digitalocean_droplet.vibrato-test.ipv4_address
}

