package com.sellingapartment

class Category {
	String name
	String description
	String type
	String shortName
	static hasMany = [news:News]
	
	static constraints = {
		name nullable: true
		description nullable: true
		type nullable: true
	}
}
