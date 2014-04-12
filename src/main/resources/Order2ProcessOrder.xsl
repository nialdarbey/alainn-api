<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:mes="http://www.alainn.com/SOA/message/1.0"
	xmlns:mod="http://www.alainn.com/SOA/model/1.0" version="2.0"
	exclude-result-prefixes="xs">
	<xsl:output method="xml"/>
	<xsl:param name="customer" />
	<xsl:template match="/">
		<mes:processOrder>
			<xsl:copy-of select="$customer" />
			<xsl:copy-of select="/mod:Order" />
		</mes:processOrder>
	</xsl:template>
</xsl:stylesheet>