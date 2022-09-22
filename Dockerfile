FROM ghcr.io/puppeteer/puppeteer:18.0.5
COPY package*.json ./
RUN npm ci --omit=dev
COPY . .
ENTRYPOINT ["npm", "run", "replay-one"]
# ENTRYPOINT ["npm", "run", "replay"]
# ENTRYPOINT ["npm", "start"]