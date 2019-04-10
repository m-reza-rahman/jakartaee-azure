# Deploying a Java EE application on Azure using IaaS
This demo shows how you can deploy a Java EE application to Azure using Linux virtual machines. The following is how you run the demo.

## Setup
* You will need an Azure subscription. If you don't have one, you can get one for free for one year [here](https://azure.microsoft.com/en-us/free).

## Start Managed PostgreSQL on Azure
We will be using the fully managed PostgreSQL offering in Azure for this demo. If you have not set it up yet, please do so now. 

* Go to the [Azure portal](http://portal.azure.com).
* Select Create a resource -> Databases -> Azure Database for PostgreSQL.
* Specify the Server name to be javaee-cafe-db. Create a new resource group named javaee-cafe-group. Specify the login name to be postgres. Specify the password to be Secret123!. Hit 'Create'. It will take a moment for the database to deploy and be ready for use. 

## Start the Application on a Virtual Machine
The next step is to get the application up and running on a virtual machine. Follow the steps below to do so.

* Open Eclipse.
* Do a full build of the javaee-cafe application via Maven by going to Right click the application -> Run As -> Maven install.
* Browse to where you have this repository code in your file system. You will now need to copy the war file to where we will build the Docker image. You will find the war file under javaee/javaee-cafe/target. Copy the war file to thin-war/.
* You should explore the Dockerfile in this directory used to build the Docker image. It simply starts from the `websphere-liberty` image, adds the `javaee-cafe.war` from the current directory in to the `dropins` directory, copies the PostgreSqQL driver `postgresql-42.2.4.jar` into the `shared/resources` directory and replaces the defaultServer configuration file `server.xml`.
* Notice how the data source properties in the `server.xml` file looks like:

<pre>serverName="172.17.0.2"
portNumber="5432"
databaseName="postgres"
user="postgres"
password=""</pre>

* Note, we are depending on the fact that the database is the first container to start and has the IP 172.17.0.2. For Mac and Windows users the serverName could be changed to `host.docker.internal`. That will make the container start order less significant.
* Open a console. Build a Docker image tagged `javaee-cafe` navigating to the thin-war/ directory as context and issuing the command:

	```
	docker build -t javaee-cafe .
	```
* To run the newly built image, use the command:

	```
	docker run -it --rm -p 9080:9080 javaee-cafe
	```
* Wait for WebSphere Liberty to start and the application to deploy sucessfully (to stop the application and Liberty, simply press Control-C).
* Once the application starts, you can test the REST service at the URL: [http://localhost:9080/javaee-cafe/rest/coffees](http://localhost:9080/javaee-cafe/rest/coffees) or via the JSF client at [http://localhost:9080/javaee-cafe/index.xhtml](http://localhost:9080/javaee-cafe/index.xhtml).
