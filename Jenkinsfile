pipeline {
    agent any

    stages {
        stage('Blue-Green Deployment') {
            steps {
                sh '''
                    export KUBECONFIG=/var/jenkins_home/.kube/config

                    CURRENT=$(kubectl get svc bg-app-router -o jsonpath='{.spec.selector.version}')

                    if [ "$CURRENT" = "blue" ]; then
                        NEXT="green"
                    else
                        NEXT="blue"
                    fi

                    echo "Current: $CURRENT"
                    echo "Next: $NEXT"

                    kubectl apply -f ${NEXT}-deployment.yaml
                    kubectl rollout status deployment/${NEXT}-deployment

                    kubectl get svc bg-app-router -o yaml > router.yaml
                    sed -i "s/version: $CURRENT/version: $NEXT/" router.yaml
                    kubectl apply -f router.yaml

                    echo "Switched to $NEXT"
                '''
            }
        }
    }
}