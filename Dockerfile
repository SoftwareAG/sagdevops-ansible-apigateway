ARG BASE_ANSIBLE_IMAGE

FROM $BASE_ANSIBLE_IMAGE

LABEL org.opencontainers.image.authors="fabien.sanglier@softwareaggov.com" \
      org.opencontainers.image.vendor="Softwareag Government Solutions" \
      org.opencontainers.image.version="10.11"

# sag ansible roles base url
ARG SAG_ANSIBLE_ROLES_URL=https://github.com/SoftwareAG

####### getting the common-utils role by tag
ARG SAG_ANSIBLE_ROLES_COMMON_UTILS=sagdevops-ansible-common
ARG SAG_ANSIBLE_ROLES_COMMON_UTILS_RELEASE=1.0.0-2
ARG SAG_ANSIBLE_ROLES_COMMON_UTILS_FILENAME="${SAG_ANSIBLE_ROLES_COMMON_UTILS}-${SAG_ANSIBLE_ROLES_COMMON_UTILS_RELEASE}"

# fetch and extract the role SAG_ANSIBLE_ROLES_COMMON_UTILS
RUN set -x \
    && echo "==> Download a specific TAG release of ${SAG_ANSIBLE_ROLES_COMMON_UTILS}" \
    && curl -L "${SAG_ANSIBLE_ROLES_URL}/${SAG_ANSIBLE_ROLES_COMMON_UTILS}/archive/refs/tags/${SAG_ANSIBLE_ROLES_COMMON_UTILS_RELEASE}.tar.gz" -o "/tmp/${SAG_ANSIBLE_ROLES_COMMON_UTILS_FILENAME}.tar.gz"  \
    && tar xvf /tmp/${SAG_ANSIBLE_ROLES_COMMON_UTILS_FILENAME}.tar.gz -C ${ANSIBLE_ROLES_BASEPATH}

####### adding directly the apigateway ansible roles in this project
ARG SAG_ANSIBLE_ROLES_APIGATEWAY=sagdevops-ansible-apigateway
ARG SAG_ANSIBLE_ROLES_APIGATEWAY_RELEASE=latest
ARG SAG_ANSIBLE_ROLES_APIGATEWAY_FILENAME="${SAG_ANSIBLE_ROLES_APIGATEWAY}-${SAG_ANSIBLE_ROLES_APIGATEWAY_RELEASE}"

COPY ./roles/ ${ANSIBLE_ROLES_BASEPATH}/${SAG_ANSIBLE_ROLES_APIGATEWAY_FILENAME}/roles/

# ansible-specific config env vars
# ":" separated paths in which Ansible will search for Roles.
ENV ANSIBLE_ROLES_PATH="${ANSIBLE_ROLES_PATH}:${ANSIBLE_ROLES_BASEPATH}/${SAG_ANSIBLE_ROLES_COMMON_UTILS_FILENAME}/roles:${ANSIBLE_ROLES_BASEPATH}/${SAG_ANSIBLE_ROLES_APIGATEWAY_FILENAME}/roles"

# install ansible community playbooks
RUN ansible-galaxy collection install community.general