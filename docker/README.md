# Deploying a Jakarta EE application on Azure using Docker
This demo shows how you can deploy a Jakarta EE application to Azure using Docker and Azure Container Apps. The following is how you run the demo.

## Setup
* You will need a GitHub account.
* You will need an Azure subscription. If you don't have one, you can get one for free for one year [here](https://azure.microsoft.com/en-us/free).

## Start Managed PostgreSQL on Azure
We will be using the fully managed PostgreSQL offering in Azure for this demo. If you have not set it up yet, please do so now. 

* Go to the [Azure portal](http://portal.azure.com).
* Select 'Create a resource'. In the search box, enter and select 'Azure Database for PostgreSQL'. Hit create. Select a single server. Hit create again.
* Create a new resource group named jakartaee-cafe-group-`<your suffix>` (the suffix could be your first name such as "reza"). Specify the Server name to be jakartaee-cafe-db-`<your suffix>` (the suffix could be your first name such as "reza"). Specify the login name to be postgres. Specify the password to be Secret123!. Create the resource. It will take a moment for the database to deploy and be ready for use.
* In the portal home, go to 'All resources'. Find and click on jakartaee-cafe-db-`<your suffix>`. Open the connection security panel. Enable access to Azure services, disable SSL connection enforcement and then hit 'Save'.

Once you are done exploring the demo, you should delete the jakartaee-cafe-group-`<your suffix>` resource group. You can do this by going to the portal, going to resource groups, finding and clicking on jakartaee-cafe-group-`<your suffix>` and hitting delete. This is especially important if you are not using a free subscription! If you do keep these resources around (for example to begin your own prototype), you should in the least use your own passwords and make the corresponding changes in the demo code.

## Build and Publish the Docker Image
* You need to have docker CLI installed and you must be signed into your Docker Hub account. To create a Docker Hub account go to [https://hub.docker.com](https://hub.docker.com).
* Open Eclipse.
* Get the basic jakartaee-cafe application into the IDE if you have not done so already. In order to do that, go to File -> Import -> Maven -> Existing Maven Projects. Then browse to where you have this repository code in your file system and select jakartaee/jakartaee-cafe. Accept the rest of the defaults and finish.
* Do a full build of the jakartaee-cafe application via Maven by going to Right click the application -> Run As -> Maven install.
* Open a terminal. Navigate to where you have this repository code in your file system. Navigate to the docker/ directory.
* Log in to Docker Hub using the docker login command:

   ```
   docker login
   ```
* Build a Docker image and push the image to Docker Hub:

   ```
   docker build -t <your Docker Hub ID>/jakartaee-cafe:v1 .
   docker push <your Docker Hub ID>/jakartaee-cafe:v1
   ```

## Deploy the Docker Image to Azure
* Go to the [Azure portal](http://portal.azure.com). Hit Create a resource -> Containers -> Container Instances. Select the resource group to be jakartaee-cafe-group-`<your suffix>`. Hit OK. Specify the container name to be jakartaee-cafe-container-`<your suffix>` (the suffix could be your first name such as "reza"). Select the image source to be Docker Hub. Specify the container image to be [your Docker Hub ID]/jakartaee-cafe:v1. Click next.
* Specify the DNS name to be jakartaee-cafe-`<your suffix>` (the suffix could be your first name such as "reza"). Specify the port to be 8080. Hit create.
* In the portal, go to 'All resources'. Find and click on jakartaee-cafe-container-`<your suffix>`. In the overview panel, note the FQDN where the application is available.
* The application will be accessible at `http://[FQDN]:8080/jakartaee-cafe`.
