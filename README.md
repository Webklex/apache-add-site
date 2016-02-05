# UBUNTU SITE MANAGER 

```
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
    
    
Example usage:
sudo siteManager -d dev -n example -p /var/www/dev/example -l true
```
