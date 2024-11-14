
pipeline {
    agent any
    stages {
        stage('Run Parallel Jobs') {
            parallel {
                stage('Job 1') {
                    steps {
                        script {
                            displayJobInfo("Job 1")
                        }
                    }
                }
                stage('Job 2') {
                    steps {
                        script {
                            displayJobInfo("Job 2")
                        }
                    }
                }
            }
        }
    }
}

def displayJobInfo(jobName) {
    def currentTime = new Date()
    def formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
    def formattedTime = formatter.format(currentTime)

    echo "Running ${jobName}"
    echo "Job name: ${jobName}: ${formattedTime}"
}
