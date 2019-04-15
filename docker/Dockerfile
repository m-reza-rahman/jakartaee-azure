FROM jboss/wildfly

RUN mkdir -p /opt/jboss/wildfly/modules/org/postgresql/main
COPY postgresql-42.2.4.jar /opt/jboss/wildfly/modules/org/postgresql/main/
COPY module.xml /opt/jboss/wildfly/modules/org/postgresql/main/
COPY standalone.xml /opt/jboss/wildfly/standalone/configuration/
ADD javaee-cafe.war /opt/jboss/wildfly/standalone/deployments/
