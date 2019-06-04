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
    provisioner "local-exec" {
        # TODO: implement host key checking
        # TODO: factor out ssh username
        command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u root --private-key ${var.pvt_key_path} -i '${digitalocean_droplet.vibrato-test.ipv4_address},' configure.yaml -e 'ansible_python_interpreter=/usr/bin/python3'"
    }
}

resource "local_file" "run_ansible" {
  # TODO: factor this out, only save it once
  content = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u root --private-key ${var.pvt_key_path} -i '${digitalocean_droplet.vibrato-test.ipv4_address},' configure.yaml -e 'ansible_python_interpreter=/usr/bin/python3'"
  filename = "run_ansible.sh"
}
output "ip" {
  value = digitalocean_droplet.vibrato-test.ipv4_address
}

