# Alainn API

Web API facade on to Alainn's SOA Architecture. Designed to be the central point of access to all business process level SOAP services.

# Resource Hierarchy

The resources are in part independent of the user browsing them

* /items
* /brands

Others are personal to the authenticated User: 

* /basket
* /wish-list

All return application/json as Response media-type and all accept only application/json as request media-type.

# Security

Though the API does not implement any authentication / authorisation logic itself, it is dependent on API Manager to leave an LDAPUserDetails instance in the security context in order to return the correct data for the personal resources listed above.

# Hypermedia

The usual form of each response is to include a links array with a number of objects of the form:

**href**: the url

**rel**:  the meaning of the url (Image, prev, next, self, etc.)

**label**: UI label

```json
	  "links": [
	      {
	          "href": "https://alainn-api.cloudhub.io/omni-channel-api/v1.0?pageIndex=28&pageSize=7",
	          "rel": "next"
	      },
	      {
	          "href": "https://alainn-api.cloudhub.io/omni-channel-api/v1.0?pageIndex=14&pageSize=7",
	          "rel": "prev"
	      },
	      {
	          "href": "https://alainn-api.cloudhub.io/omni-channel-api/v1.0/items",
	          "rel": "self"
	      }
	  ]
```

If the response is a collection object, it will have a links array at the root and for each item in the items array.

```json
	"collection": {
		"size": 7,
		"items": [
		  {
		      "id": "B003Y60XCC",
		      "type": "Chemical Hair Dyes",
		      "name": "L'Oreal Oreor 30 Volume Creme Developer",
		      "summary": "Fully stabilized formula - Freshness assured",
		      "brand": "L'Oreal Paris",
		      "links": [
		          {
		              "href": "https://localhost:8082/omni-channel-api/v1.0/items/B003Y60XCC",
		              "rel": "self"
		          },
		          {
		              "href": "http://ecx.images-amazon.com/images/I/41MWX6KNAuL._SL75_.jpg",
		              "rel": "SmallImage"
		          }
		      ]
		  },
		  { ...
```

# API Manager

Registered both as a Service with the OAuth 2.0 Access Token Enforcement policy applied, and also as a Consumer of 

* Item Service
* Customer Service
* Basket Service
* WishList Service
* Order-fulfillment Service
* Registration Service 
* Point-of-Sale Service

# Technical Points of Note

## Access to the security Context:

Note that this can only be executed in the expression-component Message Processor. The `<set-session-variable>` Message Processor **has no access to the securityContext**.

```xml
	<expression-component doc:name="set userId">
		<![CDATA[
			sessionVars.userId = _muleEvent.session.securityContext.authentication.principal.username
		]]>
	</expression-component>
``` 


## Multiple APIKit Configs:
	
I have done this in order to facilitate access to public resources without obliging an OAuth validation.This is done by having two Main flows with Jetty inbound and passing through APIkit routers which refer to the different configs. When a resource must be shared between both endpoints, then we need to remove the config name from the end of the flow name:

```xml
	<flow name="get:/items/{item}" doc:name="get:/items/{item}">
```

## Jetty Inbound:

Much faster than Http inbound.

## Transformations:

Usually, where the incoming payload is empty (GET requests), I use `<parse-template />` with expressions to invoke the relevant SOAP Service. On the way back, given the complexity of the message structure, I was forced to use XSLT.


# Contact

nial.darbey@mulesoft.com


