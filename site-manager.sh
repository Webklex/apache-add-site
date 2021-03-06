#!/bin/sh

###############################################################
## UBUNTU SITE MANAGER - create locals domains on the fly    ##
## Author:... M.Goldenbaum | Webklex                         ##
## Url:...... http://webklex.com                             ##
## License:.. MIT                                            ##
## Version:.. 1.0.0 alpha                                    ##
##                                                           ##
## Description: This script is designed to setup any local   ##
## development website witch one easy command.               ##
## It creates if it doesn't exists an apache2 site config    ##
## file, does the required hosts entry, adds the site to     ##
## the apache configuration (a2ensite) and reloads the       ##
## whole configuration. So you can get started within        ##
## seconds.                                                  ##
##                                                           ##
## Example for creating the local domain example.dev:        ##
## site-manager -d dev -n example -p /var/www/dev/example -l ##
##                                                           ##
## Getting Help:                                             ##
## There are actually multiple ways to get help if you are   ##
## stuck or have any questions. You can either visit the     ##
## official Github site:                                     ##
## https://github.com/Webklex/apache-add-site or contact me  ##
## by sending an email to: info@webklex.com                  ##
###############################################################

VERSION="1.0.0 alpha"

DOMAIN="dev"
SITE_NAME="example"

SITE_PATH="/var/www/dev/$SITE_NAME/public"

APACHE_SITE_PATH="/etc/apache2/sites-available"
HOSTS_FILE="/etc/hosts"
LOCAL_IP="127.0.0.1"

LOCKED=true

while getopts lvhn:d:p:a:f:o: option
do
    case $option in
        d) DOMAIN="$OPTARG" ;;
        n)
            SITE_NAME="$OPTARG"
            LOCKED=false
            ;;
        p) SITE_PATH="$OPTARG" ;;
        a) APACHE_SITE_PATH="$OPTARG" ;;
        f) HOSTS_FILE="$OPTARG" ;;
        o) LOCAL_IP="$OPTARG" ;;
        l)
            LOCKED=false
            echo "Lock removed";
            ;;
        v)
            echo "
Thank you are using \"Site Manager\"
Your are running version $VERSION
            ";
            exit 0
            ;;
        h)
        echo "
#############################################
############ UBUNTU SITE MANAGER ############
#############################################
This product is designed to create new development pages on your
local machine. Its really easy to use, so have fun and give it a try ;)

-h
    Display the help page. Actually your seeing it right now.
-d
    Set the domain which should be used.
    Default: dev
-n
    Set the new domain name. E.g. example if you which to create a domain like example.dev
    Default: example
-p
    Set the domain root folder.
    Default: /var/www/dev/[YOUR CHOSEN DOMAIN NAME]/public
-a
    Set the apache site configuration path
    Default: /etc/apache2/sites-available
-f
    Set the hosts file location
    Default: /etc/hosts
-o
    Set the localhost ip
    Default: 127.0.0.1
-l
    Sometimes you need to disable the lock - if so use -l to force what ever you want
    Usage: -l

Example usage:
site-manager -d dev -n example -p /var/www/dev/example -l
    "
        exit 0
        ;;
        *|\?)
        shift
        ;;
    esac
done


echo "
##########################
Setting up a new Domain with the following parameters
Use -h to find out more about the available options

DOMAIN:............ $DOMAIN
SITE_NAME:......... $SITE_NAME
SITE_PATH:......... $SITE_PATH
APACHE_SITE_PATH:.. $APACHE_SITE_PATH
HOSTS_FILE:........ $HOSTS_FILE
LOCAL_IP:.......... $LOCAL_IP

###########################
"

if [ $LOCKED = true ] ; then
    echo "You need to use the -l option in order to proceed"
    exit
fi

#Create required folders
[ -d "$SITE_PATH" ] || mkdir -p "$SITE_PATH"

APACHE_SITE_CONFIG_FILE_NAME="$APACHE_SITE_PATH/$SITE_NAME.$DOMAIN.conf"
APACHE_SITE_CONFIG_FILE_CONTENT="
<VirtualHost *:80>
        ServerName $SITE_NAME.$DOMAIN

        ServerAdmin webmaster@localhost
        DocumentRoot $SITE_PATH
        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
"

#Put it all together
if [ -f "$APACHE_SITE_CONFIG_FILE_NAME" ]; then
    echo "
    Configuration file already exists. Please move it or choose an other domain name
    "
    exit
else
    sudo sh -c "echo '$APACHE_SITE_CONFIG_FILE_CONTENT' > '$APACHE_SITE_CONFIG_FILE_NAME'"
fi

HOST_FILE_CONTENT="$LOCAL_IP    $SITE_NAME.$DOMAIN"

if ! grep -q "$HOST_FILE_CONTENT" "$HOSTS_FILE" ; then
    sudo sh -c "echo '$HOST_FILE_CONTENT' >> '$HOSTS_FILE'"
fi

#Restarting apache2 in order to reload the configuration
sudo sh -c "a2ensite $SITE_NAME.$DOMAIN.conf"
echo "Executing: service apache2 reload"
sudo sh -c "service apache2 reload"

echo "
$SITE_NAME.$DOMAIN has ben setup!

"