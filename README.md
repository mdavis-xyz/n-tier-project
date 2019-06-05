# Tech Assessment

The requirements are described in `spec.md`.

## Assumptions:

### 1

The part saying:

> connect to a web server on port 80 or 8080

means that I may choose either port. (Not that the end user can access it on either)

### 2

"single-machine" means no managed databases, managed load-balancers, S3 etc.


## Design

The web page the end user sees is a staff directory of Sydney-based Vibrato staff.
(I think there is one person missing. This list is just who LinkedIn knows about.)
When you visit the IP address in a browser (port 80), you see a static HTML page (with static JavaScript and CSS). 
When you click the button, the JavaScript does a GET request, which hits nginx, then a Python Flask app, then MySQL, returning JSON, which gets loaded into the DOM by JavaScript.

The chosen design is:

* Terraform to deploy the VM
* Ansible to configure everything on the VM
* Nginx to be the front-end web-server
* python (flask) to glue nginx to the database
* redis or SQL as the back-end database
   * the data in the database is initialised with `ansible/data.json`. 

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
* database: haven't decided yet.


## Usage

* [install Terraform](https://www.terraform.io/downloads.html)
* run `terraform init`
* run `./deploy.sh` (which is just `terraform apply ...`)

If you are making changes to the ansible playbook, Terraform will not run the new playbook if you just do `terraform apply`.
This is why `run_ansible.sh` exists. 
It is written by `terraform apply`. 
It's just a handy way of shortening the dev loop, so you can apply the playbook without waiting for a whole VM rebuild.


