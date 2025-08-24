FROM golang:1.25-alpine AS builder
RUN apk add --no-cache git ca-certificates
RUN go install github.com/caddyserver/xcaddy/cmd/xcaddy@latest
RUN xcaddy build --with github.com/mholt/caddy-l4 --output /usr/bin/caddy

FROM caddy:2.10.0
RUN apk add --no-cache gettext
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
COPY ./caddy.json /etc/caddy/caddy.json.template
CMD ["/bin/sh", "-c", "mkdir -p /config/certs && printf '%s' \"$CF_ORIGIN_CERT\" > /config/certs/cf-origin.crt && printf '%s' \"$CF_ORIGIN_KEY\" > /config/certs/cf-origin.key && chmod 600 /config/certs/cf-origin.key && envsubst < /etc/caddy/caddy.json.template > /etc/caddy/caddy.json && caddy run --config /etc/caddy/caddy.json"]
