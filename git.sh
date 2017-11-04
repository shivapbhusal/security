#! /bin/bash 
cp /var/www/CSRF/Attacker/index.html Sourcecode_CSRF/
cp /var/www/CSRF/Attacker/task2.html Sourcecode_CSRF/

git add .
git commit -m $1

