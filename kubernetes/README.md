# Deploying a Java EE application on Azure using Docker and Kubernetes
This demo shows how you can deploy a Java EE application to Azure using Docker and Kubernetes. The following is how you run the demo.

## Setup
* You will need an Azure subscription. If you don't have one, you can get one for free for one year [here](https://azure.microsoft.com/en-us/free).

## Start Managed PostgreSQL on Azure
We will be using the fully managed PostgreSQL offering in Azure for this demo. If you have not set it up yet, please do so now. 

* Go to the [Azure portal](http://portal.azure.com).
* Select Create a resource -> Databases -> Azure Database for PostgreSQL. Select a single server.
* Specify the Server name to be javaee-cafe-db. Create a new resource group named javaee-cafe-group. Specify the login name to be postgres. Specify the password to be Secret123!. Hit 'Create'. It will take a moment for the database to deploy and be ready for use.
* In the portal, go to 'All resources'. Find and click on javaee-cafe-db. Open the connection security panel. Enable access to Azure services, disable SSL connection enforcement and then hit Save.

Once you are done exploring the demo, you should delete the javaee-cafe-group resource group. You can do this by going to the portal, going to resource groups, finding and clicking on javaee-cafe-group and hitting delete. This is especially important if you are not using a free subscription! If you do keep these resources around (for example to begin your own prototype), you should in the least use your own passwords and make the corresponding changes in the demo code.

## Setup the Kubernetes Cluster
* You will first need to create the Kubernetes cluster. Go to the [Azure portal](http://portal.azure.com). Hit Create a resource -> Containers -> Kubernetes Service. Select the resource group to be javaee-cafe-group. Specify the cluster name as javaee-cafe-cluster. Hit Review + create. Hit Create.

## Setup Kubernetes Tooling
* You will now need to setup kubectl. [Here](https://kubernetes.io/docs/tasks/tools/install-kubectl/) are instructions on how to do that.
* Next you will install the Azure CLI. [Here](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest) are instructions on how to do that.
* You will then connect kubectl to the Kubernetes cluster you created. To do so, run the following command:

   ```
   az aks get-credentials --resource-group javaee-cafe-group --name javaee-cafe-cluster
   ```
  If you get an error about an already existing resource, you may need to delete the ~/.kube directory.
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
   docker build -t <your Docker Hub ID>/javaee-cafe:v1 .
   docker push <your Docker Hub ID>/javaee-cafe:v1
   ```
* Replace the `<your Docker Hub ID>` value with your account name in `javaee-cafe.yml` file.
* You can now deploy the application:

   ```
   kubectl create -f javaee-cafe.yml
   ```
* Get the External IP address of the Service, then the application will be accessible at `http://<External IP Address>/javaee-cafe`:
   ```
   kubectl get svc javaee-cafe --watch
   ```
  It may take a few minutes for the load balancer to be created. When the external IP changes over from *pending* to a valid IP, just hit Control-C to exit.

* Scale your application:
   ```
   kubectl scale deployment javaee-cafe --replicas=3
   ```
   
## Deleting the Resources
* Delete the application deployment:
   ```
   kubectl delete -f javaee-cafe.yml
   ```
