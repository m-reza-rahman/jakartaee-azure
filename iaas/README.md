# Deploying a Java EE application on Azure using IaaS
This demo shows how you can deploy a Java EE application to Azure using Linux virtual machines. The following is how you run the demo.

## Setup
* You will need an Azure subscription. If you don't have one, you can get one for free for one year [here](https://azure.microsoft.com/en-us/free).

## Start Managed PostgreSQL on Azure
We will be using the fully managed PostgreSQL offering in Azure for this demo. If you have not set it up yet, please do so now. 

* Go to the [Azure portal](http://portal.azure.com).
* Select Create a resource -> Databases -> Azure Database for PostgreSQL. Select a single server.
* Specify the Server name to be javaee-cafe-db. Create a new resource group named javaee-cafe-group. Specify the login name to be postgres. Specify the password to be Secret123!. Hit 'Create'. It will take a moment for the database to deploy and be ready for use.
* In the portal, go to 'All resources'. Find and click on javaee-cafe-db. Open the connection security panel. Enable access to Azure services, disable SSL connection enforcement and then hit Save.

Once you are done exploring the demo, you should delete the javaee-cafe-group resource group. You can do this by going to the portal, going to resource groups, finding and clicking on javaee-cafe-group and hitting delete. This is especially important if you are not using a free subscription! If you do keep these resources around (for example to begin your own prototype), you should in the least use your own passwords and make the corresponding changes in the demo code.

## Start the Application on a Virtual Machine
The next step is to get the application up and running on a virtual machine. Follow the steps below to do so.

* Go to the [Azure portal](http://portal.azure.com).
* Select Create a resource -> Compute -> Ubuntu Server [the latest featured stable version in Azure].
* Enter the resource group as javaee-cafe-group. Enter the virtual machine name as javaee-cafe-server. Choose password based authentication instead of SSH. Enter wildfly as the username. Specify the password to be Secret12345!. Select 'Allow selected ports'. Pick the HTTP (80), HTTPS (443) and SSH (22) ports to open. Hit 'Create'.
* In the portal, go to 'All resources'. Find and click on javaee-cafe-server. Click on 'Connect'. On the SSH tab, you should be able to find the command to connect to this virtual machine. It will look something like:

	```
	ssh wildfly@[some public IP]
	```
* Connect to the virtual machine by executing this command.
* Run the following to update the package manager.

	```
	sudo apt-get update
	```
* Install Java by executing the following command.

	```
	sudo apt install openjdk-8-jdk
	```
* Install Maven by executing the following command.

	```
	sudo apt install maven
	```
* Download WildFy by executing the following command:

	```
	wget https://download.jboss.org/wildfly/16.0.0.Final/wildfly-16.0.0.Final.zip
	```
* Install unzip by executing the following command:

	```
	sudo apt install unzip
	```	
* Unzip WildFy by executing the following command:

	```
	unzip wildfly-16.0.0.Final.zip
	```
* Download the application by executing the following command:

	```
	wget https://github.com/m-reza-rahman/javaee-azure/archive/master.zip
	```
* Unzip the application by executing the following command:

	```
	unzip master.zip
	```
*  Change directories to where the application was extracted. Move to the javaee/javaee-cafe directory. Build the application by executing:

	```
	mvn install
	```
* Change directories back to home.
* Execute the following commands to install the JDBC driver, the standalone configuration and the application:
	```
	mkdir -p wildfly-16.0.0.Final/modules/org/postgresql/main
	cp javaee-azure-master/javaee/server/postgresql-42.2.4.jar wildfly-16.0.0.Final/modules/org/postgresql/main/
	cp javaee-azure-master/javaee/server/module.xml wildfly-16.0.0.Final/modules/org/postgresql/main/
	cp javaee-azure-master/iaas/standalone.xml wildfly-16.0.0.Final/standalone/configuration/
	cp javaee-azure-master/javaee/javaee-cafe/target/javaee-cafe.war wildfly-16.0.0.Final/standalone/deployments/
	```
* Change directories to wildfly-16.0.0.Final/bin. Run the following command to get root shell access:

	```
	sudo su
	```
* Execute the following command to start WildFly:
	```
	./standalone.sh
	```
* In the portal, go to 'All resources'. Find and click on javaee-cafe-server. In the overview panel, find and copy the public IP address.
* Once the application starts, you can test the REST service at the URL: http://[your public IP]/javaee-cafe/rest/coffees or via the JSF client at http://[your public IP]/javaee-cafe/index.xhtml.
