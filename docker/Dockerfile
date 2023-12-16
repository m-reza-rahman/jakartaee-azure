FROM quay.io/wildfly/wildfly:26.1.3.Final-jdk17

RUN mkdir -p /opt/jboss/wildfly/modules/org/postgresql/main
COPY postgresql-42.7.1.jar /opt/jboss/wildfly/modules/org/postgresql/main/
COPY module.xml /opt/jboss/wildfly/modules/org/postgresql/main/
COPY standalone.xml /opt/jboss/wildfly/standalone/configuration/
ADD jakartaee-cafe.war /opt/jboss/wildfly/standalone/deployments/
