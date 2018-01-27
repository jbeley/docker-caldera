#!/bin/bash

set -e -u
sleep 2
if [ -f /firstboot.tmp ] ;
then
	crudini --set /etc/mongodb.conf '' replSet caldera
	supervisorctl restart mongod
        rm /firstboot.tmp

fi
