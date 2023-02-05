FROM jboss/wildfly:21.0.2.Final

RUN mkdir -p /opt/jboss/wildfly/modules/org/postgresql/main
COPY postgresql-42.5.3.jar /opt/jboss/wildfly/modules/org/postgresql/main/
COPY module.xml /opt/jboss/wildfly/modules/org/postgresql/main/
COPY standalone.xml /opt/jboss/wildfly/standalone/configuration/
ADD jakartaee-cafe.war /opt/jboss/wildfly/standalone/deployments/
