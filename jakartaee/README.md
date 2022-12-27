# Basic Jakarta EE CRUD Application
This is the basic Jakarta EE 8 application used throughout the Azure demos. It is a simple CRUD application. It uses Maven and Jakarta EE 8 (REST, Enterprise Beans, Context and Dependency Injection, Persistence, Faces, Bean Validation).

We use Eclipse but you can use any Maven capable IDE such as IntelliJ or Visual Studio Code. We use WildFly/JBoss EAP but you should be able to use any Jakarta EE 8 compatiple application server such as Open Liberty or Payara. We use PostgreSQL but you can use any relational database such as MySQL or SQL Server.

## Setup

- Install Java SE 8 or Java SE 11 (we used [Azul Zulu Java 11 LTS](https://www.azul.com/downloads/zulu-community/)).
- Install the Eclipse IDE for Enterprise Java Developers from [here](https://www.eclipse.org/downloads/packages/installer). 
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
* Go to Servers -> New -> Server. Install Red Hat JBoss Middleware -> JBoss AS, WildFly & EAP Server Tools. You may need to restart the IDE.
* After the JBoss adapters are done installing, go to the 'Servers' panel again, right click. Select New -> Server -> JBoss Community -> WildFly 21. Choose the defaults on the next screen and hit 'Next'. Choose to download and install a runtime. Choose WildFly 21.0.2. Click Finish.
* Find out where Eclipse has installed WildFly in your file system. In the Servers panel, open the WildFly instance. Click runtime environment. Note down the server home directory.
* Browse to where WildFly is installed. Create the path modules/org/postgresql/main.
* Browse to where you have this repository code in your file system. You will need to copy the module.xml and PostgreSQL driver to the newly created modules/org/postgresql/main path. Both of these files are located under jakartaee/server directory. Also from the jakartaee/server directory, copy the standalone.xml into standalone/configuration where WildFly is installed.
* Get the jakartaee-cafe application into the IDE. In order to do that, go to File -> Import -> Maven -> Existing Maven Projects. Then browse to where you have this repository code in your file system and select jakartaee/jakartaee-cafe. Accept the rest of the defaults and finish.
* Once the application loads, you should do a full Maven build by going to Right click the application -> Run As -> Maven install.
* It is now time to run the application. Go to Right click the application -> Run As -> Run on Server. Make sure to choose WildFly as the server going forward. Just accept the defaults and wait for the application to finish running.
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
