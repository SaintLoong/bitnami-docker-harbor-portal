#!/bin/bash

# Load libraries
. /libfs.sh
. /libnginx.sh

export HARBOR_PORTAL_BASEDIR="/opt/bitnami/harbor"
export HARBOR_PORTAL_NGINX_CONFDIR="${HARBOR_PORTAL_BASEDIR}/nginx-conf"
export HARBOR_PORTAL_NGINX_CONFFILE="${HARBOR_PORTAL_NGINX_CONFDIR}/nginx.conf"

# Load Nginx environment variables
eval "$(nginx_env)"

# Ensure NGINX temp folders exists
for dir in  "${NGINX_BASEDIR}/client_body_temp" "${NGINX_BASEDIR}/proxy_temp" "${NGINX_BASEDIR}/fastcgi_temp" "${NGINX_BASEDIR}/scgi_temp" "${NGINX_BASEDIR}/uwsgi_temp"; do
    ensure_dir_exists "$dir"
done

# Loading bitnami paths
sed -i "s|/usr/share/nginx/html|${HARBOR_PORTAL_BASEDIR}|g" "$HARBOR_PORTAL_NGINX_CONFFILE"
sed -i "s|/etc/nginx/mime.types|${NGINX_CONFDIR}/mime.types|g" "$HARBOR_PORTAL_NGINX_CONFFILE"

cp -a "${HARBOR_PORTAL_NGINX_CONFDIR}/." "$NGINX_CONFDIR"
chmod -R g+rwX "$NGINX_CONFDIR"
