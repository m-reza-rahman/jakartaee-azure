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
* Go to where this application is on your local machine. Got to the paas directory. Via FTP, upload the JDBC driver to the /home/site/deployments/tools/ directory *in binary mode*. The upload the jboss_cli_commands.cli and postgresql-module.xml files *in text mode* to the /home/site/deployments/tools/ directory. Finally, upload the startup.sh file *in text mode* to the /home directory.
* Go back to the Overview panel for javaee-cafe and hit restart.

https://javaee-cafe.azurewebsites.net

## Start the Application on Managed WildFly
The next step is to get the application up and running on managed WildFly. Follow the steps below to do so.

* Get the javaee-cafe application in the PaaS directory into the IDE. In order to do that, go to File -> Import -> Maven -> Existing Maven Projects. Then browse to where you have this repository code in your file system and select paas/javaee-cafe. Accept the rest of the defaults and finish.
* Once the application loads, you should do a full Maven build by going to Right click the application -> Run As -> Maven install.
* You should note the pom.xml. In particular, we have included the configuration for the Azure Maven plugin we are going to use to deploy the application to managed WildFly:

```xml
<plugin>
    <groupId>com.microsoft.azure</groupId>
    <artifactId>azure-webapp-maven-plugin</artifactId>
    <version>1.5.4</version>
    <configuration>
        <appName>javaee-cafe</appName>
        <resourceGroup>javaee-cafe-group</resourceGroup>
        <linuxRuntime>wildfly 14-jre8</linuxRuntime>
    </configuration>
</plugin>
```

* It is now time to deploy and run the application on Azure. Right click the application -> Run As -> 'Maven build...'. Enter the name as 'Deploy to Azure'. Enter the goals as 'azure-webapp:deploy'. Hit run.

Make sure to choose WildFly as the server going forward. Just accept the defaults and wait for the application to finish running.
* Once the application runs, Eclise will open it up in a browser. The application is available at [http://localhost/javaee-cafe](http://localhost/javaee-cafe).

* Once the application starts, you can test the REST service at the URL: http://[your public IP]/javaee-cafe/rest/coffees or via the JSF client at http://[your public IP]/javaee-cafe/index.xhtml.
