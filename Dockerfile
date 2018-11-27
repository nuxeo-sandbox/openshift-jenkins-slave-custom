FROM docker-registry.default.svc:5000/ps-common/nuxeo-jenkins-slave


ENV HOME=/home/jenkins
USER root

RUN mkdir -p /home/jenkins && \
    chown -R 1001:0 /home/jenkins && \
    chmod -R g+w /home/jenkins && \
    chmod 664 /etc/passwd

# Copy the entrypoint
ADD contrib/bin/* /usr/local/bin/
ADD settings.xml $HOME/.m2/
# Run the Jenkins JNLP client
ENTRYPOINT ["/usr/local/bin/run-jnlp-client"]


