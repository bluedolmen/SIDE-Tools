@echo off

rem $Id$

if not "%JAVA_HOME%" == "" goto gotJavaHome
set JAVA_HOME=C:\Program Files\Java\jdk1.6.0_14

:gotJavaHome
set SIDELABS_HOME=.

:gotExistHome
set ANT_HOME=%SIDELABS_HOME%\tools\ant
set _LIBJARS=%CLASSPATH%;%ANT_HOME%\lib\ant-launcher.jar;%ANT_HOME%\lib\junit-4.5.jar;%JAVA_HOME%\lib\tools.jar

set JAVA_ENDORSED_DIRS=%SIDELABS_HOME%\lib\endorsed
set JAVA_OPTS=-Xms128m -Xmx512m -Djava.endorsed.dirs="%JAVA_ENDORSED_DIRS%" -Dant.home="%ANT_HOME%"

echo SIDE-Labs Build
echo -------------------
echo SIDELABS_HOME=%SIDELABS_HOME%
echo JAVA_HOME=%JAVA_HOME%
echo _LIBJARS=%_LIBJARS%

echo Starting Ant...
echo

"%JAVA_HOME%\bin\java" %JAVA_OPTS% -classpath "%_LIBJARS%" org.apache.tools.ant.launch.Launcher %1 %2 %3 %4 %5 %6 %7 %8 %9
