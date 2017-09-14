pipeline {
    agent any

    parameters {
		string(description: "Target tag name", name: 'targetVersion',  defaultValue: "1.3.2.2"),
		string(description: "Signing Key Id", name: 'keyId',  defaultValue: "E85A1CDA")
    }

	stages {
	    stage("Checkout") {
			steps {
				dir('iotaledger-iri-ci') {
					echo 'Checkout source code for ci repo'
					checkout scm
				}
				dir('iotaledger-iri') {
			        echo 'Checkout source code for iri'
					checkout scm: [$class: 'GitSCM', userRemoteConfigs: [[url: "https://github.com/iotaledger/iri.git"]], branches: [[name: "refs/tags/v${targetVersion}"]]], poll: false
				}
			}
	    }
	
	    stage("Do Maven build") {
	        steps {
				dir('iotaledger-iri') {	
	                echo 'Maven clean'
	                sh "mvn clean"
	
	                echo 'Maven package'
	                sh "mvn package"
				}
	        }
	     }

	    stage("Prep debian build") {
	        steps {
				dir('iotaledger-iri') {	
	                echo 'Transfer iri jar into ci source tree'
	                sh "cp target/iri-${targetVersion}.jar ../iotaledger-iri-ci/iri.jar"
					echo 'Produce fresh debian changelog using gitlog'
					sh " ../iotaledger-iri-ci/makechangelog.sh"
				}
            }
        }
    
        stage("Produce debian source file") {
           steps {
				dir('iotaledger-iri-ci') {
					echo "Produce debian source file for upload"
					sh "dpkg-buildpackage -k${keyId} -p'gpg --no-tty --passphrase-file /etc/jenkins.passphrase' -I -I.* -S"
				}
	        }
	    }

        stage("Upload source file to launchpad") {
             sh "dput ppa:iotaledger/ppa iotaledger-iri_${targetVersion}_source.changes"
        }

		

	}
}

