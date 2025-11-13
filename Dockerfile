# Dockerfile
FROM node:18-alpine

WORKDIR /usr/src/app

# Install dependencies
COPY app/package.json ./
RUN npm install --only=production

# Copy application code
COPY app/server.js ./

EXPOSE 8080

CMD ["npm", "start"]
