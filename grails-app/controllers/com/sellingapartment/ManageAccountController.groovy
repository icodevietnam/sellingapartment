package com.sellingapartment

import grails.plugin.springsecurity.annotation.Secured

class ManageAccountController {
	@Secured(['ROLE_ANONYMOUS', 'ROLE_ADMIN'])
    def index() { }
}
