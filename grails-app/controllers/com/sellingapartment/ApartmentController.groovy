package com.sellingapartment

import grails.plugin.springsecurity.annotation.Secured

class ApartmentController {
	static allowedMethods = [create:'POST', update:'POST', delete:'POST', edit:'GET', getAppartmentByIdJson:'GET']
	
	def apartmentService
	def facilityService
	def preferenceService
	
	
	@Secured(['ROLE_ANONYMOUS', 'ROLE_ADMIN', 'ROLE_USER'])
	def showAllAsJson(){
		def apartments = apartmentService.showAllApartmentOrderByName()
		render(apartments as grails.converters.JSON)
	}
	
	@Secured(['ROLE_ANONYMOUS', 'ROLE_ADMIN', 'ROLE_USER'])
	def getAppartmentByIdJson(Long id){
		def apartment = apartmentService.getApartment(id)
		render(apartment as grails.converters.JSON)
	}
	
	@Secured(['ROLE_ADMIN'])
	def index() {
		def message = params["message"]
		def status = params["status"]
		def facilities = facilityService.showAllFacility()
		Preference currentPreference = preferenceService.getCurrentPreference()
		[floorNumber:currentPreference.floorNumber, facilities: facilities, message: message, status: status]
	}

	@Secured(['ROLE_ADMIN', 'ROLE_USER'])
	def view(Long id) {
		def apartment = apartmentService.getApartment(id);
		def apartmentFacilities = ApartmentFacility.getFacilitiesByApartmentId(id)
		[apartment: apartment, apartmentFacilities: apartmentFacilities]
	}

	@Secured(['ROLE_ADMIN'])
	def create(){
		if(apartmentService.saveApartment(params)){
			println("Create apartment " + params['name'] + " successfully.")
			render('')
		} else {
			println("Fail to Create apartment " + params['name'] + ".")
			render('')
		}
	}

	@Secured(['ROLE_ADMIN'])
	def edit(Long id){
		Apartment apartment = apartmentService.getApartment(id)
		if(!apartment){
			render ''
		}
		else {
			def apartmentFacilities = ApartmentFacility.getFacilityIdsByApartmentId(apartment.id)
			def facilities = facilityService.getAllFacilities()
			[apartment: apartment, apartmentFacilities: apartmentFacilities, facilities: facilities]
		}
	}

	@Secured(['ROLE_ADMIN'])
	def update() {
		if(apartmentService.updateApartment(params)){
			println("Update apartment " + params['name'] + " successfully.");
			render ''
		}
		else{
			println("Fail to update apartment " + params['name'] + ".");
			render ''
		}
	}

	@Secured(['ROLE_ADMIN'])
	def delete(Long id) {
		if(apartmentService.deleteApartment(id)){
			render('')
		} else {
			render 'fail'
		}
	}
}
