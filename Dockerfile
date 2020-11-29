FROM tomcat:8.0

MAINTAINER rajesh

COPY /target/mvn-hello-world.war /usr/local/tomcat/webapps/

EXPOSE 8080

USER root

WORKDIR /usr/local/tomcat/webapps

CMD ["catalina.sh", "run"]