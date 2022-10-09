FROM ghcr.io/puppeteer/puppeteer:latest
COPY --chown=pptruser:pptruser package*.json ./

# Remove these 2 lines if this PR merged: https://github.com/puppeteer/puppeteer/pull/9085
USER root
RUN mkdir /home/.npm && chown -R pptruser:pptruser "/home/.npm"

USER pptruser
RUN npm ci --omit=dev
COPY --chown=pptruser:pptruser . .
ENTRYPOINT ["npm", "start"]
