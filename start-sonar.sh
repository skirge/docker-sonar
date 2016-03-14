#!/bin/bash
set -e

if [ "${LDAP}" != "" ]; then
    echo "" >> /opt/app/sonarqube/conf/sonar.properties
    echo "sonar.security.realm=LDAP" >> /opt/app/sonarqube/conf/sonar.properties
    echo "sonar.security.savePassword=true" >> /opt/app/sonarqube/conf/sonar.properties
    echo "ldap.url=ldaps://${LDAP_URL}" >> /opt/app/sonarqube/conf/sonar.properties
    echo "ldap.bindDn=${LDAP_BIND_DN}" >> /opt/app/sonarqube/conf/sonar.properties
    echo "ldap.bindPassword=${LDAP_BIND_PASSWORD}" >> /opt/app/sonarqube/conf/sonar.properties
    echo "ldap.authentication=simple" >> /opt/app/sonarqube/conf/sonar.properties
    echo "ldap.user.baseDn=${USER_BASE_DN}" >> /opt/app/sonarqube/conf/sonar.properties
    echo "ldap.group.baseDn=${GROUP_BASE_DN}" >> /opt/app/sonarqube/conf/sonar.properties
fi

exec java -jar /opt/app/sonarqube/lib/sonar-application-$SONAR_VERSION.jar \
  -Dsonar.log.console=true \
  -Dsonar.jdbc.username="$SONARQUBE_JDBC_USERNAME" \
  -Dsonar.jdbc.password="$SONARQUBE_JDBC_PASSWORD" \
  -Dsonar.jdbc.url="$SONARQUBE_JDBC_URL" \
  "$@"

