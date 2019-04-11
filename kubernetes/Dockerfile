FROM jboss/wildfly

COPY postgresql-42.2.4.jar /opt/ibm/wlp/usr/shared/resources/
COPY server.xml /config/
ADD javaee-cafe.war /opt/jboss/wildfly/standalone/deployments/
