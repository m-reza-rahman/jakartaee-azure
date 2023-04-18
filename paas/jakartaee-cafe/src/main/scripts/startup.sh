# This file is executed when your app is started.
echo "Configuring JBoss"
$JBOSS_HOME/bin/jboss-cli.sh --connect <<EOF
module add --name=org.postgresql --resources=/home/site/libs/postgresql-jdbc.jar --module-xml=/home/site/scripts/postgresql-module.xml
/subsystem=datasources/jdbc-driver=postgresql:add(driver-name="postgresql",driver-module-name="org.postgresql",driver-class-name="org.postgresql.Driver",driver-xa-datasource-class-name="org.postgresql.xa.PGXADataSource")
data-source add --name="PostgresqlDS" --driver-name="postgresql" --jndi-name="java:/jdbc/JakartaEECafeDB" --connection-url="${POSTGRESQLCONNSTR_CONNECTION_URL}" --user-name="${POSTGRESQLCONNSTR_USERNAME}" --password="${POSTGRESQLCONNSTR_PASSWORD}" --enabled=true --use-java-context=true
reload --use-current-server-config=true
exit
EOF

