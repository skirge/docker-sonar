#!/bin/bash
set -e

if [ "${LDAP}" != "" ]; then
    echo "" >> /opt/app/sonarqube/conf/sonar.properties
    echo "sonar.security.realm=LDAP" >> /opt/app/sonarqube/conf/sonar.properties
    echo "sonar.security.savePassword=true" >> /opt/app/sonarqube/conf/sonar.properties
    echo "ldap.url=${LDAP_URL}" >> /opt/app/sonarqube/conf/sonar.properties
    echo "ldap.bindDn=${LDAP_BIND_DN}" >> /opt/app/sonarqube/conf/sonar.properties
    echo "ldap.bindPassword=${LDAP_BIND_PASSWORD}" >> /opt/app/sonarqube/conf/sonar.properties
    echo "ldap.authentication=simple" >> /opt/app/sonarqube/conf/sonar.properties
    echo "ldap.user.baseDn=${USER_BASE_DN}" >> /opt/app/sonarqube/conf/sonar.properties
    echo "ldap.group.baseDn=${GROUP_BASE_DN}" >> /opt/app/sonarqube/conf/sonar.properties
fi

echo "sonar.log.console=${SONARQUBE_LOG_CONSOLE}" >> /opt/app/sonarqube/conf/sonar.properties
echo "sonar.jdbc.username=${SONARQUBE_JDBC_USERNAME}" >> /opt/app/sonarqube/conf/sonar.properties
echo "sonar.jdbc.password=${SONARQUBE_JDBC_PASSWORD}" >> /opt/app/sonarqube/conf/sonar.properties
echo "sonar.jdbc.url=${SONARQUBE_JDBC_URL}" >> /opt/app/sonarqube/conf/sonar.properties

exec java -server -Xms${JVM_MINIMUM_MEMORY:=384m} -Xmx${JVM_MAXIMUM_MEMORY:=768m} ${JAVA_OPTS} -jar /opt/app/sonarqube/lib/sonar-application-$SONAR_VERSION.jar
