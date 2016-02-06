# UBUNTU/Apache2 SITE MANAGER
## create locals domains on the fly

```
Author: M.Goldenbaum | Webklex 
Website: http://webklex.com 
License: MIT
Version: 1.0.0 alpha

Description: This script is designed to setup any local 
development website witch one easy command. 
It creates if it doesn't exists an apache2 site config
file, does the required hosts entry, adds the site to 
the apache configuration (a2ensite) and reloads the 
whole configuration. So you can get started within
seconds.

Example for creating the local domain example.dev:
site-manager -d dev -n example -p /var/www/dev/example -l 

Getting Help: 
There are actually multiple ways to get help if you are 
stuck or have any questions. You can either visit the 
official Github site: https://github.com/Webklex/apache-add-site or contact me
by sending an email to: info@webklex.com

Available options:

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
```

## Installation & Setup
```
sudo cp site-manager.sh /usr/local/bin/site-manager

or

sudo ln -s site-manager.sh /usr/local/bin/site-manager
```