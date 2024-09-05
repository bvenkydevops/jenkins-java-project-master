# jenkins-java-project-master
#scientist is BOJJA VENKATESH .
--------------------------------------------------------------------------
NORMAL DOCKERFILE OR Single stage Dockerfile
-----------------------------------------------------------------------------
#single stage Dockerfile
FROM ubuntu AS build
RUN apt-get update && apt-get install -y openjdk-17-jdk && apt-get install -y maven git wget
RUN git clone https://github.com/bvenkydevops/
WORKDIR 
RUN mvn clean package
#Install Tomcat
RUN wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.76/bin/apache-tomcat-9.0.76.tar.gz &&
tar -xzf apache-tomcat-9.0.76.tar.gz &&
mv apache-tomcat-9.0.76 /usr/local/tomcat
RUN cp target/*.war /usr/local/tomcat/webapps/               \
EXPOSE 8080
CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]

----------------------------------------------------------------------------------------
