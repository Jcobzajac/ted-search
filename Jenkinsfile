pipeline {
    
    agent any
    
    tools {
      maven "3.6.2"   
    }
    environment {
      COMMIT_MESSAGE= sh(
      returnStdout: true, 
        script: 'git log --oneline -n1 | cut -d " " -f2').trim()
    }
    
    stages {

        stage("Test") {
            steps {
              sh "mvn test"  
            }
        }
        
        stage("Build") {
            steps {
             sh "mvn package"
             dir('nginx_files') {
                sh "docker build -t nginxted ."   
             }
            }
        }
        
         stage("E2E") {
            when { expression { env.COMMIT_MESSAGE == "#test" } }
            steps {
             sh "chmod 700 push_images_ECR.sh"
             sh "./push_images_ECR.sh -test"
             dir('terraform') {
                sh ''' #!/bin/bash
                  chmod 700 test_deploy.sh
                  ./test_deploy.sh
              '''   
             }
            }
        }

        stage("Publish") {
            when { expression { env.GIT_BRANCH == "main" } }
            steps {
              sh "./push_images_ECR.sh"
            }
        }


        stage("Deploy") {
            when { expression { env.GIT_BRANCH == "main" } }
            steps {
              dir('terraform') {
                sh ''' #!/bin/bash
                  chmod 700 production_deploy.sh
                  ./production_deploy.sh
                '''
              }
            }
        }
        stage("Cleanup the environment") {
            steps {
              dir ('terraform') {
                  sh ''' #!/bin/bash
                    #Included additionally to primary pipeline, because if another job is not setup to execute periodically, then sometimes people forgot about executing it manually
                    chmod 700 cleaner.sh
                    ./cleaner.sh
                  '''
              }
            }
        }   
    }

}
