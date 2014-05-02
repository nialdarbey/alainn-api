<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0">
	<xsl:output method="text" />
	<xsl:template match="/hello-world">
		{ "html" : { "head" : "text/html" }, { "body" : { "h1" : "
		<xsl:value-of select="greeting" />
		"},
		<xsl:apply-templates select="greeter" />
		}
	</xsl:template>
	<xsl:template match="greeter">
		{ "from" : "
		<xsl:value-of select="." />
		"
	</xsl:template>
</xsl:stylesheet>