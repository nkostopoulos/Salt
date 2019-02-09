# Upgrade the system via apt-get -y upgrade
#pkg.upgrade:
#  module.run

# Install packages required for the installation of php version 7.2
install required packages:
  pkg.installed:
    - pkgs:
      - ca-certificates
      - apt-transport-https
    - refresh: True

# Add the PHP 7.2 repository
base:
  pkgrepo.managed:
    - name: deb https://packages.sury.org/php/ stretch main
    - file: /etc/apt/sources.list.d/php.list
    - gpgcheck: 1
    - key_url: https://packages.sury.org/php/apt.gpg

# Add key using a shell command
#php-repo-key:
#  cmd.run:
#    - name: wget -O- https://packages.sury.org/php/apt.gpg | apt-key add -
#    - unless: apt-key list | grep 'Elasticsearch (Elasticsearch Signing Key)'

# Install PHP 7.2
install php 7.2:
  pkg.installed:
    - pkgs:
      - php7.2
      - php7.2-cli
      - php7.2-common
      - php7.2-opcache
      - php7.2-curl
      - php7.2-mbstring
      - php7.2-mysql
      - php7.2-zip
      - php7.2-xml
