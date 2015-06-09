package com.sellingapartment

import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.annotation.Secured

class GoodDealsController {
	def springSecurityService
	def apartmentService
	@Secured(['ROLE_ANONYMOUS', 'ROLE_ADMIN', 'ROLE_USER'])
    def index() {
		String view = 'index'
		def currentUser
		if (springSecurityService.isLoggedIn()) {
			currentUser = springSecurityService.currentUser
		}
		def apartments = apartmentService.getAllApartments()
		render view: view, model: ['apartments': apartments, 'currentUser': currentUser, 'activePage': 'good_deals']
	}
}
