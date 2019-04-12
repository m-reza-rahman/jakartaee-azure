# This file is executed when your app is started. In the portal, set the "Startup Script" field 
# as the location of this file on the App Service instance (/home/site/deployments/tools/startup_script.sh).
/opt/jboss/wildfly/bin/jboss-cli.sh -c --file=/home/site/deployments/tools/jboss_cli_commands.cli