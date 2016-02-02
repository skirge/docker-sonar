#!/bin/bash
set -e

if [ "${LDAP}" != "" ]; then
    echo "" >> /opt/sonarqube/conf/sonar.properties
    echo "sonar.security.realm=LDAP" >> /opt/sonarqube/conf/sonar.properties
    echo "sonar.security.savePassword=true" >> /opt/sonarqube/conf/sonar.properties
    echo "ldap.url=ldap://${LDAP_URL}" >> /opt/sonarqube/conf/sonar.properties
    echo "ldap.user.baseDn=${USER_BASE_DN}" >> /opt/sonarqube/conf/sonar.properties
    echo "ldap.user.realNameAttribute=${REAL_NAME_ATTRIBUTE}" >> /opt/sonarqube/conf/sonar.properties
    echo "ldap.user.emailAttribute=${USER_MAIL_ATTRIBUTE}" >> /opt/sonarqube/conf/sonar.properties
    echo "ldap.group.baseDn=${GROUP_BASE_DN}" >> /opt/sonarqube/conf/sonar.properties
    echo "ldap.group.idAttribute=${ID_ATTRIBUTE}}" >> /opt/sonarqube/conf/sonar.properties
fi

exec java -jar lib/sonar-application-$SONAR_VERSION.jar \
  -Dsonar.log.console=true \
  -Dsonar.jdbc.username="$SONARQUBE_JDBC_USERNAME" \
  -Dsonar.jdbc.password="$SONARQUBE_JDBC_PASSWORD" \
  -Dsonar.jdbc.url="$SONARQUBE_JDBC_URL" \
  "$@"
