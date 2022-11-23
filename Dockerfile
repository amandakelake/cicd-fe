# 多阶段构建
FROM node:16-alpine as builder

# 设置为工作目录，以下 RUN/CMD 命令都是在工作目录中进行执行
WORKDIR /code

# 提前将依赖移动至目录，利用docker缓存，只要ADD的内容不变，缓存就不会被破坏
ADD package.json yarn.lock ./
RUN yarn

# 全部代码添加到镜像中
COPY . ./
RUN yarn build

# 利用更小的nginx镜像
FROM nginx:alpine
COPY --from=builder /code/dist/ /usr/share/nginx/html/
# nginx 暴露 80端口
EXPOSE 80
# 启动nginx
CMD ["nginx", "-g", "daemon off;"]
