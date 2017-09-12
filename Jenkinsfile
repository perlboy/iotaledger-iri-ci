pipeline {
    agent any

    parameters {
		string(description: "Target tag name", name: 'targetTag',  defaultValue: "v1.3.2.1")
    }

	stages {
	    stage("Checkout") {
			steps {
				echo 'Checkout source code for ci repo'
				checkout scm
		        echo 'Checkout source code for iri'
				checkout scm: [$class: 'GitSCM', userRemoteConfigs: [[url: "https://github.com/iotaledger/iri.git"]], branches: [[name: "refs/tags/v1.3.2.1"]]], poll: false
			}
	    }
	
	    stage("Do Maven build") {
	        steps {
                echo 'Maven clean'
                sh "mvn clean"

                echo 'Maven package'
                sh "mvn package"
	        }
	     }
	}
}

