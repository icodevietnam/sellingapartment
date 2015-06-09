package com.sellingapartment

class News {
	String title
	String description
	String content
	String tag
	Date dateCreated
	Date dateUpdated

	static belongsTo = [author: Account,category :Category]
	static constraints = {
		title nullable: true
		content nullable: true
		tag nullable: true
		dateCreated nullable: true
	}
}
