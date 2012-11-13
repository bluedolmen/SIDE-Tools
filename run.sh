#!/bin/sh

# This script aims at swapping from one project to another
# An ant script should be more portable and finer to choose the 
# right action

# To update specific/generated configuration from a generation fragment.
# Takes only a few seconds
# sh build.sh \
# -Dside.build.dir=build-mail-manage-workflow
# -Dside.application.dist.dir=/Users/bluexml/opt/local/workspaces/W1/YaMma/_build-mail-manage-workflow
# deploy-alfresco-module deploy-share-module

PROJECT_NAME=$1
WORKSPACE_DIR=/Users/bluexml/opt/local/workspaces/W1
PROJECT_DIR=$WORKSPACE_DIR/$1

ALFRESCO=/Users/bluexml/opt/local/alfresco/alfresco-community-3.4d
SHARE=/Users/bluexml/opt/local/apache-tomcat/apache-tomcat-7.0.2

#
echo Deploying $1 project from $PROJECT_DIR directory
cd $PROJECT_DIR/tools/SIDE-deployer
sh build.sh deploy-alfresco-tmp deploy-share-tmp finalize

echo Configuring Alfresco
cd $ALFRESCO/tomcat/conf
cp catalina.properties.tpl catalina.properties
replace @WORKSPACE_DIR@ $WORKSPACE_DIR @PROJECT_NAME@ $PROJECT_NAME < catalina.properties.tpl > catalina.properties
cd $ALFRESCO/tomcat/webapps/alfresco/WEB-INF/classes
rm SIDE-Run-Alfresco
ln -s $PROJECT_DIR/_build/alfresco_3.4d/run/SIDE-Run-Alfresco .

echo Starting Alfresco
cd $ALFRESCO
./alfresco.sh stop tomcat
./alfresco.sh start tomcat

echo Configuring Share
cd $SHARE/conf
cp catalina.properties.tpl catalina.properties
replace @WORKSPACE_DIR@ $WORKSPACE_DIR @PROJECT_NAME@ $1 < catalina.properties.tpl > catalina.properties
cd $SHARE/webapps/share/WEB-INF/classes
rm SIDE-Run-AlfrescoShare
ln -s $PROJECT_DIR/_build/share_3.4d/run/SIDE-Run-AlfrescoShare .

cd $SHARE
./bin/shutdown.sh
sleep 10
./bin/startup.sh
