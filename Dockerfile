#Dockerfile for lamp server (apache2,php 7.3,mysql)

#install ubuntu version 20.04 
FROM ubuntu:20.04

#install apache2,run in FOREGROUND and expose port
RUN apt-get update 
RUN apt-get install –y apache2 
RUN apt-get install –y apache2-utils 
RUN apt-get clean 
EXPOSE 80 CMD [“apache2ctl”, “-D”, “FOREGROUND”]

RUN apt-get update && apt-get install -yq --no-install-recommends \
    apt-utils \
    curl \
    # Install git
    git \
    # Install apache
    # Install php 7.2
    libapache2-mod-php7.2 \
    php7.2-cli \
    php7.2-json \
    php7.2-curl \
    php7.2-fpm \
    php7.2-gd \
    php7.2-ldap \
    php7.2-mbstring \
    php7.2-mysql \
    php7.2-soap \
    php7.2-sqlite3 \
    php7.2-xml \
    php7.2-zip \
    php7.2-intl \
    php-imagick \
    # Install tools
    openssl \
    nano \
    sudp \
    graphicsmagick \
    imagemagick \
    ghostscript \
    mysql-client \
    iputils-ping \
    locales \
    sqlite3 \
    ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
    
    #install openssh server for connect it using putty
    
    RUN apt-get update && apt-get install -y openssh-server
    RUN mkdir /var/run/sshd
    RUN echo 'root:jacksparrow' | chpasswd
    RUN sed -i 's/#*PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

    # SSH login fix. Otherwise user is kicked off after login
    RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd

    ENV NOTVISIBLE="in users profile"
    RUN echo "export VISIBLE=now" >> /etc/profile
    
    EXPOSE 22
    CMD ["/usr/sbin/sshd", "-D"]
    
    # attach volumne to docker
    VOLUME E:jacksparrow/:/var/www/html
