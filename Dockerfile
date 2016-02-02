FROM oberthur/docker-ubuntu-java:jdk8_8.71.15

ENV SONAR_VERSION=5.3 \
    SONARQUBE_HOME=/opt/sonarqube \
    SONAR_LDAP_PLUGIN_VERSION=1.5.1 \
    SONAR_FINDBUGS_PLUGIN=3.3 \
    SONAR_JAVA_PLUGIN=3.9 \
    SONAR_SVN_PLUGIN=1.2 \
    SONAR_XML_PLUGIN=1.3 \
    SONAR_JS_PLUGIN=2.10 \
    SONAR_LDAP_PLUGIN=1.5.1 \
    SONAR_WEB_PLUGIN=2.4 \
    SONAR_CSS_PLUGIN=1.6 \
    SONAR_SMELL_CODE_PLUGIN=3.0.0 \
    SONAR_JSON_PLUGIN=1.4 \
    SONAR_WIGET_LAB=1.8.1 \
    LANG=en_US.UTF-8

RUN locale-gen $LANG \
    && apt-get update && apt-get install -y unzip wget \
    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys F1182E81C792928921DBCAB4CFCA4A29D26468DE \
    && cd /opt \
    && curl -o sonarqube.zip -fSL https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-$SONAR_VERSION.zip \
    && curl -o sonarqube.zip.asc -fSL https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-$SONAR_VERSION.zip.asc \
    && gpg --verify sonarqube.zip.asc \
    && unzip sonarqube.zip \
    && mv sonarqube-$SONAR_VERSION sonarqube \
    && rm sonarqube.zip* \
    && rm -rf $SONARQUBE_HOME/bin/* \
    && cd /opt/sonarqube/extensions/plugins/ \
    && wget https://sonarsource.bintray.com/Distribution/sonar-ldap-plugin/sonar-ldap-plugin-$SONAR_LDAP_PLUGIN_VERSION.jar \
    && wget https://sonarsource.bintray.com/Distribution/sonar-findbugs-plugin/sonar-findbugs-plugin-$SONAR_FINDBUGS_PLUGIN.jar \
    && wget https://sonarsource.bintray.com/Distribution/sonar-java-plugin/sonar-java-plugin-$SONAR_JAVA_PLUGIN.jar \
    && wget https://sonarsource.bintray.com/Distribution/sonar-scm-svn-plugin/sonar-scm-svn-plugin-$SONAR_SVN_PLUGIN.jar \
    && wget https://sonarsource.bintray.com/Distribution/sonar-xml-plugin/sonar-xml-plugin-$SONAR_XML_PLUGIN.jar \
    && wget https://sonarsource.bintray.com/Distribution/sonar-javascript-plugin/sonar-javascript-plugin-$SONAR_JS_PLUGIN.jar \
    && wget https://sonarsource.bintray.com/Distribution/sonar-web-plugin/sonar-web-plugin-$SONAR_WEB_PLUGIN.jar \
    && wget https://sonarsource.bintray.com/Distribution/sonar-widget-lab-plugin/sonar-widget-lab-plugin-$SONAR_WIGET_LAB.jar \
    && wget https://github.com/SonarQubeCommunity/sonar-css/releases/download/$SONAR_CSS_PLUGIN/sonar-css-plugin.jar \
    && wget https://github.com/racodond/sonar-json-plugin/releases/download/$SONAR_JSON_PLUGIN/sonar-json-plugin-$SONAR_JSON_PLUGIN.jar \
    && wget https://github.com/QualInsight/qualinsight-plugins-sonarqube-smell/releases/download/qualinsight-plugins-sonarqube-smell-$SONAR_SMELL_CODE_PLUGIN/qualinsight-plugins-sonarqube-smell-plugin-$SONAR_SMELL_CODE_PLUGIN.jar \
    && apt-get purge unzip wget


EXPOSE 9000

WORKDIR $SONARQUBE_HOME
COPY start-sonar.sh $SONARQUBE_HOME/bin/
ENTRYPOINT ["./bin/start-sonar.sh"]
