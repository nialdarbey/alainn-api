<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0" xmlns:mes="http://www.alainn.com/SOA/message/1.0"
	xmlns:mod="http://www.alainn.com/SOA/model/1.0">

	<xsl:output method="text" version="1.0" encoding="UTF-8"
		indent="no" media-type="text/plain" />
		
	<xsl:param name="next" />
	<xsl:param name="prev" />
	<xsl:param name="baseUrl" />
	<xsl:param name="self" />
	
	<xsl:template match="/">
		{
			"links" : [
					{
						"href" : "<xsl:value-of select="$next"/>",
						"rel" : "next"
					},
					{
						"href" : "<xsl:value-of select="$prev"/>",
						"rel" : "prev"
					},
					{
						"href" : "<xsl:value-of select="$baseUrl"/>/<xsl:value-of select="$self"/>",
						"rel" : "self"
					}
			],
			"collection" : {
				"size" : <xsl:value-of select="/mes:getItemsResponse/mes:PageInfo/pageSize" />,
				"items" : [
		<xsl:for-each select="/mes:getItemsResponse/mod:Item">
					{
						"id": "<xsl:value-of select="id" />",
						"type":"<xsl:value-of select="type" />",
						"name":"<xsl:value-of select="name" />",
						"summary":"<xsl:value-of select="summary" />",
						"brand":"<xsl:value-of select="brand" />",
						"links" : [
							{
								"href" : "<xsl:value-of select="$baseUrl"/>/items/<xsl:value-of select="id" />",
								"rel" : "self"
							}<xsl:if test="images/image">,</xsl:if>
			<xsl:for-each select="images/image">
							{
								"href" : "<xsl:value-of select="." />",
								"rel" : "<xsl:value-of select="@type" />"
							}<xsl:if test="./following-sibling::images/image">,</xsl:if>
			</xsl:for-each>
						]
					}<xsl:if test="./following-sibling::mod:Item">,</xsl:if>
		</xsl:for-each>
				]
			}
		}
	</xsl:template>
</xsl:stylesheet>