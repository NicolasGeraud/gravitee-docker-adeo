FROM registry.adeo.com/java/jre8

#confd 
RUN mkdir -p /opt/confd/bin
ADD confd/bin/* /opt/confd/bin
RUN chmod +x /opt/confd/bin/confd
RUN mkdir -p /etc/confd/{conf.d,templates}
ADD confd/gravitee-management/*.toml /etc/confd/conf.d/
ADD confd/gravitee-management/*.tmpl /etc/confd/templates/

RUN adduser -U --system gravitee 
RUN chown gravitee:gravitee /etc/confd/* -R  

ENV GRAVITEEIO_COMPONENT graviteeio-management-api
ENV GRAVITEEIO_VERSION 1.13.2
ENV GRAVITEEIO_HOME /opt/${GRAVITEEIO_COMPONENT}-${GRAVITEEIO_VERSION}

###### BINARY #######
COPY ./zip/${GRAVITEEIO_COMPONENT}-${GRAVITEEIO_VERSION}.tar /opt
RUN cd /opt/ && tar -xvf ${GRAVITEEIO_COMPONENT}-${GRAVITEEIO_VERSION}.tar && rm -f *.tar
COPY ./custom-plugins/ ${GRAVITEEIO_HOME}/plugins
RUN chown gravitee:gravitee -R ${GRAVITEEIO_HOME}
RUN ln -s ${GRAVITEEIO_HOME} /opt/gravitee-management && chown gravitee:gravitee /opt/gravitee-management
###### BINARY #######

WORKDIR ${GRAVITEEIO_HOME}

#Consul|etcd
ADD utils/bin/docker-entrypoint.sh ${GRAVITEE_HOME}
RUN chmod +x docker-entrypoint.sh

USER gravitee

#FIRE
EXPOSE 8082
ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["./bin/gravitee"]
