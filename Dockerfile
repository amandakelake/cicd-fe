FROM nginx:1.15-alpine
COPY dist /etc/nginx/html
WORKDIR /etc/nginx/html
