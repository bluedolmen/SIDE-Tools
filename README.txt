Quick Start
-----------

In tomcat/conf/Catalina.xml

<Context allowSymLinks="true">

# to deploy Alfresco modules
./build.sh deploy-alfresco-tmp

# to update workflow definition and generate the corresponding java class with
# a method for each transition and event type
./build.sh improve-workflows \
-Dworkflow.action.package="org.sidelabs.is.operational.workflow" \
-DuseProcessDefinitionName="true" \
-DreplaceActions="true" \
-Ddynamic="true" \
-DdynamicUrl="http://localhost:8880/share/side-labs/workflow" \
-DcopyScript="false"

# to deploy Alfresco Share modules
./build.sh deploy-share-tmp

Then correct the service-context files with the resource bundle problem (see BUGS.txt file
in this directory)

ALFRESCO_SHARE_ROOT=/Users/bluexml/opt/local/apache/apache-tomcat-7.0.2
ALFRESCO_ROOT=/Users/bluexml/opt/local/alfresco/alfresco-community-3.4d

ln -s \
	/Users/bluexml/opt/local/workspaces/W1/SIDE-deployer/_build/alfresco_3.x/tmp \
	$SIDELABS_ROOT

cd $ALFRESCO_ROOT/tomcat/shared/classes/alfresco/extension
ln -s \
	$SIDELABS_ROOT/SIDE-Run-Alfresco/conf/side-labs-* \
	.

cd $ALFRESCO_SHARE_ROOT/tomcat/shared/classes
ln -s \
	$ALFRESCO_SHARE_ROOT/SIDE-Run-Alfresco/conf/side-labs-share \
	.

cd $ALFRESCO_ROOT/tomcat/webapps/alfresco/WEB-INF/lib
ln -s \
	$SIDELABS_ROOT/SIDE-Run-Alfresco/lib/*
	.

cd /Users/bluexml/opt/local/alfresco/alfresco/alfresco-community-3.4d/tomcat/shared/classes
ln -s \
	$SIDELABS_ROOT \
	side-labs

ln -s \
	$SIDELABS_SHARE_ROOT \
	side-labs-share

What is SIDE ?
-------------

SIDE stands for Sustainable IDE. SIDE is a set of graphical
tools to help developers to build modern EIM applications.
SIDE, which implements the Model Driven Software Development
(MDSD) paradigm, enables you to build sustainable software
that will evolve with your business and infrastructure
requirements. Sustainable software, requirements and
technological evolutions are generally in opposite but SIDE
provides a general solution to align them.

What does "sustainable software" mean ?
--------------------------------------

Sustainable software is software you can extend easily,
from a functional or technological point of view. On one
hand, this means that when a user has a new requirement,
it's easy for any developper to add it, even if the
original author is not there anymore. On another hand,
if you want to change the underlying technologies, you
don't need to rewrite your existing application from
scratch.

SIDE enables you to develop such agile solutions.

What typical use cases does SIDE cover ?
---------------------------------------

SIDE focuses presently on Alfresco related projects which
combine contents and highly structured data, as ECM, EIM,
Internet/Intranet, Paperless.

What are SIDE key features ?
---------------------------

SIDE is based on a Model Driven Architecture (MDA)
paradigm which provides productivity, agility, quality and
reliability.

More information at http://www.side-labs.org
