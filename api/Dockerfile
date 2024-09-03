# build
FROM node:18-alpine AS build

WORKDIR /app

COPY package*.json ./
RUN npm ci --only=production

COPY app.js ./

# run
FROM node:18-alpine

WORKDIR /app

COPY --from=build /app ./

EXPOSE 3000

CMD ["node", "app.js"]