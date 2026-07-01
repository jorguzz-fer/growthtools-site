# Static site served by Nginx — deployable on Coolify via the Dockerfile build pack.
FROM nginx:1.27-alpine

# Custom server config (serves v1.html at the root).
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Site content.
COPY v1.html /usr/share/nginx/html/v1.html

EXPOSE 80

# Simple container healthcheck used by Coolify to confirm the site is up.
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
    CMD wget -qO- http://127.0.0.1/ >/dev/null 2>&1 || exit 1
