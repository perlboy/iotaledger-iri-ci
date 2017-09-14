pipeline {
    agent any

    parameters {
		string(description: "Target tag name", name: 'targetVersion',  defaultValue: "1.3.2.2")
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
					sh "echo > ../iotaledger-iri-ci/debian/changelog && prevtag=v1.2.0 && git tag -l v* | sort -V | while read tag; do     (echo \"$pkgname (${tag#v}) unstable; urgency=low\"; git log --pretty=format:'  * %s' $prevtag..$tag; git log --pretty='format:%n%n -- %aN <%aE>  %aD%n%n' $tag^..$tag) | cat - ../iotaledger-iri-ci/debian/changelog | sponge ../iotaledger-iri-ci/debian/changelog;         prevtag=$tag; done"
				}

				dir('iotaledger-iri-ci') {
					echo "Produce debian source file for upload"
					sh "dpkg-buildpackage -I -I.* -S"
	        }
	     }

		

	}
}

