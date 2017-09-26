FROM nginx:1.13.5-alpine

WORKDIR /tmp/nginx


COPY nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]
