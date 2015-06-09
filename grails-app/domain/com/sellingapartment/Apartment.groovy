package com.sellingapartment

class Apartment {
	String name
	String description
	String content
	String roomNo
	String floor
	String price
	
	static belongsTo = [facility:Facility]
	
	static constraints = {
		description nullable: true
		content nullable: true
		roomNo nullable: true
		floor nullable: true
		price nullable: true
	}
}
