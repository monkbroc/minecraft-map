# Minecraft Map Render

Simple Docker app that renders a Minecraft map to a webpage using
[uNmINeD](https://unmined.net/) and hosts it as a web page on port 5000.
Meant to be deployed with [Dokku](https://dokku.com/).

# Deploy

```
dokku apps:create minecraft-map
dokku storage:mount minecraft-map /usr/local/minecraft/world:/mnt/world
dokku domains:add minecraft-map minecraft.<yourdomain>.com
dokku letsencrypt:enable minecraft-map
```
