FROM docker-registry.default.svc:5000/ps-common/nuxeo-jenkins-slave

# Copy the entrypoint
ADD contrib/bin/* /usr/local/bin/

# Run the Jenkins JNLP client
ENTRYPOINT ["/usr/local/bin/run-jnlp-client"]


