# Tech Assessment

The requirements are described in `spec.md`.

## Design

The chosen design is:

* Terraform to deploy the VM
* Ansible to configure everything on the VM
* Apache or Nginx to be the front-end web-server
* python (flask) to glue apache/nginx to the database
* redis or SQL as the back-end database

The justification is:

* Terraform because it's a nice cloud-agnostic deployment tool.
  We can easily move to another provider, or add other PaaS/IaaS services
* Ansible because it is a nice yaml-based, idempotent tool.
* apache or nginx
  * not sure which yet. I need to do more research
  * I deliberately did not use just flask directly. The benefits of this extra tier is:
    * can handle SSL termination
    * can scale out to multiple processes (flask is single-threaded, same too with any nodejs equivilent)
    * can more efficiently serve static content
* python - flask app. I could probably find a way to directly connect apache/nginx to the database. However this gives us more flexibility for the addition of future features.
* database: haven't decided yet.

## Usage

* [install Terraform](https://www.terraform.io/downloads.html)
* run `terraform init`
* run `./deploy.sh` (which is just `terraform apply ...`)

If you are making changes to the ansible playbook, Terraform will not run the new playbook if you just do `terraform apply`.
This is why `run_ansible.sh` exists. 
It is written by `terraform apply`. 
It's just a handy way of shortening the dev loop, so you can apply the playbook without waiting for a whole VM rebuild.

## TODO

* serve static with nginx
* serve on port 80 and port 8080
* add database
* make the flask app use the database
