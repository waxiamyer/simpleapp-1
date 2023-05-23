FROM centos
MAINTAINER Sander <wasia.maya@gmail.com>

# Add repo file
ADD ./sander.repo /etc/yum.repos.d/

# Install cool software
RUN yum --assumeyes update && \
    yum --assumeyes install \
    nmap iproute && \
    bash && \
    yum clean all

ENTRYPOINT ["/usr/bin/nmap"]
CMD ["-sn", "172.17.0.0/24"]

# Set security context
securityContext:
  allowPrivilegeEscalation: false
  capabilities:
    drop: ["ALL"]
  runAsNonRoot: true
  seccompProfile:
    type: "RuntimeDefault"  # or "Localhost"
