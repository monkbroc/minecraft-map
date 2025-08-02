FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    curl cron lighttpd openjdk-17-jre-headless \
    && apt-get clean

# Add uNmINeD CLI
RUN curl -L -o /tmp/unmined-cli.tgz "https://unmined.net/download/unmined-cli-linux-x64-dev/?tmstv=1749894977" && \
    mkdir -p /opt/unmined-cli && \
    tar -xzf /tmp/unmined-cli.tgz -C /opt/unmined-cli --strip-components=1 && \
    rm /tmp/unmined-cli.tgz

RUN mkdir -p /opt/www

COPY render.sh /opt/render.sh
COPY crontab /etc/cron.d/render-cron
RUN chmod +x /opt/render.sh && \
    chmod 0644 /etc/cron.d/render-cron && \
    crontab /etc/cron.d/render-cron

# Configure lighttpd to serve /opt/www
RUN mkdir -p /var/run/lighttpd && \
    echo 'server.document-root = "/opt/www"\nserver.port = 5000\nserver.dir-listing = "enable"' > /etc/lighttpd/lighttpd.conf

# Run both cron and lighttpd
CMD bash -c "service cron start && lighttpd -D -f /etc/lighttpd/lighttpd.conf"
