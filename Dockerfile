FROM node:14.15.0 as builder

WORKDIR /opt/java_web_base
COPY . .

RUN npm config set unsafe-perm true
# npm install -g cnpm --registry=https://registry.npmmirror.com
RUN npm install -g cnpm --registry=https://registry.npmmirror.com
# RUN npm i node-sass --sass_binary_site=https://npm.taobao.org/mirrors/node-sass/
# RUN npm install -g cnpm --registry=https://registry.npm.taobao.org && cnpm install
RUN rm -rf node_modules
RUN cnpm install
# RUN npm install
RUN cnpm run build

FROM nginx:1.18.0

COPY --from=builder /opt/java_web_base/dist /opt/web
COPY docker/nginx.conf /etc/nginx/nginx.conf
# COPY docker/entrypoint.sh /entrypoint.sh

#暴露容器8001端口
EXPOSE 8001
# nginx -g "daemon off;"
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]
