FROM lscr.io/linuxserver/rdesktop:arch-openbox

# set version label
ARG BUILD_DATE
ARG VERSION
ARG DIGIKAM_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="hackerman"

# title
ENV TITLE=DigiKam

RUN \
  echo "**** install runtime packages ****" && \
  pacman -Syu --noconfirm --needed \
    xorg-xauth \
    breeze-icons \
    hugin \
    qt6-imageformats \
    digikam \
    firefox \
    mariadb \
    perl-image-exiftool && \
  echo "**** image tweaks ****" && \
  ln -s \
    /usr/bin/vendor_perl/exiftool \
    /usr/bin/exiftool && \
  dbus-uuidgen > /etc/machine-id && \
  echo "**** cleanup ****" && \
  rm -rf \
    /tmp/* \
    /var/cache/pacman/pkg/* \
    /var/lib/pacman/sync/*

# add local files
COPY /root /

# ports and volumes
EXPOSE 3389
