pipeline {
    agent any

	options(
		[
	                parameters([
	                                string(description: "Target tag name", name: 'targetTag',  defaultValue: "v1.3.2.1"),
	                ])
	    ]
	)

	stages {
	    stage("Checkout") {
			steps {
		        echo 'Checkout source code'
		        git branch: 'refs/tags/v1.3.2.1', poll: false, url: 'https://github.com/iotaledger/iri.git'
			}
	    }
	
	    stage("Do Maven build") {
	        steps {
	            withEnv(["PATH+MAVEN=$MAVEN_BUILD/bin","PATH+JDK=$JAVA8_HOME/bin"]) {
	                echo 'Maven clean'
	                sh "mvn clean"
	
	                echo 'Maven package'
	                sh "mvn package"
	            }
	        }
	     }
	}
}

