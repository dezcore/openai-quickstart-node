# syntax=docker/dockerfile:1
FROM node:lts-alpine as base
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

FROM base as dev
EXPOSE 3000
CMD ["npm", "run", "dev"]

#production stage
FROM nginx:stable-alpine as production-stage
COPY --from=prod /app/dist /usr/share/nginx/html
EXPOSE 300
CMD ["nginx", "-g", "daemon off;"]