#!/bin/bash
echo "0"
# 容器名称
CONTAINER="jenkins_demo"
# 镜像名称（以日期时间为镜像标签，防止重复）
IMAGE=$CONTAINER":"$(date -d "today" +"%Y%m%d_%H%M%S")
# 删除滚动更新残留的容
docker rm `docker ps -a | grep -w $CONTAINER"_"$CONTAINER | awk '{print $1}'`
# 强制删除滚动更新残留的镜像
docker rmi --force `docker images | grep -w $IMAGE | awk '{print $3}'`
# 切换至项目路径
cd src
# 创建新镜像
docker build -t $IMAGE -f $1\Dockerfile . && \
# 构建完镜像切换至解决方案路径
cd ..
# 删除 docker-compose.jenkins.yml 文件，防止使用相同镜像
rm -rf docker-compose.jenkins.yml && \

# 复制 docker-compose.src.yml 文件，防止污染原文件
cp docker-compose.src.yml docker-compose.jenkins.yml && \

# 替换镜像名标志位为最新镜像
sed -i s%IMAGE_LATEST%$IMAGE%g docker-compose.jenkins.yml && \

# 使用 docker stack 启动服务
docker stack deploy -c docker-compose.jenkins.yml $CONTAINER
