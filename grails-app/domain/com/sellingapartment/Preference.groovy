package com.sellingapartment

class Preference {
	String name
	String address
	String url
	String email
	String phone
	String country
	String features
	String company
	String ceo
	String slogan
	int floorNumber
	
	/*static hasMany = [images: Image]*/
	
	static constraints = {
		name nullable: true
		address nullable: true
		url nullable: true
		country nullable: true
		features nullable : true
		company nullable : true
		email nullable : true
		ceo nullable : true 
	}
	
}
