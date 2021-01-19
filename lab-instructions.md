# Lab Setup Instructions
The following are the setup instructions for the lab (do look at the diferent optional paths for the lab below. You won't need the cloud specific parts if that is not what interests you such as GitHub, Docker Hub, Kubernetes and Azure).

* Please bring your laptop and ensure a reliable internet connection.
* Install JDK 8 (we used [Azul Zulu Java 8 LTS](https://www.azul.com/downloads/zulu-community/)).
* Install the Eclipse IDE for Enterprise Java Developers from [here](https://www.eclipse.org/downloads/packages/).
* Download the latest version of WildFly from [here](https://www.wildfly.org/downloads/). Make sure to download the full Jakarta EE version. Unzip the download somewhere in your file system.
* Install Docker for your OS.
* You will need a GitHub account.
* You need to have docker CLI installed and you must be signed into your Docker Hub account. To create a Docker Hub account go to [https://hub.docker.com](https://hub.docker.com).
* You will need to setup kubectl. [Here](https://kubernetes.io/docs/tasks/tools/install-kubectl/) are instructions on how to do that.
* You will need an Azure subscription. If you don't have one, you can get one for free for one year [here](https://azure.microsoft.com/en-us/free).
* You will need to install the Azure CLI. [Here](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest) are instructions on how to do that.
* You will need to sign up for Azure DevOps for free [here](https://azure.microsoft.com/en-us/services/devops/).

# Lab Paths
Each of the parts of this repository can be run independently, which means you can go directly to the parts that interest you the most. Below are some recommendations.

* Take a quickly look at the code in the [javaee](/javaee) folder.
* If you don't have a cloud service you could explore the 3 ways a Java EE application can be packaged to run on Docker [thin-war](/thin-war), [uber-jar](/uber-jar) and [hollow-uber-jar](/hollow-uber-jar). Also, the [exposed-port](/exposed-port) and [external-volume](/external-volume) sections can be run in a local Docker.
* If you have a cloud service such as Azure with a Kubernetes engine you can go to the [kubernetes-clustering](/kubernetes-clustering) and [kubernetes-devops](/kubernetes-devops) parts.
