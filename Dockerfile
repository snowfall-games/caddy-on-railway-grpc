FROM caddy:builder AS builder
RUN xcaddy build --with github.com/mholt/caddy-l4

FROM caddy:alpine
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
COPY ./caddy.json /etc/caddy/caddy.json
CMD ["/bin/sh", "-c", "mkdir -p /config/certs && printf '%s' \"$CF_ORIGIN_CERT\" > /config/certs/cf-origin.crt && printf '%s' \"$CF_ORIGIN_KEY\" > /config/certs/cf-origin.key && chmod 600 /config/certs/cf-origin.key && caddy run --config /etc/caddy/caddy.json"]
