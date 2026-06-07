#!/bin/bash
set -e

# 准备 vscode-server 目录
if [ -d /data ] && [ ! -d /data/.vscode-server ]; then
  mkdir -p /data/.vscode-server /data/.vscode-remote-containers /data/.vscode-print-resource-cache

  ln -s /data/.vscode-server /root/.vscode-server
  ln -s /data/.vscode-remote-containers /root/.vscode-remote-containers
  ln -s /data/.vscode-print-resource-cache /root/.vscode-print-resource-cache
fi

# 配置 SSH 服务
if [ ! -d /run/sshd ]; then
  mkdir -p /run/sshd

  sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
  sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
  sed -i 's/^AllowTcpForwarding.*/AllowTcpForwarding yes/' /etc/ssh/sshd_config
  sed -i 's/^GatewayPorts.*/GatewayPorts yes/' /etc/ssh/sshd_config
fi

# 启动 SSH 服务
/usr/sbin/sshd -D

exec "$@"
