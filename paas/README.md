# Deploying a Java EE Application on Azure using PaaS
This demo shows how you can deploy a Java EE application to Azure using fully managed WildFly. The following is how you run the demo.

## Setup
* You will need an Azure subscription. If you don't have one, you can get one for free for one year [here](https://azure.microsoft.com/en-us/free).

## Start Managed PostgreSQL on Azure
We will be using the fully managed PostgreSQL offering in Azure for this demo. If you have not set it up yet, please do so now. 

* Go to the [Azure portal](http://portal.azure.com).
* Select Create a resource -> Databases -> Azure Database for PostgreSQL.
* Specify the Server name to be javaee-cafe-db. Create a new resource group named javaee-cafe-group. Specify the login name to be postgres. Specify the password to be Secret123!. Hit 'Create'. It will take a moment for the database to deploy and be ready for use. 
* In the portal, go to 'All resources'. Find and click on javaee-cafe-db. Open the connection security panel. Enable access to Azure services, disable SSL connection enforcement and then hit Save.

## Setup Managed WildFly
* Go to the [Azure portal](http://portal.azure.com).
* Select Create a resource -> Web -> Web App.
* Enter javaee-cafe as application name and select javaee-cafe-group as the resource group. Choose Linux as the OS and WildFly as the runtime. Hit create.
* In the portal, go to 'All resources'. Find and click on javaee-cafe.
* Go to the Deployment Center. Select FTP -> Dashboard -> User Credentials. Enter wildfly as the username. Enter Secret12345! as the password. Click 'Save Credentials'.
* Go to the Overview panel. Note down the FTP access information. Connect with your favorite FTP client.
* Go to where this application is on your local machine. Got to the paas directory. Via FTP, upload the JDBC driver to the /home/site/deployments/tools/ directory in binary mode. The upload the jboss_cli_commands.cli and postgresql-module.xml files in text mode to the /home/site/deployments/tools/ directory. Finally, upload the startup.sh file in text mode to the /home directory.
* Go back to the Overview panel for javaee-cafe and hit restart.




https://javaee-cafe.azurewebsites.net


## Start the Application on a Virtual Machine
The next step is to get the application up and running on a virtual machine. Follow the steps below to do so.


* Enter the resource group as javaee-cafe-group. Enter the virtual machine name as javaee-cafe-server. Choose password based authentication instead of SSH. Enter wildfly as the username. Specify the password to be Secret12345!. Select 'Allow selected ports'. Pick the HTTP (80), HTTPS (443) and SSH (22) ports to open. Click next. Accept the defaults for disks and click next. Accept the defaults for networking and click next. Accept the defaults for management and click next. Accept the defaults for advanced options and click next. Accept the defaults for tags and click next. Hit 'Create'
* Once the virtual machine is created, you'll need to find out its assigned public IP address. In the portal, go to 'All resources'. Find and click on javaee-cafe-server. In the overview panel, find and copy the public IP address.

* In the portal, go to 'All resources'. Find and click on javaee-cafe-server. Click on 'Connect'. On the SSH tab, you should be able to find the command to connect to this virtual machine. It will look something like:

	```
	ssh wildfly@[some public IP]
	```
* Connect to the virtual machine by executing this command.
* Install Maven by executing the following command. This will also install Java.

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
