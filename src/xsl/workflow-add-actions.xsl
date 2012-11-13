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
	version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:spring="http://www.springframework.org/schema/beans"
	exclude-result-prefixes="spring">

	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	
	<xsl:param name="package" select="'org.sidelabs.is.operational'"/>
	<xsl:param name="class" select="'FileActionHandler'"/>
	<xsl:param name="use-PDN" select="'true'"/>
	<xsl:param name="replace-actions" select="'true'"/>
	<xsl:param name="copy-script" select="'false'"/>
	
	<xsl:variable name="mainClass">
			<xsl:choose>
				<xsl:when test="$use-PDN = 'true'">
					<xsl:value-of select="substring-after(/process-definition/@name, ':')"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$class"/>
				</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<!--
		Add an action to transition or event if none are present
		Recopies script if present
	-->
	
	<xsl:template match="transition|event">
		<xsl:element name="{name()}">
			<xsl:copy-of select="@*"/>
			<xsl:choose>
				<xsl:when test="not(action)
								or (action and $replace-actions = 'true')">
					<action class="{$package}.{$mainClass}">
						<xsl:if test="$copy-script = 'true'">
							<xsl:apply-templates select=".//script"/>
						</xsl:if>
					</action>
				</xsl:when>
				<xsl:otherwise>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:apply-templates select="*[not(name() = 'action')]"/>
		</xsl:element>
	</xsl:template>   

	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>	
	
</xsl:stylesheet>