# Deploying a Java EE application on Azure using Docker and Kubernetes
This demo shows how you can deploy a Java EE application to Azure using Docker and Kubernetes. The following is how you run the demo.

## Setup
* You will need an Azure subscription. If you don't have one, you can get one for free for one year [here](https://azure.microsoft.com/en-us/free).

## Start Managed PostgreSQL on Azure
We will be using the fully managed PostgreSQL offering in Azure for this demo. If you have not set it up yet, please do so now. 

* Go to the [Azure portal](http://portal.azure.com).
* Select Create a resource -> Databases -> Azure Database for PostgreSQL.
* Specify the Server name to be javaee-cafe-db. Create a new resource group named javaee-cafe-group. Specify the login name to be postgres. Specify the password to be Secret123!. Hit 'Create'. It will take a moment for the database to deploy and be ready for use.

## Setup the Kubernetes Cluster
* You will first need to create the Kubernetes cluster. Go to the [Azure portal](http://portal.azure.com). Hit Create a resource -> Containers -> Kubernetes Service. Select the resource group to be javaee-cafe-group. Specify the cluster name as javaee-cafe-cluster. Hit Review + create. Hit Create.
* Next you will need to create a public static IP address. Go to the [Azure portal](http://portal.azure.com). Hit Create a resource. Search the marketplace for 'Public IP address'. Once you find it, hit 'Create'. Specify the name to be javaee-cafe-ip. Select the IP assignment type to be static. For the resoure group, *don't pick javaee-cafe-group*. Instead you will see something like MC_javaee-cafe-group_javaee-cafe-cluster_[some region]. Pick that and hit create.
* Go to All resources. Find javaee-cafe-ip and click on it. On the Overview pane, copy down the IP address.
* In the portal, go to 'All resources'. Find and click on javaee-cafe-db. Open the connection security panel. For rule name, specify allow-cluster-access. For the start and end IP, enter the public IP for javaee-cafe-ip you copied earlier. Make sure the rule is applied. Disable SSL connection enforcement and then hit Save.

## Setup Kubernetes Tooling
* You will now need to setup kubectl. [Here](https://kubernetes.io/docs/tasks/tools/install-kubectl/) are instructions on how to do that.
* Next you will install the Azure CLI. [Here](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest) are instructions on how to do that.
* You will then connect kubectl to the Kubernetes cluster you created. To do so, run the following command:

   ```
   az aks get-credentials --resource-group javaee-cafe-group --name javaee-cafe-cluster
   ```
* You need to have docker cli installed and you must be signed into your Docker Hub account. To create a Docker Hub account go to [https://hub.docker.com](https://hub.docker.com).

## Deploy the Java EE Application on Kubernetes
* Open Eclipse.
* Do a full build of the javaee-cafe application via Maven by going to Right click the application -> Run As -> Maven install.
* Browse to where you have this repository code in your file system. You will now need to copy the war file to where we will build the Docker image next. You will find the war file under javaee/javaee-cafe/target. Copy the war file to kubernetes/.
* Open a terminal. Navigate to where you have this repository code in your file system. Navigate to the kubernetes/ directory.
* Log in to Docker Hub using the docker login command:
   ```
   docker login
   ```
* Build a Docker image and push the image to Docker Hub:
   ```
   docker build -t <your Docker Hub account>/javaee-cafe:v1 .
   docker push <your Docker Hub account>/javaee-cafe:v1
   ```
* Replace the `<your Docker Hub account>` value with your account name in `javaee-cafe.yml` file, then deploy the application:
   ```
   kubectl create -f javaee-cafe.yml
   ```

* Get the External IP address of the Service, then the application will be accessible at `http://<External IP Address>:9080/javaee-cafe`:
   ```
   kubectl get svc javaee-cafe
   ```
   > **Note:** It may take a few minutes for the load balancer to be created.

* Scale your application:
   ```
   kubectl scale deployment javaee-cafe --replicas=3
   ```
   
## Deleting the Resources
* Delete the Java EE deployment:
   ```
   kubectl delete -f javaee-cafe.yml
   ```
