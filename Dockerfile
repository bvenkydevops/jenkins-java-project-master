

FROM tomcat:9
MAINTAINER venkatesh bojja
COPY target/*.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
