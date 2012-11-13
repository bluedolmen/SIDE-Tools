#!/bin/bash
# $Id$

if [ -z "$JAVA_HOME" ]; then
    JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home"
fi

if [ ! -d "$JAVA_HOME" ]; then
    JAVA_HOME="C:\Program Files\Java\jre6"
fi

# will be set by the installer
if [ -z "$SIDELABS_HOME" ]; then
	SIDELABS_HOME=.
fi

ANT_HOME="$SIDELABS_HOME/tools/ant"

LOCALCLASSPATH=$CLASSPATH:$ANT_HOME/lib/ant-launcher.jar:$ANT_HOME/lib/junit-4.5.jar
LOCALCLASSPATH=$LOCALCLASSPATH:$ANT_HOME/ext/jakarta-regexp-1.5.jar:$ANT_HOME/ext/log4j-1.2.14.jar

JAVA_ENDORSED_DIRS="$SIDELABS_HOME"/lib/endorsed

JAVA_OPTS="-Dant.home=$ANT_HOME -Djava.endorsed.dirs=$JAVA_ENDORSED_DIRS "

echo Starting Ant...
echo SIDELABS_HOME = $SIDELABS_HOME
echo JAVA_HOME = $JAVA_HOME
echo LOCALCLASSPATH = $LOCALCLASSPATH

$JAVA_HOME/bin/java -Xms512m -Xmx2048m $JAVA_OPTS -classpath $LOCALCLASSPATH org.apache.tools.ant.launch.Launcher $*
