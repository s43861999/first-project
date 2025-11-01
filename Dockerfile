FROM  tomcat:9.0.111-jdk8-corretto
LABEL maintainer="Shashank"
COPY  devopsnew.war /usr/local/tomcat/webapps/
EXPOSE 8090
