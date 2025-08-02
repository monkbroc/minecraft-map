FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    curl cron lighttpd openjdk-17-jre-headless \
    && apt-get clean

# Add uNmINeD CLI
RUN curl -L -o /tmp/unmined-cli.tgz "https://unmined.net/download/unmined-cli-linux-x64-dev/?tmstv=1749894977" && \
    mkdir -p /opt/unmined-cli && \
    tar -xzf /tmp/unmined-cli.tgz -C /opt/unmined-cli --strip-components=1 && \
    rm /tmp/unmined-cli.tgz

# Create render output directory
RUN mkdir -p /opt/www

# Add scripts and configs
COPY render.sh /opt/render.sh
COPY crontab /etc/cron.d/render-cron
COPY lighttpd.conf /etc/lighttpd/lighttpd.conf
COPY playernames.txt /opt/unmined-cli/config/playernames.txt

RUN chmod +x /opt/render.sh && \
    chmod 0644 /etc/cron.d/render-cron && \
    crontab /etc/cron.d/render-cron

# Run both cron and lighttpd
CMD bash -c "/opt/render.sh && service cron start && lighttpd -D -f /etc/lighttpd/lighttpd.conf"
