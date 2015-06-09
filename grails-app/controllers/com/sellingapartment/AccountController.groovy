package com.sellingapartment

import grails.plugin.springsecurity.annotation.Secured

import java.text.SimpleDateFormat

class AccountController {
	static allowedMethods = [save: "POST", update: "POST"]
	def accountService
	def springSecurityService
	@Secured(['ROLE_ADMIN', 'ROLE_USER'])
    def index() {
		
	}
	@Secured(['ROLE_ANONYMOUS'])
	def create(){
		[message: params['message']]
	}
	
	@Secured(['ROLE_ANONYMOUS'])
	def save(){
		Account newAccount = accountService.save(params)
		if(newAccount){
			springSecurityService.reauthenticate(newAccount.username, newAccount.password)
			redirect(controller: "home", action: "index")
		} else {
			String message = "Input invalid"
			redirect(controller: "account", action: "create", params: [message: message])
		}
	}
	@Secured(['ROLE_ADMIN', 'ROLE_USER'])
	def edit(Long id){
		String dateOfBirth
		Account account = Account.get(id)
		if (!account) {
			[message: "Account is not available"]
			return
		}
		if(account.dateOfBirth){
			dateOfBirth = new SimpleDateFormat("dd/MM/yyyy").format(account.dateOfBirth)
		}
		[account: account, message: params['message'], dateOfBirth: dateOfBirth]
	}
	@Secured(['ROLE_ADMIN', 'ROLE_USER'])
	def update(){
		Account newAccount = accountService.update(params)
		if(newAccount){
			springSecurityService.reauthenticate(newAccount.username, newAccount.password)
			redirect(controller: "home", action: "index")
		} else {
			String message = "Input invalid"
			redirect(controller: "account", action: "create", params: [message: message])
		}
	}
}
