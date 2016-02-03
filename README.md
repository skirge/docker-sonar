# docker-sonar

Docker image to run SonarQube Server

You need add this env:

- **SONARQUBE_JDBC_USERNAME**: db username
- **SONARQUBE_JDBC_PASSWORD**: db password
- **SONARQUBE_JDBC_URL**: db jdbc url
- **LDAP**: true if you want to use ldap
- **LDAP_URL**: ldap url
- **USER_BASE_DN**: user base dn
- **REAL_NAME_ATTRIBUTE**: user name attribute
- **USER_MAIL_ATTRIBUTE**: user mail attirbute
- **GROUP_BASE_DN**: group base dn
- **ID_ATTRIBUTE**: group id attribute

Usage:
```
docker run -d -p 9000:9000 --name sonar -e SONARQUBE_JDBC_USERNAME=sonar -e SONARQUBE_JDBC_PASSWORD=sonar -e SONARQUBE_JDBC_URL="jdbc:mysql://127.0.0.1:3306/sonar?useUnicode=true&amp;characterEncoding=utf8&amp;rewriteBatchedStatements=true" oberthur/docker-sonar
```
with Ldap:
```
docker run -d -p 9000:9000 --name sonar -e SONARQUBE_JDBC_USERNAME=sonar -e SONARQUBE_JDBC_PASSWORD=sonar -e SONARQUBE_JDBC_URL="jdbc:mysql://127.0.0.1:3306/sonar?useUnicode=true&amp;characterEncoding=utf8&amp;rewriteBatchedStatements=true"  -e LDAP="TRUE" -e LDAP_URL="127.0.0.1:389" -e USER_BASE_DN="ou=Users,dc=world" -e REAL_NAME_ATTRIBUTE="cn" -e USER_MAIL_ATTRIBUTE="mail" -e GROUP_BASE_DN="ou=Groups,dc=world" -e ID_ATTRIBUTE="cn" oberthur/docker-sonar
```
