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
    # create local script with exact ansible args
    provisioner "local-exec" {
        # TODO: implement host key checking
        # TODO: factor out ssh username
        command = "echo 'ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u root --private-key ${var.pvt_key_path} -i ${digitalocean_droplet.vibrato-test.ipv4_address}, configure.yaml -e ansible_python_interpreter=/usr/bin/python3' > ansible/run.sh && chmod +x ansible/run.sh"
    }

    # now run the playbook
    provisioner "local-exec" {
        command = "cd ansible; ./run.sh"
    }
}

output "ip" {
  value = digitalocean_droplet.vibrato-test.ipv4_address
}

