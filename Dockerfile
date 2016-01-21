FROM oberthur/docker-ubuntu-java:jdk8_8.71.15


ENV SONAR_VERSION=5.3 \
    SONARQUBE_HOME=/opt/sonarqube \
    SONAR_LDAP_PLUGIN_VERSION=1.5.1 \
    SONAR_FINDBUGS_PLUGIN=3.3 \
    SONAR_JAVA_PLUGIN=3.9 \
    LANG=en_US.UTF-8

RUN locale-gen $LANG \
    && apt-get update && apt-get install -y unzip \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys F1182E81C792928921DBCAB4CFCA4A29D26468DE \
    && cd /opt \
    && curl -o sonarqube.zip -fSL https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-$SONAR_VERSION.zip \
    && curl -o sonarqube.zip.asc -fSL https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-$SONAR_VERSION.zip.asc \
    && gpg --verify sonarqube.zip.asc \
    && unzip sonarqube.zip \
    && mv sonarqube-$SONAR_VERSION sonarqube \
    && rm sonarqube.zip* \
    && rm -rf $SONARQUBE_HOME/bin/* \
    && curl -o /opt/sonarqube/extensions/plugins/sonar-ldap-plugin-$SONAR_LDAP_PLUGIN_VERSION.jar   https://sonarsource.bintray.com/Distribution/sonar-ldap-plugin/sonar-ldap-plugin-$SONAR_LDAP_PLUGIN_VERSION.jar \
    && curl -o /opt/sonarqube/extensions/plugins/sonar-findbugs-plugin-$SONAR_FINDBUGS_PLUGIN.jar https://sonarsource.bintray.com/Distribution/sonar-findbugs-plugin/sonar-findbugs-plugin-$SONAR_FINDBUGS_PLUGIN.jar \
    && curl -o /opt/sonarqube/extensions/plugins/sonar-java-plugin-$SONAR_JAVA_PLUGIN.jar     https://sonarsource.bintray.com/Distribution/sonar-java-plugin/sonar-java-plugin-$SONAR_JAVA_PLUGIN.jar \
    && apt-get purge unzip


EXPOSE 9000

WORKDIR $SONARQUBE_HOME
COPY start-sonar.sh $SONARQUBE_HOME/bin/
ENTRYPOINT ["./bin/start-sonar.sh"]
