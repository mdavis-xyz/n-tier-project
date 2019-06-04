#!/bin/bash
terraform destroy -var do_token=$(cat creds/do.txt) -auto-approve
