# Tech Assessment

The requirements are described in `spec.md`.

## Assumptions:

The part saying:

> connect to a web server on port 80 or 8080

means that I may choose either port. (Not that the end user can access it on either).
I have chosen just port 80.


## Design

The web page the end user sees is a staff directory of the Sydney-based staff.
(I think there is one person missing. This list is just who LinkedIn knows about.)
When you visit the IP address in a browser (port 80), you see a static HTML page (with static JavaScript and CSS). 
When you click the button, the JavaScript does a GET request, which hits nginx, then a Python Flask app, then MySQL, returning JSON, which gets loaded into the DOM by JavaScript.

The chosen design is:

* Terraform to deploy the VM
* Ansible to configure everything on the VM
* Nginx to be the front-end web-server
* Python (Flask) to glue nginx to the database
* MySQL as the back-end database
   * the data in the database is initialised with `ansible/data.json`. 
* DigitalOcean as the cloud provider

The justification is:

* Terraform because it's a nice cloud-agnostic deployment tool.
  We can easily move to another provider, or add other PaaS/IaaS services
   * I considered Kubernetes. However the spec says "single-machine", and you don't get most of the benefits of Kubernetes on a single machine. Also, the requirement is for a single command deployment. Kubernetes deployments require two steps (container build, `kubectl apply`).  
   * I considered CloudFormation. However that's not as cloud-agnostic. Also, for single-machine deployments you end up still needing a large boilerplate. E.g. I don't care much about IAM roles if my account just has one VM.
* Ansible because it is a nice yaml-based, idempotent tool.
* nginx
  * chosen over apache because I find nginx easier
  * I deliberately did not use just flask directly. The benefits of this extra tier is:
    * can handle SSL termination
    * can scale out to multiple processes (flask is single-threaded, same too with any nodejs equivilent)
    * can more efficiently serve static content
* python - flask app. I could probably find a way to directly connect nginx to the database. However this gives us more flexibility for the addition of future features.
* MySQL
   * Normally I would choose a managed database service (e.g. AWS DynamoDB). However the spec says "single-machine". So I assume this means I cannot use a PaaS storage service. (Instead I can demonstrate that I can set up my own db if I must.)

* Digital Ocean
   * Mostly I just want to try it out. I've used the others already. I want to learn something new.
   * When the IaaS/PaaS side of things is just one VM, I find Digital Ocean is a good choice. It's *very* fast, and also cheaper and simpler than the bigger players. If we want to add a feature later using a provider-specific PaaS service, we can easily change the Terraform template.



## Usage

* [install Terraform](https://www.terraform.io/downloads.html)
* run `terraform init`
* create a Digital Ocean API key, save it in `creds/do.txt` (which is excluded with `.gitignore`)
* create a file `creds/sql_pass.txt` which is a password to be used for SQL on the server. (Yes, bad practice I know. But there's a short time limit for this task. Of course I'd do proper secret storage as the next step.)
* run `./deploy.sh` (which is just `terraform apply ...` with the right arguments for credentials)
* that command prints out an IP address at the end. Visit that address in your browser.

If you are making changes to the ansible playbook, Terraform will not run the new playbook if you just do `terraform apply`.
This is why `run_ansible.sh` exists. 
It is written by `terraform apply`. 
It's just a handy way of shortening the dev loop, so you can apply the playbook without waiting for a whole VM rebuild.


