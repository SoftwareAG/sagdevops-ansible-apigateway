# Sample Ansible Apigateway Configurator in containers

Using ansible roles specific to webMethods APIGateway in a configuration playbook

# Authors
Fabien Sanglier
- Emails: [@Software AG](mailto:fabien.sanglier@softwareag.com) [@Software AG Government Solutions](mailto:fabien.sanglier@softwareaggov.com)
- Github: 
  - [Fabien Sanglier @ SoftwareAG Government Solutions](https://github.com/fabien-sanglier-saggs)
  - [Fabien Sanglier](https://github.com/lanimall)

### Pre-requisite - Base Ansible runner

If you haven't done so already, make sure to have the "sagdevops-ansible-apigateway" container image built and ready.
See instructions [README.md](../../../README.md) for details.

### Building the container

First set some environment variables to specify the build arguments:

```
export REG=
export TAG=0.0.1
```

Then, build the sample configurator image:

```
docker build --rm -f Dockerfile -t ${REG}sagdevops-ansible-apigateway-sample-configurator:latest -t ${REG}sagdevops-ansible-apigateway-sample-configurator:${TAG} --build-arg BASE_ANSIBLE_IMAGE=${REG}sagdevops-ansible-apigateway  .
```

This will create 1 container image with 2 tags (1 tagged with the build version, 1 tagged as "latest"): 
 - ${REG}sagdevops-ansible-apigateway-sample-configurator:latest
 - ${REG}sagdevops-ansible-apigateway-sample-configurator:${TAG}

Test to make sure it's there:

```
docker images ${REG}sagdevops-ansible-apigateway-sample-configurator:${TAG}
docker images ${REG}sagdevops-ansible-apigateway-sample-configurator:latest
```

### Using the container





______________________
These tools are provided as-is and without warranty or support. They do not constitute part of the Software AG product suite. Users are free to use, fork and modify them, subject to the license agreement. While Software AG welcomes contributions, we cannot guarantee to include every contribution in the master project.
_____________
For more information you can Ask a Question in the [TECHcommunity Forums](http://tech.forums.softwareag.com/techjforum/forums/list.page?product=webmethods).

You can find additional information in the [Software AG TECHcommunity](http://techcommunity.softwareag.com/home/-/product/name/webmethods).
_____________
Contact us at [TECHcommunity](mailto:technologycommunity@softwareag.com?subject=Github/SoftwareAG) if you have any questions.
