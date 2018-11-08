FROM nuxeo/nuxeo-dev-apb-jenkins-slave-maven
USER root

ADD freedesktop.org.xml /tmp/

# Reinstall ImageMagick with the RSVG delegate
RUN mv /usr/share/mime/packages/freedesktop.org.xml /usr/share/mime/packages/freedesktop.org.xml-backup && \
      mv /tmp/freedesktop.org.xml /usr/share/mime/packages/ && \
      update-mime-database /usr/share/mime && \
      yum -y erase ImageMagick && \
      yum -y install librsvg2 && \
      yum -y install ImageMagick

USER 1000
