ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u root --private-key ~/.ssh/id_rsa -i 128.199.189.208, configure.yaml -e ansible_python_interpreter=/usr/bin/python3 "$@"
