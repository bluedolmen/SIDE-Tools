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

	<xsl:output method="xml" encoding="UTF-8" indent="yes"
			doctype-system="http://www.springframework.org/dtd/spring-beans-2.0.dtd"
    		doctype-public="-//SPRING//DTD BEAN//EN"/>

	<xsl:variable name="lowercase" select="'abcdefghijklmnopqrstuvwxyz'" />
	<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />

	<xsl:template name="capitalize">
		<xsl:param name="name"/>

		<xsl:value-of select="concat(
			translate(substring($name,1,1),$lowercase,$uppercase),
			substring($name,2,string-length($name))
		)"/>
	</xsl:template>

	<xsl:template name="minimalize">
		<xsl:param name="name"/>

		<xsl:value-of select="concat(
			translate(substring($name,1,1),$uppercase,$lowercase),
			substring($name,2,string-length($name))
		)"/>
	</xsl:template>
	
	<xsl:template name="createComment">
		<xsl:param name="comment" select="''"/>

		<xsl:comment><xsl:value-of select="$comment"/></xsl:comment>
		<xsl:text>
		</xsl:text>

	</xsl:template>
</xsl:stylesheet>