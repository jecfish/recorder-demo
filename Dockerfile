FROM ghcr.io/puppeteer/puppeteer:latest
COPY --chown=pptruser:pptruser package*.json ./
RUN npm ci --omit=dev
COPY --chown=pptruser:pptruser . .
ENTRYPOINT ["npm", "start"]
