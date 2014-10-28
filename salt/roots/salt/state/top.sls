vagrant:
  'servertype:vagrantbox':
     - match: grain
     - mysql
     - php
     - php.fpm
     - php.curl
     - php.json
     - nginx
     - afterscripts.symlink_nginx