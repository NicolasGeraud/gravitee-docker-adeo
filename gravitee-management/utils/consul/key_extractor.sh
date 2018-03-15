cat /etc/confd/templates/gravitee.yml.tmpl.gw  |grep apim | cut -d'"' -f2 |sort -u | awk -F'"' '{print FS$0FS","}' > keys
