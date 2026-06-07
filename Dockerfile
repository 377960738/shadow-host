FROM debian:bookworm

# 安装基础工具
RUN apt-get update && apt-get install -y --no-install-recommends \
	tini \
	docker.io \
	docker-compose \
	git \
	curl \
	wget \
	vim \
	openssh-server \
	ca-certificates \
	&& rm -rf /var/lib/apt/lists/*

# 暴露端口
EXPOSE 22

# 复制 entrypoint 脚本
COPY entrypoint.sh /entrypoint.sh

# 设置为入口点
ENTRYPOINT ["/usr/bin/tini", "--", "bash", "/entrypoint.sh"]
