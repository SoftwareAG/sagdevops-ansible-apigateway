ARG BASE_ANSIBLE_IMAGE

FROM $BASE_ANSIBLE_IMAGE
 
LABEL org.opencontainers.image.title="Softwareag webMethods API Gateway Configurator" \
      org.opencontainers.image.description="The webMethods API Gateway Configurator allows you to configure the APIGateway product using environment variables."

# add the ansible scripts
COPY ./ansible/ ${ANSIBLE_PLAYBOOKS_BASEPATH}/

# add the demo artifacts
COPY ./demo_artifacts/ ${ANSIBLE_PLAYBOOKS_BASEPATH}/demo_artifacts/