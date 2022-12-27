# Java/Jakarta EE on Azure
This repository shows the key ways of deploying a Java/Jakarta EE application to Azure. The repository hosts the demos for [this](abstract.md) talk or [this](lab-abstract.md) lab ([here](lab-instructions.md) are the instructions for the lab). [Here](https://www.youtube.com/watch?v=FHCgC64Rdbk) is a video of the talk.

The basic Jakarta EE application used throughout is in the [jakartaee](/jakartaee) folder. You should explore the setup in that folder first.

Each of the parts of this repository can be run independently, which means you can go directly to the parts that interest you the most. The following is just one logical sequence.

The key Azure pathways for Jakarta EE applications include:
* Deploying a Jakarta EE application on Azure using IaaS. The [iaas](/iaas) folder shows how this is done.
* Deploying a Jakarta EE application on Azure using PaaS. The [paas](/paas) folder shows how this is done.
* Deploying a Jakarta EE application on Azure using Docker. The [docker](/docker) folder shows how this is done.
* Deploying a Jakarta EE application on Azure using Docker and Kubernetes. The [kubernetes](/kubernetes) folder shows how this is done.

The demos use Jakarta EE 8, WildFly/JBoss EAP and PostgreSQL.
