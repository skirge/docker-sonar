FROM oberthur/docker-generic-app:openjdk-8u131b11_2

ENV SONAR_VERSION=5.6.6 \
    SONARQUBE_HOME=/opt/app/sonarqube \
    SONAR_LDAP_PLUGIN_VERSION=2.2.0.608 \
    SONAR_FINDBUGS_PLUGIN=3.4.4 \
    SONAR_JAVA_PLUGIN=4.9.0.9858 \
    SONAR_SVN_PLUGIN=1.5.0.715 \
    SONAR_XML_PLUGIN=1.4.3.1027 \
    SONAR_JS_PLUGIN=3.1.1.5128 \
    SONAR_LDAP_PLUGIN=2.2.0.608 \
    SONAR_WEB_PLUGIN=2.5.0.476 \
    SONAR_CSS_PLUGIN=4.8 \
    SONAR_SMELL_CODE_PLUGIN=4.0.0 \
    SONAR_JSON_PLUGIN=2.2 \
    SONAR_WIGET_LAB=1.8.1 \
    SONAR_CPP_PLUGIN=0.9.7 \
    SONAR_STASH_PLUGIN=1.1.1-ot \
    SONAR_BUILD_BREAKER=2.2 \
    SONAR_DEPENDENCY_CHECK=1.0.3 \
    SONAR_PDF_REPORT_PLUGIN=1.4

COPY start-sonar.sh /bin/

RUN apt-get update && apt-get install -y curl unzip \
#    && gpg --keyserver ha.pool.sks-keyservers.net --recv-keys F1182E81C792928921DBCAB4CFCA4A29D26468DE \
    && cd /opt/app \
    && curl -o sonarqube.zip -fSL https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-$SONAR_VERSION.zip \
    && curl -o sonarqube.zip.asc -fSL https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-$SONAR_VERSION.zip.asc \
#    && gpg --verify sonarqube.zip.asc \
    && unzip sonarqube.zip \
    && mv sonarqube-$SONAR_VERSION sonarqube \
    && rm sonarqube.zip* \
    && rm -rf $SONARQUBE_HOME/bin/* \
    && cd /opt/app/sonarqube/extensions/plugins/ \
    && curl -o sonar-ldap-plugin-$SONAR_LDAP_PLUGIN_VERSION.jar https://sonarsource.bintray.com/Distribution/sonar-ldap-plugin/sonar-ldap-plugin-$SONAR_LDAP_PLUGIN_VERSION.jar -L \
    && curl -o sonar-cxx-plugin-$SONAR_CPP_PLUGIN.jar https://github.com/SonarOpenCommunity/sonar-cxx/releases/download/cxx-$SONAR_CPP_PLUGIN/sonar-cxx-plugin-$SONAR_CPP_PLUGIN.jar -L \
    && curl -o sonar-findbugs-plugin-$SONAR_FINDBUGS_PLUGIN.jar https://github.com/SonarQubeCommunity/sonar-findbugs/releases/download/$SONAR_FINDBUGS_PLUGIN/sonar-findbugs-plugin-$SONAR_FINDBUGS_PLUGIN.jar -L \
    && curl -o sonar-java-plugin-$SONAR_JAVA_PLUGIN.jar https://sonarsource.bintray.com/Distribution/sonar-java-plugin/sonar-java-plugin-$SONAR_JAVA_PLUGIN.jar -L \
    && curl -o sonar-scm-svn-plugin-$SONAR_SVN_PLUGIN.jar https://sonarsource.bintray.com/Distribution/sonar-scm-svn-plugin/sonar-scm-svn-plugin-$SONAR_SVN_PLUGIN.jar -L \
    && curl -o sonar-xml-plugin-$SONAR_XML_PLUGIN.jar https://sonarsource.bintray.com/Distribution/sonar-xml-plugin/sonar-xml-plugin-$SONAR_XML_PLUGIN.jar -L \
    && curl -o sonar-javascript-plugin-$SONAR_JS_PLUGIN.jar https://sonarsource.bintray.com/Distribution/sonar-javascript-plugin/sonar-javascript-plugin-$SONAR_JS_PLUGIN.jar -L \
    && curl -o sonar-web-plugin-$SONAR_WEB_PLUGIN.jar https://sonarsource.bintray.com/Distribution/sonar-web-plugin/sonar-web-plugin-$SONAR_WEB_PLUGIN.jar -L \
    && curl -o sonar-widget-lab-plugin-$SONAR_WIGET_LAB.jar https://sonarsource.bintray.com/Distribution/sonar-widget-lab-plugin/sonar-widget-lab-plugin-$SONAR_WIGET_LAB.jar -L \
    && curl -o sonar-css-plugin-$SONAR_CSS_PLUGIN.jar https://github.com/racodond/sonar-css-plugin/releases/download/$SONAR_CSS_PLUGIN/sonar-css-plugin-$SONAR_CSS_PLUGIN.jar -L \
    && curl -o sonar-json-plugin-$SONAR_JSON_PLUGIN.jar https://github.com/racodond/sonar-json-plugin/releases/download/$SONAR_JSON_PLUGIN/sonar-json-plugin-$SONAR_JSON_PLUGIN.jar -L \
    && curl -o qualinsight-plugins-sonarqube-smell-plugin-$SONAR_SMELL_CODE_PLUGIN.jar https://github.com/QualInsight/qualinsight-plugins-sonarqube-smell/releases/download/qualinsight-plugins-sonarqube-smell-$SONAR_SMELL_CODE_PLUGIN/qualinsight-sonarqube-smell-plugin-$SONAR_SMELL_CODE_PLUGIN.jar -L \
    && curl -o sonar-stash-plugin-$SONAR_STASH_PLUGIN.jar https://github.com/oberthur/sonar-stash/releases/download/$SONAR_STASH_PLUGIN/sonar-stash-plugin-$SONAR_STASH_PLUGIN.jar -L \
    && curl -o sonar-build-breaker-$SONAR_BUILD_BREAKER.jar https://github.com/SonarQubeCommunity/sonar-build-breaker/releases/download/$SONAR_BUILD_BREAKER/sonar-build-breaker-plugin-$SONAR_BUILD_BREAKER.jar -L \
    && curl -o sonar-dependency-check-plugin-$SONAR_DEPENDENCY_CHECK.jar https://github.com/stevespringett/dependency-check-sonar-plugin/releases/download/sonar-dependency-check-$SONAR_DEPENDENCY_CHECK/sonar-dependency-check-plugin-$SONAR_DEPENDENCY_CHECK.jar -L \
    && curl -o sonar-pdfreport-plugin-$SONAR_PDF_REPORT_PLUGIN.jar http://downloads.sonarsource.com/plugins/org/codehaus/sonar-plugins/sonar-pdfreport-plugin/$SONAR_PDF_REPORT_PLUGIN/sonar-pdfreport-plugin-$SONAR_PDF_REPORT_PLUGIN.jar \
    && apt-get purge unzip \
    && chown -R app:app /opt/app \
    && apt-get clean autoclean \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/

USER app

VOLUME ["$SONARQUBE_HOME/data", "$SONARQUBE_HOME/extensions"]

EXPOSE 9000

ENTRYPOINT ["/bin/start-sonar.sh"]
