FROM nuxeo/nuxeo-dev-apb-jenkins-slave-maven
USER root

ADD freedesktop.org.xml /tmp/

# Reinstall ImageMagick with the RSVG delegate
RUN mv /usr/share/mime/packages/freedesktop.org.xml /usr/share/mime/packages/freedesktop.org.xml-backup && \
      mv /tmp/freedesktop.org.xml /usr/share/mime/packages/ && \
      update-mime-database /usr/share/mime && \
      yum -y erase ImageMagick && \
      yum -y install librsvg2-devel ImageMagick-devel && \
      wget https://github.com/ImageMagick/ImageMagick/archive/7.0.8-14.tar.gz && \
      tar xvzpf 7.0.8-14.tar.gz && \
      cd ImageMagick-7.0.8-14 && \
      ./configure --with-rsvg=yes && make && make install && \
      cd .. && rm -rf ImageMagick-7.0.8-14

USER 1000
