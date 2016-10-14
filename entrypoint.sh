#!/bin/bash
trap 'exit' INT
render.py /etc/rmilter/rmilter.conf.common.jinja > /etc/rmilter/rmilter.conf.common
exec  su - _rmilter -c '/usr/sbin/rmilter -n -c /etc/rmilter/rmilter.conf.docker'
