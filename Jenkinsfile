pipeline{
    agent any
stages{
  stage('CheckOutCode'){
    steps{
   checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/TejaBadugu/jenkins-java-project-master.git']])
	
	}
  }

  stage('Build'){
    steps{
       sh  "mvn clean package"
         }
   }
	
   stage('sonarQube'){
    steps{
       sh  "mvn clean sonar:sonar"
         }
   }
 stage('nexus'){
    steps{
       sh  "mvn clean deploy"
         }
   }
   stage('deployTomcat'){
    steps{
deploy adapters: [tomcat9(credentialsId: 'tomcat', path: '', url: 'http://44.208.22.127:8080/')], contextPath: 'qenv', war: '**/*.war'
    }
   }
}

}
