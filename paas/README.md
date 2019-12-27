# Deploying a Java EE Application on Azure using PaaS
This demo shows how you can deploy a Java EE application to Azure using managed WildFly. The following is how you run the demo.

*Note that the Azure managed WildFly offering is currently under public preview. You are encouraged to try this service out and provide feedback. The service will be made GA (generally available) in the near future.*

## Setup
* You will need an Azure subscription. If you don't have one, you can get one for free for one year [here](https://azure.microsoft.com/en-us/free).

## Start Managed PostgreSQL on Azure
We will be using the fully managed PostgreSQL offering in Azure for this demo. If you have not set it up yet, please do so now. 

* Go to the [Azure portal](http://portal.azure.com).
* Select Create a resource -> Databases -> Azure Database for PostgreSQL. Select a single server.
* Specify the Server name to be javaee-cafe-db-`<your suffix>` (the suffix could be your first name such as "reza"). Create a new resource group named javaee-cafe-group-`<your suffix>` (the suffix could be your first name such as "reza"). Specify the login name to be postgres. Specify the password to be Secret123!. Hit 'Create'. It will take a moment for the database to deploy and be ready for use.
* In the portal, go to 'All resources'. Find and click on javaee-cafe-db-`<your suffix>`. Open the connection security panel. Enable access to Azure services, disable SSL connection enforcement and then hit Save.

Once you are done exploring the demo, you should delete the javaee-cafe-group-`<your suffix>` resource group. You can do this by going to the portal, going to resource groups, finding and clicking on javaee-cafe-group-`<your suffix>` and hitting delete. This is especially important if you are not using a free subscription! If you do keep these resources around (for example to begin your own prototype), you should in the least use your own passwords and make the corresponding changes in the demo code.

## Setup Managed WildFly
* Go to the [Azure portal](http://portal.azure.com).
* Select Create a resource -> Web -> Web App.
* Enter javaee-cafe-web-`<your suffix>` (the suffix could be your first name such as "reza") as application name and select javaee-cafe-group-`<your suffix>` as the resource group. Choose Linux as the OS and WildFly as the runtime. Hit create.
* In the portal, go to 'All resources'. Find and click on javaee-cafe-web-`<your suffix>`.
* Go to the Deployment Center. Select FTP -> Dashboard -> User Credentials (note that FTP is just one deployment option in App Service). Enter wildfly as the username. Enter Secret12345! as the password. Click 'Save Credentials'.
* Go to the Overview panel. Note down the FTP access information. Connect with your favorite FTP client.
* Go to where this application is on your local machine. Got to the paas directory. Open the [jboss_cli_commands.cli](jboss_cli_commands.cli) in a text editor. Replace occurrences of `reza` with `<your suffix>`. Make sure to switch your FTP client to *binary mode*, if that is not already the default.  Via FTP, upload the JDBC driver to the /site/deployments/tools/ directory. Then upload the jboss_cli_commands.cli, postgresql-module.xml and startup.sh files to the /site/deployments/tools/ directory.
* In the portal, go to 'All resources'. Find and click on javaee-cafe-web-`<your suffix>`. Go to Configuration -> General settings -> Startup Command. Specify /home/site/deployments/tools/startup.sh as the startup command. Hit save.
* Go back to the Overview panel and hit restart.

## Install the Azure CLI
* In order to deploy the application, we will need to [install the Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest).
* Open a console and execute the following to log onto Azure.

	```
	az login
	```
## Start the Application on Managed WildFly
The next step is to get the application up and running on managed WildFly. Follow the steps below to do so.

* Start Eclipse.
* Get the javaee-cafe application in the PaaS directory into the IDE. In order to do that, go to File -> Import -> Maven -> Existing Maven Projects. Then browse to where you have this repository code in your file system and select paas/javaee-cafe. Accept the rest of the defaults and finish.
* Once the application loads, open the [pom.xml](javaee-cafe/pom.xml) file and replace occurrences of `reza` with `<your suffix>`. You should do a full Maven build by going to Right click the application -> Run As -> Maven install.
* You should note the pom.xml. In particular, we have included the configuration for the Azure Maven plugin we are going to use to deploy the application to managed WildFly:

```xml
<plugin>
    <groupId>com.microsoft.azure</groupId>
    <artifactId>azure-webapp-maven-plugin</artifactId>
    <version>1.5.4</version>
    <configuration>
        <appName>javaee-cafe-web-<your suffix></appName>
        <resourceGroup>javaee-cafe-group-<your suffix></resourceGroup>
        <linuxRuntime>wildfly 14-jre8</linuxRuntime>
    </configuration>
</plugin>
```

* It is now time to deploy and run the application on Azure. Right click the application -> Run As -> 'Maven build...'. Enter the name as 'Deploy to Azure'. Enter the goals as 'azure-webapp:deploy'. Hit run.
* Keep an eye on the console output. You will see when the application is deployed. The application will be available at https://javaee-cafe-web-your-suffix.azurewebsites.net.
* Once the application starts, you can test the REST service at the URL: https://javaee-cafe-web-your-suffix.azurewebsites.net/rest/coffees or via the JSF client at https://javaee-cafe-web-your-suffix.azurewebsites.net/index.xhtml.
