<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0" xmlns:mes="http://www.alainn.com/SOA/message/1.0"
	xmlns:mod="http://www.alainn.com/SOA/model/1.0">

	<xsl:output method="text" version="1.0" encoding="UTF-8"
		indent="no" media-type="text/plain" />
		
	<xsl:param name="baseUrl" />
	
	<xsl:template match="/">
		{
			"links" : [
					{
						"href" : "<xsl:value-of select="$baseUrl"/>",
						"rel" : "self"
					}
			],
			"collection" : {
				"size" : <xsl:value-of select="count(/mes:getBasketResponse/mod:BasketItem)" />,
				"items" : [
		<xsl:for-each select="/mes:getBasketResponse/mod:BasketItem">
					{
						"sku":"<xsl:value-of select="sku" />",
						"type":"<xsl:value-of select="type" />",
						"name":"<xsl:value-of select="name" />",
						"summary":"<xsl:value-of select="summary" />",
						"brand":"<xsl:value-of select="brand" />",
						"quantity": <xsl:value-of select="transactionQuantity" />,
						"price": <xsl:value-of select="price" />,
						"links" : [
							{
								"href" : "<xsl:value-of select="$baseUrl"/>/<xsl:value-of select="sku" />",
								"rel" : "self"
							}<xsl:if test="images/image">,</xsl:if>
			<xsl:for-each select="images/image">
							{
								"href" : "<xsl:value-of select="." />",
								"rel" : "<xsl:value-of select="@type" />"
							}<xsl:if test="./following-sibling::image">,</xsl:if>
			</xsl:for-each>
						]
					}<xsl:if test="./following-sibling::mod:BasketItem">,</xsl:if>
		</xsl:for-each>
				]
			}
		}
	</xsl:template>
</xsl:stylesheet>