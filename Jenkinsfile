
pipeline {
    agent {
        docker {
            image 'gomoto/node-docker-compose' 
            args '-u root -v /var/run/docker.sock:/var/run/docker.sock' 
        }
    }
  environment {
    ENV = 'Staging'
    IMAGE_NAME = "rajunavaganesh/node-demo"
    DEPLOY_COMMIT_HASH = sh(returnStdout: true, script: "git rev-parse HEAD | cut -c1-7").trim()
    registryCredential = 'docker-registry'
    dockerImage = ''
  }      
  
stages { 

stage('Git') {
  steps {
        echo 'Cloning the Application Repo'
        git 'git@github.com:navaganeshr/node-demo.git'
  }
}
          
stage('Build image') { 
  steps {
    echo 'Build the docker image'
      script {
         dockerImage = docker.build IMAGE_NAME 
      }
  }
}

stage('Push image') {
  steps {
    echo 'Pushing the Docker image'
   script {
    docker.withRegistry( '', registryCredential ) {
    dockerImage.push("$DEPLOY_COMMIT_HASH")
    dockerImage.push('latest')
    }
   }
  }
}  

stage('Deploy') {
  steps {
    echo 'Deploying the Application'
       script {
           sh " docker-compose up  "
              }
            }
        }        
  }
}