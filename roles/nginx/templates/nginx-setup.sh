#!/bin/sh

cd /tmp &&
tar -zvxf nginx-{{nginx_version}}.tar.gz &&
cd nginx-{{nginx_version}} &&
./configure \
{% for key, value in nginx_source_modules_include.items() %}
{{value}} \
{% endfor %}
{% for item in nginx_source_modules_exclude %}
--without-{{ item }} \
{% endfor %}
--prefix={{nginx_source_install_prefix}}/nginx-{{nginx_version}} --conf-path=/etc/nginx/nginx.conf
make && sudo make install
