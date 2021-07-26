#!/bin/bash
ENVIRONMENTS='dev|qa|prod'
VERSIONS=''
PPA='ondrej/php'

usage() { 
    printf "Usage: %s: -e ($ENVIRONMENTS) (-v php_version]\n"  
}

# Grab flags
while getopts e:v:h flag 
do
  case $flag in
    e) environment="${OPTARG}" ;;
    v) version="${OPTARG}" ;;
    h) usage
       exit 1 ;;
  esac
done
if ! [[ $version ]]; then usage; exit 1; fi
if ! [[ $environment =~ ^($ENVIRONMENTS)$ ]]; then 
    usage; exit 1; 
else # Set the env in profile
    sed -i '/APP_ENV=.*/d' $HOME/.profile
    sed -i "$ a APP_ENV=$environment" $HOME/.profile
    source $HOME/.profile
fi

# PPA Dependencies
if ! grep -q -s "^deb .*$PPA.*" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
    echo 'PPA Not found, adding it now'
    #echo 'deb http://ppa.launchpad.net/ondrej/php/ubuntu focal main' > /etc/apt/sources.list.d/ondrej-ubuntu-php-focal.list
    #apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C    
    apt update -y
    apt install software-properties-common -y
    add-apt-repository ppa:/ondrej/php -y
    add-apt-repository ppa:/ondrej/nginx-mainline
    apt remove software-properties-common -y
fi

# If its a fresh install
if ! command -v php &> /dev/null 
then
    echo 'No previous version of PHP found, building from start';
    apt install php$version php$version-fpm php$version-mysql libapache2-mod-php$version php$version-cli -y
    service php$version-fpm start
    exit 0
fi

# If the versions are different
cur_ver=$(php -v | grep ^PHP | cut -d' ' -f2 | cut -c1-3)
if [[ $cur_ver != $version ]]; then
    echo "Removing current version ( $cur_ver ) of PHP"
    service php$cur_ver-fpm stop
    apt remove php$cur_ver php$cur_ver-fpm php$cur_ver-mysql libapache2-mod-php$cur_ver php$cur_ver-cli -y

    echo "Installing version $version of PHP"
    apt install php$version php$version-fpm php$version-mysql libapache2-mod-php$version php$version-cli -y
    service php$version-fpm start
else
    echo "PHP $version already installed"
fi
