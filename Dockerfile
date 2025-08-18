FROM caddy:alpine
COPY ./Caddyfile /etc/caddy/Caddyfile
CMD ["/bin/sh", "-c", "mkdir -p /config/certs && printf '%s' \"$CF_ORIGIN_CERT\" > /config/certs/cf-origin.crt && printf '%s' \"$CF_ORIGIN_KEY\" > /config/certs/cf-origin.key && chmod 600 /config/certs/cf-origin.key && caddy run --config /etc/caddy/Caddyfile"]
