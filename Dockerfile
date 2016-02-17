FROM jbonachera/consul-template
MAINTAINER Julien BONACHERA <julien@bonachera.fr>
RUN curl -sLo /etc/yum.repos.d/rspamd.repo http://rspamd.com/rpm-stable/fedora-22/rspamd.repo
RUN rpm --import https://rspamd.com/rpm-stable/gpg.key
RUN dnf install -y rmilter libopendkim
EXPOSE 11332
RUN mkdir /etc/dkim
COPY fake_syslog.ini /etc/fake_syslog.ini
COPY fake_syslog.py /usr/local/bin/fake_syslog.py
COPY rmilter.conf.* /etc/rmilter/
