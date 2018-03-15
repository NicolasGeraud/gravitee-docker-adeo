#!/bin/sh

echo CONFIG_MODE : $CONFIG_MODE
echo BACK_END_NODE : $BACKEND_NODE
echo PREFIX : $ENVIRONMENT

if [ ! -z $CONFIG_MODE ] && [ ! -z $BACKEND_NODE ] 
then
        case $CONFIG_MODE in
        	consul|etcd);; 
		*) exit ;;
	esac
	
	echo move gravitee.yml to gravitee.yml.ori
	mv ./config/gravitee.yml ./config/gravitee.yml.ori	
	
	if [ ! -z $ENVIRONMENT ]
	then
       		/opt/confd/bin/confd -onetime -backend $CONFIG_MODE -node $BACKEND_NODE -prefix="$ENVIRONMENT" -log-level="debug" 
	else
       		/opt/confd/bin/confd -onetime -backend $CONFIG_MODE -node $BACKEND_NODE -log-level="debug" 
	fi

fi
echo "GRAVITEEIO API MANAGEMENT  IS ON FIRE !!!!!"
echo "CALL ME DADDY !!"
exec "$@"

