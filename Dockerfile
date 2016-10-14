FROM jbonachera/arch
ENTRYPOINT /sbin/entrypoint.sh
MAINTAINER Julien BONACHERA <julien@bonachera.fr>
ENV rmilter_VERSION="1.9.2"
RUN pacman --noconfirm -S openssl libevent glib2 gmime luajit make cmake sqlite hiredis git gcc ragel base-devel libmilter opendkim && \
    useradd -r _rmilter && \
    mkdir /var/lib/rmilter && \
    chown _rmilter: /var/lib/rmilter && \
    git clone --branch $rmilter_VERSION --depth 1 --recursive https://github.com/vstakhov/rmilter.git /usr/local/src/rmilter && \
    cd /usr/local/src/ && \
    mkdir rmilter.build && \
    cd rmilter.build && \
    cmake -DNO_SHARED=ON -DCMAKE_INSTALL_PREFIX=/usr \
          -DCONFDIR=/etc/rmilter -DRUNDIR=/run/rmilter \
          -DLOGDIR=/var/log/rmilter -Drmilter_USER='_rmilter' \
          -DDBDIR=/var/lib/rmilter -DWANT_SYSTEMD_UNITS=OFF \
          ../rmilter && \
    make && \
    make install && \
    cd ~ && \
    rm -rf /usr/local/src/rmilter && \
    pacman -R --noconfirm cmake  gcc git libmilter

RUN mkdir /var/run/rmilter && chown _rmilter: /var/run/rmilter
EXPOSE 11332
RUN mkdir /etc/dkim
COPY rmilter.conf.* /etc/rmilter/
COPY entrypoint.sh /sbin/entrypoint.sh
