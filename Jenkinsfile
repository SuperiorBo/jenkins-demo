pipeline{
    agent any
    stages{
        stage('Pull Git Demo'){
            steps{
                git credentialsId: 'www', url: 'git@192.168.200.119:dotnetcore/jenkins-demo.git'
                echo 'Deploying'
                sh 'sh ./deploy_jenkins.sh'
            }
        }
    }
}