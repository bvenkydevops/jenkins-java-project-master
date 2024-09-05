# jenkins-java-project-master
#scientist is BOJJA VENKATESH .
--------------------------------------------------------------------------
NORMAL DOCKERFILE OR Single stage Dockerfile
-----------------------------------------------------------------------------
#single stage Dockerfile
FROM ubuntu AS build              \
RUN apt-get update && apt-get install -y openjdk-17-jdk && apt-get install -y maven git wget       \
RUN git clone https://github.com/bvenkydevops/jenkins-java-project-master.git   \
WORKDIR  /jenkins-java-project-master/           \
RUN mvn clean package              \
#Install Tomcat
RUN wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.76/bin/apache-tomcat-9.0.76.tar.gz &&
tar -xzf apache-tomcat-9.0.76.tar.gz &&
mv apache-tomcat-9.0.76 /usr/local/tomcat
RUN cp target/myweb-8.3.2-SNAPSHOT.war /usr/local/tomcat/webapps/myweb-8.3.2-SNAPSHOT.war               \
EXPOSE 8080         \
CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]

----------------------------------------------------------------------------------------
Multistage Docker file ,In this 2 stages are there 1 .Build stage 2.Final stage
################## Build stage ################################################# #Use Ubuntu as the base image for building the app  \
FROM ubuntu:20.04 AS build           \
ENV DEBIAN_FRONTEND=noninteractive    \
#Install Java 17 and Maven               \
RUN apt-get update &&
apt-get install -y openjdk-17-jdk maven git \

#Clone the repository
RUN git clone https://github.com/bvenkydevops/jenkins-java-project-master.git \

#Set the working directory to the webapp folder      \
WORKDIR  /jenkins-java-project-master/    \

#Build the project using Maven
RUN mvn clean package             \
###################### Final stage #############################
#Use a new image for deployment with Tomcat
FROM tomcat:9.0.76-jdk17 \

#Copy the WAR file from the build stage to Tomcat's webapps directory
COPY --from=build /target/myweb-8.3.2-SNAPSHOT.war /usr/local/tomcat/webapps/myweb-8.3.2-SNAPSHOT.war  \

#Expose port 8080
EXPOSE 8080          

#Start Tomcat  \
CMD ["catalina.sh", "run"]
