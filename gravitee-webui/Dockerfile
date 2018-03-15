#FROM nginx:1.10.2-alpine
FROM  registry.adeo.com/public-images/nginx:1.12.1-alpine

#confd 
RUN mkdir -p /opt/confd/bin
ADD confd/bin/* /opt/confd/bin
RUN chmod +x /opt/confd/bin/confd
RUN mkdir -p /etc/confd/{conf.d,templates}
ADD confd/gravitee-webui/*.toml /etc/confd/conf.d/
ADD confd/gravitee-webui/*.tmpl /etc/confd/templates/

#Bin
RUN mkdir -p /var/www/html
COPY ./zip/graviteeio-management-ui-1.13.2.tar  /var/www/html 
RUN cd /var/www/html && tar -xvf graviteeio-management-ui-1.13.2.tar && rm graviteeio-management-ui-1.13.2.tar

#NGINX
COPY ./nginx/nginx-ui.conf /etc/nginx/conf.d/default.conf

#Consul|etcd
ADD utils/bin/docker-entrypoint.sh . 
RUN chmod u+x docker-entrypoint.sh

EXPOSE 80 443
ENTRYPOINT ["./docker-entrypoint.sh"]

#FIRE
CMD ["nginx","-g","daemon off;"]
