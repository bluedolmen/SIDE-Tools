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

	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>

	<xsl:param name="package" select="'org.sidelabs.is.operational'"/>
	<xsl:param name="class" select="'FileActionHandler'"/>

	<!--
		Add an action to transition or event if none are present
		Recopies script if present
	-->
	<xsl:template name="create-java-class"><xsl:param name="package"/><xsl:param name="class"/>
package <xsl:value-of select="$package"/>;

import org.sidelabs.workflow.SIDEActionHandler;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import org.sidelabs.workflow.SIDEActionHandler;
import org.sidelabs.workflow.Util;

import org.dom4j.Element;
import org.jbpm.graph.exe.ExecutionContext;

public class <xsl:value-of select="$class"/> extends SIDEActionHandler {

	private static final long serialVersionUID = 1L;
	private static Log logger = LogFactory.getLog(<xsl:value-of select="$class"/>.class);

	public String scriptsBaseUrl = null;

	public String getScriptsBaseUrl() {
		return this.scriptsBaseUrl;
	}

	public void setScriptsBaseUrl(String url) {
		this.scriptsBaseUrl = url;
	}

    public void executeAction(final ExecutionContext ec) {
    	boolean transition = true;
    	try {
    		super.executeTransition(this.getClass(), ec.getTransition().getName());
    		logger.debug("Transition: " + ec.getTransition().getName());
    	} catch (Exception ex) {
    		transition = false;
    		logger.debug("It is not a transition");
    	}

    	if (! transition) {
	    	try {
	    		super.executeEvent(this.getClass(), ec.getEvent().getEventType(), ec.getNode().getName());
	    		logger.debug("Event: " + ec.getNode().getName());
	    		logger.debug("Event Type: " + ec.getEvent().getEventType());
	    	} catch (Exception ex) {
	    		logger.debug("It is not an event");
	    	}
    	}
	}

	/**
	 * Transitions
	 */
	<xsl:apply-templates select=".//transition">
		<xsl:sort select="@name"/>
	</xsl:apply-templates>

	/**
	 * Events
	 */
	<xsl:apply-templates select=".//event">
		<xsl:sort select="@name"/>
	</xsl:apply-templates>

}
	</xsl:template>

	<xsl:template name="create-method">
		<xsl:param name="method"/>
		/**
		  * @param none
		  *
		  * @return void
		  **/
		public void <xsl:value-of select="$method"/>() {
			logger.debug("Processing: <xsl:value-of select="$method"/>");
			<xsl:if test="$dynamic = 'true'">
			Element newScript = Util.getScript(getScriptsBaseUrl() + "/<xsl:value-of select="$method"/>" + ".js");
			this.setScript(newScript);
			</xsl:if>
		}

	</xsl:template>

</xsl:stylesheet>