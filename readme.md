##Setup 

Virtual hosts
- Include etc/extra/httpd-vhosts.conf
```  
#Ejabberd api
Listen 7012
NameVirtualHost *:7012
<VirtualHost *:7012>
    ServerName local.beesightsoft.com
    DocumentRoot "<project dir>/server/public/"
    <Directory "<project dir>/server/public/">
        Options Indexes FollowSymLinks Includes execCGI
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
```
*Note: change DocumentRoot and Directory correlative

Edit php library: 
+ Check library pdo_dblib.so at dir: /Applications/XAMPP/xamppfiles/lib/php/extensions/no-debug-non-zts-20131226/
+ Add to php.ini (/Applications/XAMPP/xamppfiles/etc/php.ini)
```
extension=pdo_dblib.so
```

Edit file host for local running:
+ Add lines:
```
127.0.0.1 local.beesightsoft.com
```

Restart apache
