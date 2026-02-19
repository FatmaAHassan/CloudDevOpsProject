//  Shared Library
def buildImage(String imageName, String tag) {
    echo "--- Building Docker Image: ${imageName}:${tag} ---"
    sh "docker build -t ${imageName}:${tag} ."
}

def pushImage(String imageName, String tag, String credentialsId) {
    echo "--- Pushing Docker Image to Hub ---"
    withCredentials([usernamePassword(credentialsId: credentialsId, passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
        sh "echo \$DOCKER_PASS | docker login -u \$DOCKER_USER --password-stdin"
        sh "docker push ${imageName}:${tag}"
        sh "docker push ${imageName}:latest"
    }
}

def deleteImageLocally(String imageName, String tag) {
    echo "--- Cleaning up local images ---"
    sh "docker rmi ${imageName}:${tag}"
    sh "docker rmi ${imageName}:latest"
}
