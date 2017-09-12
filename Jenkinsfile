#!groovy

properties(
	[
                parameters([
                                string(description: "Target tag name", name: 'targetTag',  defaultValue: "v1.3.2.1"),
                ])
    ])

pipeline {
    agent any
    stages {

        stage('Verify toolchain') {
            steps {
                def MAVEN_BUILD=tool name: 'Maven 3.5.0', type: 'hudson.tasks.Maven$MavenInstallation'
                echo "Driving build and unit tests using Maven $MAVEN_BUILD"

               def JAVA8_HOME=tool name: 'JDK 1.8 (latest)', type: 'hudson.model.JDK'
               echo "Running build and unit tests with Java $JAVA8_HOME"
            }
        }

        stage('Checkout') {
            echo 'Checkout source code'
            git branch: 'refs/tags/v1.3.2.1', poll: false, url: 'https://github.com/iotaledger/iri.git'
        }

        stage('Do Maven build') {
            steps {
                withEnv(["PATH+MAVEN=$MAVEN_BUILD/bin","PATH+JDK=$JAVA8_HOME/bin"]) {
                    stage 'Maven clean'
                    sh "mvn clean"

                    stage 'Maven package'
                    sh "mvn package"
                }
            }
        }
    }
}

