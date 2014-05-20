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

	* href: the url
	* rel:  the meaning of the url (Image, prev, next, self, etc.)
	* label: UI label

If the response is a collection object, it will have a links array at the root and for each item in the items array.

# API Manager

Registered both as a Service with the OAuth 2.0 Access Token Enforcement policy applied, and also as a Consumer of 

	* Item Service
	* Basket Service
	* WishList Service
	* OrderFulfillment Service
	* Registration Service 

# Contact

nial.darbey@mulesoft.com


