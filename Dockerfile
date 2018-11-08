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

#Add repositories need it for ffmpeg2theora and ffmpeg
ARG NUX_GPG_KEY_URL=http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro
ARG NUX_DEXTOP_RPM_URL=http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-1.el7.nux.noarch.rpm
RUN yum -y install epel-release \
    && rpm --import ${NUX_GPG_KEY_URL} \
    && rpm -Uvh ${NUX_DEXTOP_RPM_URL} \
    && yum -y install ffmpeg ffmpeg2theora perl-Image-ExifTool ufraw


USER 1000
