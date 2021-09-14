FROM tomcat:8.0

ENV CONTEXT_ROOT="ci-demo"
ARG WAR=project-1.0-RAMA.war

ADD project/target/$WAR /usr/local/tomcat/webapps
RUN mv /usr/local/tomcat/webapps/${WAR} /usr/local/tomcat/webapps/${CONTEXT_ROOT}.war

EXPOSE 8080/tcp
