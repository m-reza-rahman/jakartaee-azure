# Basic Jakarta EE CRUD Application
This is the basic Jakarta EE 8 application used throughout the Azure demos. It is a simple CRUD application. It uses Maven and Jakarta EE 8 (Jakarta REST, Jakarta Enterprise Beans, Jakarta Context and Dependency Injection, Jakarta Persistence, Jakarta Faces, Jakarta Bean Validation).

We use Eclipse but you can use any Maven capable IDE such as NetBeans, IntelliJ or Visual Studio Code. We use Payara but you should be able to use any Jakarta EE 8 compatiple application server such as Open Liberty or WildFly. We use Postgres but you can use any relational database such as MySQL or SQL Server.

## Setup

- Install JDK 8 (we used [Azul Zulu Java 8 LTS](https://www.azul.com/downloads/zulu-community/)).
- Download the latest version of Payara from [here](https://www.payara.fish/products/downloads/). Make sure to download Payara Server Full. Unzip the download somewhere in your file system.
- Install the Eclipse IDE for Enterprise Java Developers from [here](https://www.eclipse.org/downloads/packages/). 
- Install Docker for your OS.
- Download this repository somewhere in your file system (easiest way might be to download as a zip and extract).

## Database Creation
The first step to getting the application running is getting the database up. The simplest way to actually do this is through Docker (we will be using Docker more extensively during our Kubernetes demo). Please follow the instructions below to get the database running.
* Make sure Docker is running. Open a console.
* Enter the following command and wait for the database to come up fully.
```
docker run -it --rm -e POSTGRES_HOST_AUTH_METHOD=trust --name jakartaee-cafe-db -v pgdata:/var/lib/postgresql/data -p 5432:5432 postgres
```
* The database is now ready. To stop it, simply press Control-C.

## Running the Application
The next step is to get the application up and running. Follow the steps below to do so.
* Start Eclipse.
* Go to Help -> Eclipse Marketplace. Search for 'Payara' and install Payara Tools. You may need to restart the IDE.
* After the Payara adapters are done installing, go to the 'Servers' panel again, right click. Select New -> Server -> Payara -> Payara. Choose the defaults on the next screen and hit 'Next'. Select the location where you have Payara installed and click through the rest of the defaults to get Payara setup in Eclipse.
* Go to the 'Servers' panel, right click on the newly registered Payara instance and select Start.
* Open a command line. Change directories to where you have Payara installed. Change directories into /bin. 
Execute the following command.


	```
	asadmin[.bat] add-library [path to where repository is downloaded on your machine]/jakartaee/server/postgresql-42.2.4.jar
	```
* Get the jakartaee-cafe application into the IDE. In order to do that, go to File -> Import -> Maven -> Existing Maven Projects. Then browse to where you have this repository code in your file system and select jakartaee/jakartaee-cafe. Accept the rest of the defaults and finish.
* Once the application loads, you should do a full Maven build by going to Right click the application -> Run As -> Maven install.
* It is now time to run the application. Go to Right click the application -> Run As -> Run on Server. Make sure to choose Payara as the server going forward. Just accept the defaults and wait for the application to finish running.
* Once the application runs, Eclise will open it up in a browser. The application is available at [http://localhost:8080/jakartaee-cafe](http://localhost:8080/jakartaee-cafe).

## Content

The application is composed of:

- **A RESTFul service*:** protocol://hostname:port/jakartaee-cafe/rest/coffees

	- **_GET by Id_**: protocol://hostname:port/jakartaee-cafe/rest/coffees/{id} 
	- **_GET all_**: protocol://hostname:port/jakartaee-cafe/rest/coffees
	- **_POST_** to add a new element at: protocol://hostname:port/jakartaee-cafe/rest/coffees
	- **_DELETE_** to delete an element at: protocol://hostname:port/jakartaee-cafe/rest/coffees/{id}

- **A JSF Client:** protocol://hostname:port/jakartaee-cafe/index.xhtml

Feel free to take a minute to explore the application.
