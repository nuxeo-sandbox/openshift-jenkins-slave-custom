FROM dockerpriv.nuxeo.com:443/nuxeo/jenkins-slave


ENV HOME=/home/jenkins
USER root

# Copy the entrypoint
ADD contrib/bin/* /usr/local/bin/
ADD settings.xml $HOME/.m2/

ENV JAVA_OPTS=-Djdk.net.URLClassPath.disableClassPathURLCheck=true \
    KUBECONFIG=/var/lib/origin/openshift.local.config/master/admin.kubeconfig

RUN add-apt-repository ppa:webupd8team/java -y && \
    apt-get update && \
    echo "oracle-java8-installer  shared/accepted-oracle-license-v1-1 boolean true" > /tmp/oracle-license-debconf  && \
    /usr/bin/debconf-set-selections /tmp/oracle-license-debconf  && \
    rm /tmp/oracle-license-debconf  && \
    DEBIAN_FRONTEND="noninteractive" apt-get -q -y install oracle-java8-installer oracle-java8-set-default && \
    wget -qO- https://github.com/openshift/origin/releases/download/v3.11.0/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz  | tar xvz && \
    cp openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit/oc /usr/bin && \
    cp openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit/kubectl /usr/bin && \
    chmod +x /usr/bin/oc && \
    chmod +x /usr/bin/kubectl && \
    mkdir -p $HOME/.m2/repository && \
    chown -R 1001:0 /home/jenkins && \
    chmod -R g+w /home/jenkins && \
    chmod 664 /etc/passwd

# Run the Jenkins JNLP client
ENTRYPOINT ["/usr/local/bin/run-jnlp-client"]


