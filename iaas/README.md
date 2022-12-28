# Deploying a Jakarta EE application on Azure using IaaS
This demo shows how you can deploy a Jakarta EE application to Azure using Linux virtual machines. The following is how you run the demo.

## Setup
* You will need a GitHub account.
* You will need an Azure subscription. If you don't have one, you can get one for free for one year [here](https://azure.microsoft.com/en-us/free).

## Start Managed PostgreSQL on Azure
We will be using the fully managed PostgreSQL offering in Azure for this demo. If you have not set it up yet, please do so now. 

* Go to the [Azure portal](http://portal.azure.com).
* Select 'Create a resource'. In the search box, enter and select 'Azure Database for PostgreSQL'. Hit create. Select a single server. Hit create again.
* Create a new resource group named jakartaee-cafe-group-`<your suffix>` (the suffix could be your first name such as "reza"). Specify the Server name to be jakartaee-cafe-db-`<your suffix>` (the suffix could be your first name such as "reza"). Specify the login name to be postgres. Specify the password to be Secret123!. Create the resource. It will take a moment for the database to deploy and be ready for use.
* In the portal home, go to 'All resources'. Find and click on jakartaee-cafe-db-`<your suffix>`. Open the connection security panel. Enable access to Azure services, disable SSL connection enforcement and then hit Save.

Once you are done exploring the demo, you should delete the jakartaee-cafe-group-`<your suffix>` resource group. You can do this by going to the portal, going to resource groups, finding and clicking on jakartaee-cafe-group-`<your suffix>` and hitting delete. This is especially important if you are not using a free subscription! If you do keep these resources around (for example to begin your own prototype), you should in the least use your own passwords and make the corresponding changes in the demo code.

## Start the Application on a Virtual Machine
The next step is to get the application up and running on a virtual machine. Follow the steps below to do so.

* Clone this repository into your own GitHub account. Make sure to update the [standalone.xml](standalone.xml) file to replace occurrences of `reza` with `<your suffix>`.
* Go to the [Azure portal](http://portal.azure.com).
* Select 'Create a resource'. In the search box, enter and search for 'Ubuntu Server 20.04 LTS'. In the results, select 'Ubuntu Server 20.04 LTS' (this is an official offering from Canonical). Hit create.
* Enter the resource group as jakartaee-cafe-group-`<your suffix>`. Enter the virtual machine name as jakartaee-cafe-server-`<your suffix>` (the suffix could be your first name such as "reza"). Choose password based authentication instead of SSH. Enter wildfly as the username. Specify the password to be Secret12345!. For 'Select inbound ports' choose the HTTP (80), HTTPS (443) and SSH (22) ports to open. Hit next until you reach the networking settings. Ensure ports 22, 80 and 443 are still open. Create the resource.
* In the portal, go to 'All resources'. Find and click on jakartaee-cafe-server-`<your suffix>`. In the overview panel, find the public IP. Connect to the virtual machine by executing the following command.

	```
	ssh wildfly@[public IP]
	```
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
	wget https://download.jboss.org/wildfly/21.0.2.Final/wildfly-21.0.2.Final.zip
	```
* Install unzip by executing the following command:

	```
	sudo apt install unzip
	```	
* Unzip WildFy by executing the following command:

	```
	unzip wildfly-21.0.2.Final.zip
	```
* Download the application by executing the following command:

	```
	wget https://github.com/<Your GitHub account>/jakartaee-azure/archive/master.zip
	```
* Unzip the application by executing the following command:

	```
	unzip master.zip
	```
*  Change directories to where the application was extracted. Move to the jakartaee/jakartaee-cafe directory. Build the application by executing:

	```
	mvn install
	```
* Change directories back to home.
* Execute the following commands to install the JDBC driver, the standalone configuration and the application:
	```
	mkdir -p wildfly-21.0.2.Final/modules/org/postgresql/main
	cp jakartaee-azure-master/jakartaee/server/postgresql-42.2.19.jar wildfly-21.0.2.Final/modules/org/postgresql/main/
	cp jakartaee-azure-master/jakartaee/server/module.xml wildfly-21.0.2.Final/modules/org/postgresql/main/
	cp jakartaee-azure-master/iaas/standalone.xml wildfly-21.0.2.Final/standalone/configuration/
	cp jakartaee-azure-master/jakartaee/jakartaee-cafe/target/jakartaee-cafe.war wildfly-21.0.2.Final/standalone/deployments/
	```
* Change directories to wildfly-21.0.2.Final/bin. Run the following command to get root shell access:

	```
	sudo su
	```
* Execute the following command to start WildFly:
	```
	./standalone.sh
	```
* In the portal, go to 'All resources'. Find and click on jakartaee-cafe-server-`<your suffix>`. In the overview panel, find and copy the public IP address.
* Once the application starts, you can test the REST service at the URL: http://[your public IP]/jakartaee-cafe/rest/coffees or via the JSF client at http://[your public IP]/jakartaee-cafe/index.xhtml.
