package com.sellingapartment

class Image {
	//Define entity
	String code
	String fileName
	String fullPath

	Date uploadDate = new Date()

	static constraints = {
		fileName blank:false, nullable:false
		fullPath blank:false, nullable:false
	}
}
