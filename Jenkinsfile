// Function to validate that the message returned from SonarQube is ok
def qualityGateValidation(qg) {
    if (qg.status != 'OK') {
        // emailext body: "WARNING SANTI: Code coverage is lower than 70% in Pipeline ${BUILD_NUMBER}", subject: 'Error Sonar Scan,   Quality Gate', to: "${EMAIL_ADDRESS}"
        return true
    }
    // emailext body: "CONGRATS SANTI: Code coverage is higher than 70%  in Pipeline ${BUILD_NUMBER} - SUCCESS", subject: 'Info - Correct Pipeline', to: "${EMAIL_ADDRESS}"
    return false
}
pipeline {
    agent any

    tools {
        maven 'mavenTool'
    }

    environment {
        // General Variables for Pipeline
        PROJECT_ROOT = 'practica-devops'
        // Important: Change "san99tiagodevsecops" for your <email>...
        EMAIL_ADDRESS = 'san99tiagodevsecops@gmail.com'
        // Important> Change "san99tiago" for your DockerHub <username>...
        REGISTRY = 'san99tiago/devops_challenge'
    }

    stages {
        stage('Hello') {
            steps {
                // First stage is a sample hello-world step to verify correct Jenkins Pipeline
                echo 'This is my Pipeline to test, analyze, build and deploy docker-hub image'
            }
        }
        stage('checkout') {
            steps {
                // Get Github repo using Github credentials (previously added to Jenkins credentials)
                checkout([$class: 'GitSCM', branches: [[name: '**']], extensions: [], userRemoteConfigs: [[credentialsId: 'gitlab-credentials', url: 'https://git.pragma.com.co/DevSecOps/practica-jenkins']]])
            }
        }
        stage('build') {
            steps {
                // Build the app-artifact with Maven Plugin
                // "-DskipTests" to NOT execut unit tests in the artifacte
                sh "mvn -f ${PROJECT_ROOT} clean install -DskipTests"
            }
        }
        stage('scan') {
            environment {
                // Previously defined in the Jenkins "Global Tool Configuration"
                scannerHome = tool 'sonar-scanner'
            }
            steps {
                // "sonarqube" is the server configured in "Configure System"
                withSonarQubeEnv('sonarqube') {
                    // Execute the SonarQube scanner with desired flags
                    sh "${scannerHome}/bin/sonar-scanner \
                        -Dsonar.projectKey=HappyAppDevOps:Test \
                        -Dsonar.projectName=HappyAppDevOps \
                        -Dsonar.projectVersion=0.${BUILD_NUMBER} \
                        -Dsonar.host.url=http://mysonarqube:9000 \
                        -Dsonar.sources=./${PROJECT_ROOT}/src \
                        -Dsonar.login=admin \
                        -Dsonar.password=admin \
                        -Dsonar.language=java \
                        -Dsonar.java.binaries=./${PROJECT_ROOT}/target/classes \
                        -Dsonar.coverage.jacoco.xmlReportPaths=./${PROJECT_ROOT}/target/site/jacoco-aggregate-all/jacoco.xml \
                        -Dsonar.java.coveragePlugin=jacoco"
                }
                timeout(time: 3, unit: 'MINUTES') {
                    // In case of SonarQube failure or direct timeout exceed, stop Pipeline
                    waitForQualityGate abortPipeline: qualityGateValidation(waitForQualityGate())
                }
            }
        }
        stage('build-image') {
            steps {
                sh 'echo ------ BUILDING DOCKER-IMAGE ------'
                // Move the generated "jar" artifact to the root path
                sh "cd ${PROJECT_ROOT}/target; ls; mv ${PROJECT_ROOT}.jar ../../"
                sh "docker build -t ${REGISTRY}:${BUILD_NUMBER} . "
            }
        }
        stage('deploy-image') {
            steps {
                sh 'echo ----- PUSHING IMAGE TO DOCKERHUB -----'
                // If the Dockerhub authentication stopped, do it again
                // Remember to enter the Jenkins' Docker container and do it manually
                sh 'docker login'
                sh "docker push ${REGISTRY}:${BUILD_NUMBER}"
                sh "docker push ${REGISTRY}:latest"
                //emailext body: "NEW Docker-image ${REGISTRY}:${BUILD_NUMBER}  published in Dockerhub from Pipeline ${BUILD_NUMBER}", subject: 'Published new Docker-image on Dockerhub', to: "${EMAIL_ADDRESS}"
            }
        }
    }
}
