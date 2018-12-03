echo -e "\n\n\n\n--------- 准备安装依赖包 ---------\n\n\n\n" \
&& yum  install epel-release -y \
&& yum update -y \
&& yum install  libpng libpng-devel libjpeg-turbo libjpeg-turbo-devel freetype freetype-devel gd  gcc-c++ libxml2-devel openssl-devel libcurl-devel libmcrypt libmcrypt-devel mcrypt mhash make perl python-pip zip cmake git bison-devel bison vim  java unzip  net-tools ncurses-devel supervisor -y  \
&& mkdir -p /iamseeData/sourceSpace  \
&& mkdir -p /iamseeData/serverSpace \
&& mkdir -p /iamseeData/serverSpace \
&& mkdir -p /iamseeData/jenkinsWrokSpace \
&& mkdir -p /iamseeData/supervisorConf \
&& mkdir -p /iamseeData/webSpace \
&& \cp -rf /appVolume/app/conf/info.php /iamseeData/webSpace \
&& mkdir -p /iamseeData/configSpace \
&& mkdir -p /iamseeData/sourceSpace/nginx \
&& tar -zxvf  /appVolume/app/nginx-1.13.3.tar.gz -C  /iamseeData/sourceSpace/nginx --strip-components 1 \
&& mkdir -p /iamseeData/sourceSpace/pcre \
&& tar -zxvf /appVolume/app/pcre-8.41.tar.gz -C /iamseeData/sourceSpace/pcre --strip-components 1 \
&& mkdir -p /iamseeData/sourceSpace/openssl \
&& tar -zxvf /appVolume/app/openssl-1.0.2j.tar.gz -C /iamseeData/sourceSpace/openssl --strip-components 1 \
&& mkdir -p /iamseeData/sourceSpace/zlib \
&& tar -zxvf /appVolume/app/zlib-1.2.11.tar.gz -C /iamseeData/sourceSpace/zlib --strip-components 1 \
&& mkdir -p /iamseeData/sourceSpace/php56 \
&& tar -zxvf /appVolume/app/php-5.6.38.tar.gz -C /iamseeData/sourceSpace/php56 --strip-components 1 \
&& mkdir -p /iamseeData/sourceSpace/redis \
&& tar -zxvf /appVolume/app/redis-5.0.2.tar.gz -C /iamseeData/sourceSpace/redis --strip-components 1 \
&& mkdir -p /iamseeData/sourceSpace/mariadb \
&& tar -zxvf /appVolume/app/mariadb-10.3.11.tar.gz -C /iamseeData/sourceSpace/mariadb --strip-components 1 \
&& cd /iamseeData/sourceSpace/php56 \
&& ./configure --prefix=/iamseeData/sourceSpace/php56/  --enable-mbstring --with-curl --with-pear --with-gd --with-config-file-path=/iamseeData/sourceSpace/php56/etc/ --enable-fpm --with-mysqli --with-pdo-mysql  --with-zlib --enable-xml  --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization --with-curl --enable-mbregex --enable-mbstring --with-mcrypt --enable-ftp  --with-mhash --enable-pcntl --enable-sockets --with-xmlrpc --enable-zip  --with-gettext  --enable-maintainer-zts      --with-zlib    --enable-soap --with-gd --enable-gd-native-ttf --with-zlib  --with-openssl \
&& make -j4 && make install \
&& cd /iamseeData/sourceSpace/pcre \
&& ./configure && make \
&& cd /iamseeData/sourceSpace/zlib \
&& ./configure && make \
&& cd /iamseeData/sourceSpace/openssl \
&& ./config && make -j4 \
&& mkdir -p /iamseeData/sourceSpace/nginx \
&& tar -zxvf /appVolume/app/nginx-1.13.3.tar.gz -C /iamseeData/sourceSpace/nginx --strip-components 1 \
&& echo -e "\n\n\n\n--------- 准备编译nginx ---------\n\n\n\n" \
&& cd /iamseeData/sourceSpace/nginx \
&& ./configure \
--prefix=/iamseeData/serverSpace/nginx \
--conf-path=/appVolume/var/nginx/conf/nginx.conf \
--http-log-path=/appVolume/var/nginx/logs \
--error-log-path=/appVolume/var/nginx/logs \
--pid-path=/appVolume/var/nginx/nginx.pid \
--with-pcre=../pcre --with-zlib=../zlib \
--with-openssl=../openssl \
--with-stream \
--with-mail=dynamic \
&& make -j4 && make install \
&& mkdir -p /iamseeData/serverSpace/jenkins \
&& \cp -rf /appVolume/app/jenkins.war /iamseeData/serverSpace/jenkins \
&& cd /iamseeData/serverSpace \
&& unzip -o /appVolume/app/gogs.zip  \
&& mkdir -p /iamseeData/serverSpace/redis \
&& cd /iamseeData/sourceSpace/redis \
&& \cp -rf /appVolume/app/conf/redis.conf /iamseeData/serverSpace/redis \
&& make PREFIX=/iamseeData/serverSpace/redis install \
&& cd /iamseeData/sourceSpace/mariadb \
&& mkdir -p /appVolume/var/mariadb/etc && mkdir -p /appVolume/var/mariadb/data \
&& echo -e "\n\n\n\n--------- 准备编译mysql ---------\n\n\n\n" \
&& mkdir -p /iamseeData/serverSpace/mariadb \
&& cmake \
-DCMAKE_INSTALL_PREFIX=/iamseeData/serverSpace/mariadb -DMYSQL_DATADIR=/appVolume/var/mariadb/data \
-DSYSCONFDIR=/appVolume/var/mariadb/etc \
-DWITHOUT_TOKUDB=1 \
-DWITH_INNOBASE_STORAGE_ENGINE=1 \
-DWITH_ARCHIVE_STPRAGE_ENGINE=1 \
-DWITH_BLACKHOLE_STORAGE_ENGINE=1 \
-DWIYH_READLINE=1 \
-DWIYH_SSL=system \
-DVITH_ZLIB=system \
-DWITH_LOBWRAP=0 \
-DMYSQL_UNIX_ADDR=/tmp/mysql.sock \
-DDEFAULT_CHARSET=utf8 \
-DDEFAULT_COLLATION=utf8_general_ci \
&& make -j4 && make install \
&& cd /iamseeData/serverSpace/mariadb \
&& ./scripts/mysql_install_db --datadir=/appVolume/var/mariadb/data --user=root \
&& \cp -rf /appVolume/app/conf/mysql.server support-files/mysql.server \
&& \cp -rf support-files/mysql.server /etc/init.d/mysqld \
&& echo "export PATH=/iamseeData/serverSpace/mariadb/bin:$PATH" >> ~/.bashrc \
&& echo "export PATH=/iamseeData/serverSpace/nginx/sbin:$PATH" >> ~/.bashrc \
&& source ~/.bashrc \
&& \cp -rf /appVolume/app/conf/supervisord.conf /etc/ \
&& supervisord -c /etc/supervisord.conf \
&& mkdir -p /appVolume/var/logs/supervisor \
&& groupadd git && useradd git -d /iamseeData/gitData -g git \
&& chown -R git:git /iamseeData/gitData/ \
&& \cp -rf /appVolume/app/conf/supervisorConf/* /iamseeData/supervisorConf/ \
&& echo -e "\n\n\n\n--------- 准备启动监听 ---------\n\n\n\n" \
&& supervisorctl update && supervisorctl start all \
&& nginx 