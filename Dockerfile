FROM ubuntu:20.04 AS build
ENV DEBIAN_FRONTEND=noninteractive
#Install Java 17 and Maven
RUN apt-get update && apt-get install -y openjdk-17-jdk maven git

#Clone the repository
RUN git clone https://github.com/bvenkydevops/jenkins-java-project-master.git

#Set the working directory to the webapp folder
WORKDIR /jenkins-java-project-master/
RUN mvn clean package

#Build the project using Maven RUN mvn clean package
###################### Final stage ############################# #Use a new image for deployment with Tomcat
FROM tomcat:9.0.76-jdk17

#Copy the WAR file from the build stage to Tomcat's webapps directory
COPY --from=build /jenkins-java-project-master/target/*.war /usr/local/tomcat/webapps/

#Expose port 8080
 EXPOSE 8080

#Start Tomcat
CMD ["catalina.sh", "run"]

