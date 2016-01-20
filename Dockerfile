FROM oberthur/docker-ubuntu-java

ENV SONAR_VERSION 5.3
ENV SONARQUBE_HOME /opt/sonarqube
ENV SONAR_LDAP_PLUGIN_VERSION 1.5.1
ENV SONAR_FINDBUGS_PLUGIN 3.3
ENV SONAR_JAVA_PLUGIN 3.9

# Install the python script required for "add-apt-repository"
RUN apt-get update && apt-get install -y software-properties-common unzip wget

# Sets language to UTF8
ENV LANG en_US.UTF-8
RUN locale-gen $LANG 

RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys F1182E81C792928921DBCAB4CFCA4A29D26468DE

RUN set -x \
    && cd /opt \
    && curl -o sonarqube.zip -fSL https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-$SONAR_VERSION.zip \
    && curl -o sonarqube.zip.asc -fSL https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-$SONAR_VERSION.zip.asc \
    && gpg --verify sonarqube.zip.asc \
    && unzip sonarqube.zip \
    && mv sonarqube-$SONAR_VERSION sonarqube \
    && rm sonarqube.zip* \
    && rm -rf $SONARQUBE_HOME/bin/*

RUN wget -O /opt/sonarqube/extensions/plugins/sonar-ldap-plugin-$SONAR_LDAP_PLUGIN_VERSION.jar   https://sonarsource.bintray.com/Distribution/sonar-ldap-plugin/sonar-ldap-plugin-$SONAR_LDAP_PLUGIN_VERSION.jar
RUN wget -O /opt/sonarqube/extensions/plugins/sonar-findbugs-plugin-$SONAR_FINDBUGS_PLUGIN.jar https://sonarsource.bintray.com/Distribution/sonar-findbugs-plugin/sonar-findbugs-plugin-$SONAR_FINDBUGS_PLUGIN.jar
RUN wget -O /opt/sonarqube/extensions/plugins/sonar-java-plugin-$SONAR_JAVA_PLUGIN.jar     https://sonarsource.bintray.com/Distribution/sonar-java-plugin/sonar-java-plugin-$SONAR_JAVA_PLUGIN.jar

EXPOSE 9000

WORKDIR $SONARQUBE_HOME
COPY run.sh $SONARQUBE_HOME/bin/
ENTRYPOINT ["./bin/run.sh"]
