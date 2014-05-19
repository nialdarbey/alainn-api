<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	version="1.0" xmlns:mes="http://www.alainn.com/SOA/message/1.0"
	xmlns:mod="http://www.alainn.com/SOA/model/1.0">

	<xsl:output method="text" version="1.0" encoding="UTF-8"
		indent="no" media-type="text/plain" />
		
	<xsl:param name="pageIndex" />
	<xsl:param name="requestedPageSize" />
	<xsl:param name="baseUrl" />
	<xsl:param name="fullUrl" />
	<xsl:param name="urlXPage" />
	
	<xsl:variable name="pageSize" select="/mes:getWishListResponse/mes:PageInfo/pageSize" />
	
	<xsl:template match="/">
		{
			"links" : [
		<xsl:if test="$requestedPageSize = $pageSize" >
			<xsl:variable name="nextUrl">
				<xsl:value-of select="$urlXPage"/>&amp;pageIndex=<xsl:value-of select="$pageIndex + $pageSize"/>&amp;pageSize=<xsl:value-of select="$requestedPageSize"/>
			</xsl:variable>
					{
						"href" : "<xsl:value-of select="$nextUrl"/>",
						"rel" : "next"
					},
		</xsl:if>
		<xsl:if test="$pageIndex > 0" >
			<xsl:variable name="prevUrl">
				<xsl:choose>
					<xsl:when test="$pageIndex - $pageSize >= 0">
						<xsl:value-of select="$urlXPage"/>&amp;pageIndex=<xsl:value-of select="$pageIndex - $pageSize"/>&amp;pageSize=<xsl:value-of select="$requestedPageSize"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$urlXPage"/>&amp;pageIndex=0&amp;pageSize=<xsl:value-of select="$requestedPageSize"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
					{
						"href" : "<xsl:value-of select="$prevUrl"/>",
						"rel" : "prev"
					},
		</xsl:if>
					{
						"href" : "<xsl:value-of select="$fullUrl"/>",
						"rel" : "self"
					}
			],
			"collection" : {
				"size" : <xsl:value-of select="/mes:getWishListResponse/mes:PageInfo/pageSize" />,
				"items" : [
		<xsl:for-each select="/mes:getWishListResponse/mod:ItemSku">
					{
						"sku":"<xsl:value-of select="sku" />",
						"type":"<xsl:value-of select="type" />",
						"name":"<xsl:value-of select="name" />",
						"summary":"<xsl:value-of select="summary" />",
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
					}<xsl:if test="./following-sibling::mod:ItemSku">,</xsl:if>
		</xsl:for-each>
				]
			}
		}
	</xsl:template>
</xsl:stylesheet>