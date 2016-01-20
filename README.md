# docker-sonar

Docker image to run SonarQube Server

You need add this env:

- **SONARQUBE_JDBC_USERNAME**: db username 
- **SONARQUBE_JDBC_PASSWORD**: db password
- **SONARQUBE_JDBC_URL**: db jdbc url 

Usage:
```
docker run -d -p 9000:9000 --name sonar -e SONARQUBE_JDBC_USERNAME=sonar -e SONARQUBE_JDBC_PASSWORD=sonar -e SONARQUBE_JDBC_URL="jdbc:mysql://127.0.0.1:3306/sonar?useUnicode=true&amp;characterEncoding=utf8&amp;rewriteBatchedStatements=true" oberthur/sonar
```

