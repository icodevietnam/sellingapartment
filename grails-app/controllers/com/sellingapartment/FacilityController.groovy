package com.sellingapartment

import org.springframework.web.multipart.MultipartFile;

import grails.plugin.springsecurity.annotation.Secured

class FacilityController {
	static allowedMethods = [create:'POST', update:'POST', delete:'POST', edit:'GET']
	def facilityService
	
	@Secured(['ROLE_ANONYMOUS', 'ROLE_ADMIN', 'ROLE_USER'])
	def getAllFacilityJson(){
		render(facilityService.showAllFacility() as grails.converters.JSON)
	}
	
	@Secured(['ROLE_ADMIN'])
	def index() {
		def message = params["message"]
		def status = params["status"]
		def facilities = facilityService.getAllFacilities()
		[facilities: facilities, message: message, status: status]
	}
	
	@Secured(['ROLE_ADMIN'])
	def create() {
		if(facilityService.saveFacility(params)){
			render(view: 'list', model:[facilities: facilityService.getAllFacilities()] )
		} else {
			render 'fail'
		}
	}
	@Secured(['ROLE_ADMIN'])
	def edit(Long id){
		Facility facility = facilityService.getFacility(id)
		if(!facility){
			render "Can not found Facility."
		}
		else {
			[facility:facility]
		}
	}
	@Secured(['ROLE_ADMIN'])
	def update() {
		def message = ""
		def status
		if(facilityService.updateFacility(params)){
			message = "Update facility " + params['name'] + " successfully."
			status = true
		}
		else{
			message = "Fail to update facility " + params['name'] + "."
			status = false
		}
		redirect (action: "index", params: [message: message, status: status])
	}
	@Secured(['ROLE_ADMIN'])
	def delete(Long id) {
		if(facilityService.deleteFacility(id)){
			render(view: 'list', model:[facilities: facilityService.getAllFacilities()])
		} else {
			render 'fail'
		}
	}
	
}
