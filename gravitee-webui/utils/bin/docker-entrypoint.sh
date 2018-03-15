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
        
	mv /var/www/html/constants.json /var/www/html/constants.json.ori	
	
	if [ ! -z $ENVIRONMENT ]
	then
       		/opt/confd/bin/confd -onetime -backend $CONFIG_MODE -node $BACKEND_NODE -prefix="$ENVIRONMENT" -log-level="debug" 
	else
       		/opt/confd/bin/confd -onetime -backend $CONFIG_MODE -node $BACKEND_NODE -log-level="debug" 
	fi
        
       rm -f /var/www/html/constants.json.ori
fi
echo "GRAVITEEIO WEB UI IS ON FIRE !!!!!"
echo "CALL ME DADDY !!"
exec "$@"
