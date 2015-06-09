package com.sellingapartment

import grails.plugin.springsecurity.annotation.Secured
import grails.plugin.springsecurity.SpringSecurityUtils

class ProductController {
	
	def springSecurityService
	def apartmentService
	def facilityService
	def preferenceService
	
	@Secured(['ROLE_ANONYMOUS', 'ROLE_ADMIN', 'ROLE_USER'])
	def index(){
		def currentUser
		String postUrl
		def config = SpringSecurityUtils.securityConfig
		if (springSecurityService.isLoggedIn()) {
			currentUser = springSecurityService.currentUser
		}
		def facilities = facilityService.showAllFacility()
		def apartments = apartmentService.showAllApartmentOrderByName()
		Preference currentPreference = preferenceService.getCurrentPreference()
		['apartments':apartments,'currentUser': currentUser,floorNumber:currentPreference.floorNumber, facilities: facilities,'activePage':'product']
	}
	
	def searchProduct(){
		def selectFacilit = params['facilityId']
		def selectFloor = params['floor']
		def minPrice = params['fromPrice']
		def toPrice = params['toPrice']
		
		def criteria = Apartment.createCriteria()
		
		
	}
}
