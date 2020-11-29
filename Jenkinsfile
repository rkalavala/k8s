pipeline {
   agent any
   tools {
     jdk 'jdk1.8'
     maven 'maven3'
   }
   stages {
     stage('pull repo'){
    	steps {
          git 'https://gitlab.com/jagarlamudirajesh34/k8s-repo.git'
        }
     }
     stage('build artifactry'){
        steps {
          sh 'mvn clean'
          sh 'mvn install'
        }
     }
     stage('Deploy Artifacts') { 
        steps {
          script {			 
            def server = Artifactory.server 'myjfrog' 
            def uploadSpec = """{
              "files": [
                   {
                     "pattern": "/var/lib/jenkins/.m2/repository/com/srish/mvn-hello-world/1.1/mvn-hello-world-1.1.war",
                     "target": "k8s/"
                   }
               ]
             }"""
	         server.upload(uploadSpec)
	       }
	    }
	  }
	  stage('docker build image'){
    	steps {
    	  echo 'docker..'
          sh 'docker --version'
          sh 'docker build -t mytom:1 .'
        }
      }
      stage('Push to ECR'){
    	steps {
    	  echo 'push to ECR'
          sh '$(aws ecr get-login --no-include-email)'
          sh 'docker tag mytom:1 971098455874.dkr.ecr.ap-south-1.amazonaws.com/mytom:1'
          sh 'docker push 971098455874.dkr.ecr.ap-south-1.amazonaws.com/mytom:1'
        }
     }
     stage('kubectl check'){
    	steps {
    	  sh 'kubectl get nodes'
        }
     }
      stage('Apply Deployment'){
    	steps {
    	  sh 'kubectl apply -f mytomdp.yaml'
        }
     }
     stage('Apply service'){
    	steps {
    	  sh 'kubectl apply -f mytomsv.yaml'
        }
     }
     
     
	  
   }
}
