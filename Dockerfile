FROM ghcr.io/puppeteer/puppeteer:latest
COPY package*.json ./

USER pptruser
RUN npm ci --omit=dev
COPY --chown=pptruser:pptruser . .

ENTRYPOINT ["npm", "start"]
