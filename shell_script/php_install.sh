#!/bin/bash
ENVIRONMENTS='dev|qa|prod'
VERSIONS=''
PPA='ondrej/php'
usage() { 
    printf "Usage: %s: -e ($ENVIRONMENTS) (-v php_version]\n"  
}
deps() {
    retval="php$1 php$1-fpm php$1-mysql php$1-cli php$1-curl libapache2-mod-php$1"
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
    apt update -y
    apt install software-properties-common -y
    add-apt-repository ppa:/ondrej/php -y
    add-apt-repository ppa:/ondrej/nginx -y
    apt remove software-properties-common -y
    apt update -y
    apt upgrade -y
fi


# If its a fresh install
if ! command -v php &> /dev/null 
then
    echo 'No previous version of PHP found, building from start';
    deps $version
    apt install $retval -y
    exit 0
fi

# If the versions are different
cur_ver=$(php -v | grep ^PHP | cut -d' ' -f2 | cut -c1-3)
if [[ $cur_ver != $version ]]; then
    echo "Removing current version ( $cur_ver ) of PHP"
    deps $cur_ver
    apt remove $retval -y

    echo "Installing version $version of PHP"
    deps $version
    apt install $retval -y
else
    echo "PHP $version already installed"
fi

