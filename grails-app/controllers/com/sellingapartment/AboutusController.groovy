package com.sellingapartment

import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.annotation.Secured

class AboutusController {

	def springSecurityService

	@Secured(['ROLE_ANONYMOUS', 'ROLE_ADMIN', 'ROLE_USER'])
	def index() {
		String view = 'index'
		def currentUser
		String postUrl
		def config = SpringSecurityUtils.securityConfig
		if (springSecurityService.isLoggedIn()) {
			currentUser = springSecurityService.currentUser
		}
		render view: view, model: ['currentUser': currentUser, 'activePage': 'aboutus']
	}
	
}
