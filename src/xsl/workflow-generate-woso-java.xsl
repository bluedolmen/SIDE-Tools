<?xml version="1.0" encoding="UTF-8"?>
<!--
	This file is part of SIDE-Labs.

	Copyright (C) 2009  BlueXML (http://www.bluexml.com)

    SIDE-Labs is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    SIDE-Labs is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with SIDE-Labs.  If not, see <http://www.gnu.org/licenses/>.
-->
<xsl:stylesheet
	version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="./workflow-template-java.xsl"/>
	<xsl:import href="./util.xsl"/>
	
	<xsl:output method="text" encoding="UTF-8" indent="yes"/>
	
	<xsl:param name="package" select="'org.sidelabs.is.operational.workflow'"/>
	<xsl:param name="class" select="'Yamma'"/>

	<xsl:param name="copy-script" select="'true'"/>
	<xsl:param name="dynamic" select="'true'"/>
	<xsl:param name="dynamic-url" select="'http://localhost:8880/share/side/workflow'"/>

	<!--
		Generates a java file with a method for each transition.
		This method only contains a log which can be enabled through log4j.properties
	-->
	<xsl:template match="/">
		<xsl:call-template name="create-java-class">
			<xsl:with-param name="package" select="$package"/>
			<xsl:with-param name="class" select="$class"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template match="script">
		<xsl:if test="$copy-script = 'true'">
			<xsl:copy-of select="."/>
		</xsl:if>
	</xsl:template>
		
	<xsl:template match="transition">
		<xsl:variable name="name">
			<xsl:call-template name="minimalize">
				<xsl:with-param name="name" select="@name"/>
			</xsl:call-template>
		</xsl:variable>

		<xsl:call-template name="create-method">
			<xsl:with-param name="method" select="$name"/>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template match="event">
		<xsl:variable name="name">
			<xsl:call-template name="capitalize">
				<xsl:with-param name="name" select="../@name"/>
			</xsl:call-template>
		</xsl:variable>
	
		<xsl:choose>
			<xsl:when test="@type = 'task-create'">
				<xsl:call-template name="create-method">
					<xsl:with-param name="method" select="concat('onCreatingTask',$name)"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="@type = 'task-start'">
				<xsl:call-template name="create-method">
					<xsl:with-param name="method" select="concat('onStartingTask',$name)"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="@type = 'task-assign'">
				<xsl:call-template name="create-method">
					<xsl:with-param name="method" select="concat('onAssigningTask',$name)"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="@type = 'task-end'">
				<xsl:call-template name="create-method">
					<xsl:with-param name="method" select="concat('onEndingTask',$name)"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="@type = 'node-enter'">
				<xsl:call-template name="create-method">
					<xsl:with-param name="method" select="concat('onEnteringNode',$name)"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="@type = 'node-leave'">
				<xsl:call-template name="create-method">
					<xsl:with-param name="method" select="concat('onLeavingNode',$name)"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="before-signal">
				<xsl:call-template name="create-method">
					<xsl:with-param name="method" select="concat('onSignalingBefore',$name)"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="after-signal">
				<xsl:call-template name="create-method">
					<xsl:with-param name="method" select="concat('onSignalingAfter',$name)"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="superstate-enter">
				<xsl:call-template name="create-method">
					<xsl:with-param name="method" select="concat('onEnteringSuperstate',$name)"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="superstate-leave">
				<xsl:call-template name="create-method">
					<xsl:with-param name="method" select="concat('onLeavingSuperstate',$name)"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="transition">
				<xsl:call-template name="create-method">
					<xsl:with-param name="method" select="concat('onTransition',$name)"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="timer">
				<xsl:call-template name="create-method">
					<xsl:with-param name="method" select="concat('onTimer',$name)"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="subprocess-created">
				<xsl:call-template name="create-method">
					<xsl:with-param name="method" select="concat('onCreatedSubprocess',$name)"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="subprocess-end">
				<xsl:call-template name="create-method">
					<xsl:with-param name="method" select="concat('onEndingSubprocess',$name)"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="process-start">
				<xsl:call-template name="create-method">
					<xsl:with-param name="method" select="concat('onStartingProcess',$name)"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="process-end">
				<xsl:call-template name="create-method">
					<xsl:with-param name="method" select="concat('onEndingProcess',$name)"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				// @Fix I don't know this node type
				<xsl:call-template name="create-method">
					<xsl:with-param name="method" select="@type"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>   

	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>	

</xsl:stylesheet>