ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u root --private-key ~/.ssh/id_rsa -i '134.209.108.48,' configure.yaml -e 'ansible_python_interpreter=/usr/bin/python3'