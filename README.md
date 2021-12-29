# sagdevops-ansible-apigateway
Ansible roles specific to webMethods APIGateway

Roles:
- apigateway-files-configurator
  - These are configuration tasks that modify the files on webMethods APIGateway server(s) (and as such, these tasks must be run on the target APIGateway servers)
- apigateway-rest-configurator
  - These are configuration tasks that strictly leverage the REST APIs provided by webMethods APIGateway (and as such, these tasks can be run from anywhere with network access to the target webMethods APIGateway REST endpoints)

# Authors
Fabien Sanglier
- Emails: [@Software AG](mailto:fabien.sanglier@softwareag.com) [@Software AG Government Solutions](mailto:fabien.sanglier@softwareaggov.com)
- Github: 
  - [Fabien Sanglier @ SoftwareAG Government Solutions](https://github.com/fabien-sanglier-saggs)
  - [Fabien Sanglier](https://github.com/lanimall)

## Project dependencies:

Some of the tasks in these roles will have dependencies on roles defined in [sagdevops-ansible-common-utils](https://github.com/SoftwareAG/sagdevops-ansible-common-utils)
As such, make sure to include sagdevops-ansible-common-utils in your automation solution.

## Using Containers

### Pre-requisite - Base Ansible runner

If you haven't done so already, make sure to have the "sagdevops-ansible-runner" built and ready.
See instructions [README-base-ansible.md](https://github.com/SoftwareAG/sagdevops-ansible-common-utils/blob/main/README-base-ansible.md) for details.

### Building the container

First set some environment variables to specify the build arguments:

```
export REG=
export TAG=0.0.1
```

Then, build the common utils image:

```
docker build --rm -f Dockerfile -t ${REG}sagdevops-ansible-apigateway:latest -t ${REG}sagdevops-ansible-apigateway:${TAG} --build-arg BASE_ANSIBLE_IMAGE=${REG}sagdevops-ansible-runner  .
```

This will create 1 container image with 2 tags (1 tagged with the build version, 1 tagged as "latest"): 
 - ${REG}sagdevops-ansible-apigateway:latest
 - ${REG}sagdevops-ansible-apigateway:${TAG}

Test to make sure it's there:

```
docker images ${REG}sagdevops-ansible-apigateway:${TAG}
docker images ${REG}sagdevops-ansible-apigateway:latest
```
### Testing validity of the containers

We'll be running the simplest [ping.yml](./playbooks/ping.yml) playbook added to this project for testing:

```
docker run -v $PWD/playbooks:/ansible/playbooks ${REG}sagdevops-ansible-apigateway:${TAG} -v ping.yml
```

You should see the following output if all is well (notice the Task "ping" which should execute succesfully)

```
PLAY [all] *********************************************************************

TASK [Gathering Facts] *********************************************************
ok: [localhost]

TASK [ping] ********************************************************************
ok: [localhost] => {"changed": false, "ping": "pong"}

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

At this point, the image should be ready to be used.





## Role: apigateway-files-configurator

Documentation Details TBD

## Role: apigateway-rest-configurator

Documentation Details TBD

## Using Containers

### Building the containers

To build containers for the configurators

First set some environment variables to specify the build arguments:

```
export REG=
export TAG=0.0.1
export SAGDEVOPS_BASE_ANSIBLE=${REG}sagdevops-ansible-apigateway:0.0.1
```

Then, build the configurators by running:

```
docker build --rm -f Dockerfile.rest -t ${REG}apigateway-rest-configurator:${TAG} --build-arg BASE_ANSIBLE_IMAGE=${SAGDEVOPS_BASE_ANSIBLE} .

docker build --rm -f Dockerfile.files -t ${REG}apigateway-files-configurator:${TAG} --build-arg BASE_ANSIBLE_IMAGE=${SAGDEVOPS_BASE_ANSIBLE} .
```

This will create 2 containers:
 - ${REG}apigateway-rest-configurator:${TAG}
 - ${REG}apigateway-rest-configurator:${TAG}

### Testing validity of the containers

Test apigateway-rest-configurator:

```
docker run ${REG}apigateway-rest-configurator:${TAG} ping.yml
```

Test apigateway-files-configurator:

```
docker run ${REG}apigateway-files-configurator:${TAG} ping.yml
```

______________________
These tools are provided as-is and without warranty or support. They do not constitute part of the Software AG product suite. Users are free to use, fork and modify them, subject to the license agreement. While Software AG welcomes contributions, we cannot guarantee to include every contribution in the master project.
_____________
For more information you can Ask a Question in the [TECHcommunity Forums](http://tech.forums.softwareag.com/techjforum/forums/list.page?product=webmethods).

You can find additional information in the [Software AG TECHcommunity](http://techcommunity.softwareag.com/home/-/product/name/webmethods).
_____________
Contact us at [TECHcommunity](mailto:technologycommunity@softwareag.com?subject=Github/SoftwareAG) if you have any questions.
