package com.sellingapartment

class Facility {
	String name
	String description
	String type
	
	static hasMany = [apartments:Apartment]

	static constraints = {
		name blank: false, unique: true
	}
}
