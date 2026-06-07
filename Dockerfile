FROM alpine:latest

# 安装基础工具
RUN apk add --no-cache \
	tini \
	docker.io \
	docker-cli-compose \
	git \
	curl \
	wget \
	vim \
	openssh-server \
	ca-certificates \
	&& rm -rf /var/cache/apk/*

# 暴露端口
EXPOSE 22

# 复制 entrypoint 脚本
COPY entrypoint.sh /entrypoint.sh

# 设置为入口点
ENTRYPOINT ["/usr/bin/tini", "--", "bash", "/entrypoint.sh"]
