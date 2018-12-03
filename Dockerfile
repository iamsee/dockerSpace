# FROM 系统镜像，这段代码是基础必须要的
FROM iamsee/webserver
# 编辑人，作者信息
MAINTAINER iamsee
VOLUME /appVolume
RUN nginx
RUN supervisord -c /etc/supervisord.conf
EXPOSE 80
EXPOSE 3000
EXPOSE 3001