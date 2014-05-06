<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0" xmlns:mes="http://www.alainn.com/SOA/message/1.0"
	xmlns:mod="http://www.alainn.com/SOA/model/1.0">

	<xsl:output method="text" version="1.0" encoding="UTF-8"
		indent="no" media-type="text/plain" />
		
	<xsl:param name="baseUrl" />
	<xsl:param name="self" />

	<xsl:template match="/mes:getItemResponse">
		<xsl:variable name="itemId" select="mod:Item/id" />
		{
			"links" : [
					{
						"href" : "<xsl:value-of select="$baseUrl"/>/<xsl:value-of select="$self"/>",
						"rel" : "self"
					}
			],
			"id" : "<xsl:value-of select="mod:Item/id" />",
			"type" : "<xsl:value-of select="mod:Item/type" />",
			"name" : "<xsl:value-of select="mod:Item/name" />",
			"brand" : "<xsl:value-of select="mod:Item/brand" />",
			"skus": {
					"size" : <xsl:value-of select="count(mod:ItemSku)" />,
					"items": [
		<xsl:for-each select="mod:ItemSku">
			<xsl:variable name="price" select="price"/>
						{
							"id": "<xsl:value-of select="id" />",
							"name":"<xsl:value-of select="name" />",
							"summary":"<xsl:value-of select="summary" />",
							"price": <xsl:value-of select="($price div 100)" />,
							"sku":"<xsl:value-of select="sku" />",
							"stockQuantity": <xsl:value-of select="quantityInStock" />,
							"links" : [
								{
									"href" : "<xsl:value-of select="$baseUrl"/>/items/<xsl:value-of select="$itemId" />/skus/<xsl:value-of select="id" />",
									"rel" : "self"
								}<xsl:if test="images/image">,</xsl:if>
			<xsl:for-each select="images/image">
								{
									"href" : "<xsl:value-of select="." />",
									"rel" : "<xsl:value-of select="@type" />"
								}<xsl:if test="./following-sibling::images/image">,</xsl:if>
			</xsl:for-each>
							]
						}<xsl:if test="./following-sibling::mod:ItemSku">,</xsl:if>
		</xsl:for-each>
					]
			}
		}
	</xsl:template>
</xsl:stylesheet>