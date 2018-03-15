FROM registry.adeo.com/java/jre8

#confd 
RUN mkdir -p /opt/confd/bin
ADD confd/bin/* /opt/confd/bin
RUN chmod +x /opt/confd/bin/confd
RUN mkdir -p /etc/confd/{conf.d,templates}
ADD confd/mongos/*.toml /etc/confd/conf.d/
ADD confd/mongos/*.tmpl /etc/confd/templates/

#MONGOS
RUN rpm -ivh http://10.9.60.33/pulp/repos/ADEO/Library/custom/adeo_third_party_centos6/third_party_centos6/ADEO_mongodb-community-mongos-3.4.4-0.x86_64.rpm
# Fix mongos installation
RUN ln -s /home1/mongodb/bin/mongos /usr/bin/mongos
RUN chown -R mongod:mongod /home2/mongodb && chmod 770 /home2/mongodb
#Remove Mongo Default conf
RUN rm -rf /home2/mongodb/*

#Consul|etcd
ADD utils/bin/docker-entrypoint.sh .
RUN chmod +x docker-entrypoint.sh

USER mongod 

#FIRE
EXPOSE 27017 
ENTRYPOINT ["./docker-entrypoint.sh"]
CMD /home1/mongodb/bin/mongos --config /home2/mongodb/mongos.conf
