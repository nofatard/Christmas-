# Pull base image 
From tomcat:8-jre8 

# Maintainer 
MAINTAINER "Abdou" 
COPY webapp/target/christ.war /usr/local/tomcat/webapps
