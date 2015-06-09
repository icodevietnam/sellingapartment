package com.sellingapartment

import grails.transaction.Transactional

import org.springframework.dao.DataIntegrityViolationException

@Transactional
class ApartmentService {
	def springSecurityService
	def facilityService
	def grailsApplication
	
    def getAllApartments() {
		Apartment.getAll()
	}
	
	def showAllApartmentOrderByName(){
		def criteria = Apartment.createCriteria()
		def result = criteria.list {
			order("name","asc")
		}
	}
	
	def getApartment(Long id){
		Apartment.get(id)
	}
	
	def saveApartment(Map params){
		Apartment apartment = new Apartment(
			name: params['name'],
			description: params['description'],
			content: params['content'],
			roomNo: params['roomNo'],
			floor: params['floor'],
			price: params['price']
			)
		apartment.facility = facilityService.getFacility(Long.parseLong(params['facilityId']))
		apartment.save(flush: true)
		
	}

	def updateApartment(Map params){
		Apartment apartment = getApartment(Long.valueOf(params['id']))
		apartment.name = params['name']
		apartment.content = params['content']
		apartment.description = params['description']
		apartment.roomNo = params['roomNo']
		apartment.floor = params['floor']
		apartment.price = params['price']
		apartment.facility = facilityService.getFacility(Long.parseLong(params['facilityId']))
		apartment.save(flush: true)
	}
	
	def deleteApartment(Long id){
		Apartment apartment = Apartment.get(id)
		try {
			apartment.delete(flush: true)
			return true
		} catch (DataIntegrityViolationException e) {
			return false
		}
	}
	
}
