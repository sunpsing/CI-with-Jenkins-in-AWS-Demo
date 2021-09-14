pipeline {
    agent any
    environment {
	    MVN_GROUPID = "com.tommy"
	    MVN_REPOSITORY = "maven-releases"
	    SNR_TKN = "4cc74f5cc72617102abfc0e28e9405c3e1879394"
	    EMAIL_DL = "abhijitdd@yahoo.co.in"
	    DKR_IMAGE_NAME = "ci-demo:latest"
	    DKR_CONT_NAME = "ci-demo1"
    }
    
    stages {
        
	    stage('Build code') {
		    steps {
			echo "Building project"
			git branch: 'assignment3', url: 'https://github.com/abhjtgt/CI-with-Jenkins-in-AWS-Demo.git'

			echo "Maven - building package." 
			sh "mvn -Dmaven.test.failure.ignore=true clean package"
		    }
	    }
	
	    stage("Build image") {
		    steps {
			    sh '''
			    echo "Checking for artifact" 
			    cd project/target
			    artifact=$(ls -1t *war| head -1)
			    
			    if [ -z $artifact ] ;
			    then
			    	echo "Artifact not found" 
				exit 1
			    else
				echo "Artifact found $artifact. Building new docker image."    
			    	cd ../..
				docker build -t $DKR_IMAGE_NAME . --build-arg WAR="${artifact}"
			    fi
			    '''
			    

		    }
		}

	    stage("Run image") {
		    steps {
				sh '''
				echo "Stopping and removing old container, if exists" 
				if [ \$(docker ps    --filter 'Name=ci-demo1' -q | wc -l) -gt 0 ]; then
			    		docker stop \$(docker ps --filter 'Name=ci-demo1' -q) 2>/dev/null
				fi
				if [ \$(docker ps -a --filter 'Name=ci-demo1' -q | wc -l) -gt 0 ]; then
					docker rm \$(docker ps -a --filter 'Name=ci-demo1' -q) 2>/dev/null
				fi					
				echo "Running docker image $DKR_IMAGE_NAME"
			    	docker run --name $DKR_CONT_NAME -d -p 8085:8080 $DKR_IMAGE_NAME
				
				echo "Application is up at http://localhost:8085/ci-demo/"
				'''
		    }
		}
    }
}
