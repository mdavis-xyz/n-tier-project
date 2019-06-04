#!/bin/bash
terraform apply -var do_token=$(cat creds/do.txt) -auto-approve
