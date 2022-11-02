FROM openjdk:8-jre
COPY target /usr/app/
COPY application.properties /usr/app
WORKDIR /usr/app
ENTRYPOINT ["java", "-jar", "/usr/app/embedash-1.1-SNAPSHOT.jar","--spring.config.location=./application.properties"]
