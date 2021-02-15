FROM payara/server-full
COPY jakartaee-cafe/target/jakartaee-cafe.war $DEPLOY_DIR
COPY server/postgresql-42.2.18.jar /tmp
RUN echo 'add-library /tmp/postgresql-42.2.18.jar' > $POSTBOOT_COMMANDS
