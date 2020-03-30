# Deploying a Jakarta EE Application on Azure using PaaS
This demo shows how you can deploy a Jakarta EE application to Azure using a managed runtime. The following is how you run the demo.

*Note that Azure currently does not offer a managed Jakarta EE application server. This demo uses a managed Java SE service and Payara Micro. Payara Micro can easily run a Jakarta EE thin war as an executable jar, which is the technique we highlight here. Azure engineering is currently actively exporing partnering with the good folks at Payara to offer a managed Jakarta EE application server service on Azure via our marketplace. If a managed Jakarta EE application server offering on Azure is something that interests you, please email [Reza Rahman](mailto:reza.rahman@microsoft.com?subject=Managed%20Jakarta%20EE%20Application%20Server%20on%20Azure).*

## Setup
* You will need an Azure subscription. If you don't have one, you can get one for free for one year [here](https://azure.microsoft.com/en-us/free).

## Start Managed PostgreSQL on Azure
We will be using the fully managed PostgreSQL offering in Azure for this demo. If you have not set it up yet, please do so now. 

* Go to the [Azure portal](http://portal.azure.com).
* Select Create a resource -> Databases -> Azure Database for PostgreSQL. Select a single server.
* Specify the Server name to be jakartaee-cafe-db-`<your suffix>` (the suffix could be your first name such as "reza"). Create a new resource group named jakartaee-cafe-group-`<your suffix>` (the suffix could be your first name such as "reza"). Specify the login name to be postgres. Specify the password to be Secret123!. Hit 'Create'. It will take a moment for the database to deploy and be ready for use.
* In the portal, go to 'All resources'. Find and click on jakartaee-cafe-db-`<your suffix>`. Open the connection security panel. Enable access to Azure services, disable SSL connection enforcement and then hit Save.

Once you are done exploring the demo, you should delete the jakartaee-cafe-group-`<your suffix>` resource group. You can do this by going to the portal, going to resource groups, finding and clicking on jakartaee-cafe-group-`<your suffix>` and hitting delete. This is especially important if you are not using a free subscription! If you do keep these resources around (for example to begin your own prototype), you should in the least use your own passwords and make the corresponding changes in the demo code.

## Setup Managed Java SE for Running Payara Micro
* Go to the [Azure portal](http://portal.azure.com).
* Select Create a resource -> Web -> Web App.
* Enter jakartaee-cafe-web-`<your suffix>` (the suffix could be your first name such as "reza") as application name and select jakartaee-cafe-group-`<your suffix>` as the resource group. Choose Linux as the OS and Java 8 -> Java SE as the runtime. Hit create.
* In the portal, go to 'All resources'. Find and click on jakartaee-cafe-web-`<your suffix>`.
* Go to the Deployment Center. Select FTP -> Dashboard -> User Credentials (note that FTP is just one deployment option in App Service). Enter payara-`<your suffix>` as the username (the suffix could be your first name such as "reza"). Enter Secret12345! as the password. Click 'Save Credentials'.
* In the portal, go to 'All resources'. Find and click on jakartaee-cafe-web-`<your suffix>`. Go to Configuration -> General settings -> Startup Command. Specify 'java -jar /home/site/wwwroot/jakartaee-cafe-application.jar --port 80' as the startup command. Hit save.
* Go back to the Overview panel and hit restart.

## Install the Azure CLI
* In order to deploy the application, we will need to [install the Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest).
* Open a console and execute the following to log onto Azure.

	```
	az login
	```
## Start the Application on Managed Java SE with Payara Micro
The next step is to get the application up and running on managed Java SE with Payara Micro. Follow the steps below to do so.

* Start Eclipse.
* Get the jakartaee-cafe application in the PaaS directory into the IDE. In order to do that, go to File -> Import -> Maven -> Existing Maven Projects. Then browse to where you have this repository code in your file system and select paas/jakartaee-cafe. Accept the rest of the defaults and finish.
* Once the application loads, open the [pom.xml](jakartaee-cafe/pom.xml) and [web.xml](jakartaee-cafe/src/main/webapp/WEB-INF/web.xml) files and replace occurrences of `reza` with `<your suffix>`. You should do a full Maven build by going to Right click the application -> Run As -> Maven install.
* You should note the pom.xml. In particular, we have included the configuration for the Azure Maven plugin we are going to use to deploy the application to managed Java SE with Payara Micro:

```xml
<plugin>
    <groupId>com.microsoft.azure</groupId>
    <artifactId>azure-webapp-maven-plugin</artifactId>
    <version>1.5.4</version>
    <configuration>
        <appName>jakartaee-cafe-web-<your suffix></appName>
        <resourceGroup>jakartaee-cafe-group-<your suffix></resourceGroup>
        <linuxRuntime>jre8</linuxRuntime>
        <deploymentType>ftp</deploymentType>
        <resources>
            <resource>
                <directory>${project.basedir}/target</directory>
                <targetPath>/</targetPath>
                <includes>
                    <include>jakartaee-cafe-application.jar</include>
                </includes>
            </resource>
        </resources>
    </configuration>	
</plugin>
```

* It is now time to deploy and run the application on Azure. Right click the application -> Run As -> 'Maven build...'. Enter the name as 'Deploy to Azure App Service'. Enter the goals as 'azure-webapp:deploy'. Hit run.
* Keep an eye on the console output. You will see when the application is deployed. The application will be available at https://jakartaee-cafe-web-your-suffix.azurewebsites.net. Note that it may take some time for the application to deploy after the console notification (it may be up to thirty minutes before all the infrastructure finishes getting allocated).
* Once the application starts, you can test the REST service at the URL: https://jakartaee-cafe-web-your-suffix.azurewebsites.net/rest/coffees or via the JSF client at https://jakartaee-cafe-web-your-suffix.azurewebsites.net/index.xhtml.
