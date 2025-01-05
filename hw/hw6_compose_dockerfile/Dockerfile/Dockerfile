FROM nginx:alpine

RUN mkdir -p /Users/sergeizh/Docker_playground/l2/nginx/volume

VOLUME ["/Users/sergeizh/Docker_playground/volume"]

COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80
