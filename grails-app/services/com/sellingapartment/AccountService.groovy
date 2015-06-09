package com.sellingapartment

import grails.transaction.Transactional

import java.text.DateFormat
import java.text.SimpleDateFormat

@Transactional
class AccountService {

    def save(Map params) {
		def userRole = new Role(authority: 'ROLE_USER')
		userRole = Role.find userRole
		if(params['dateOfBirth'] != ''){
			params['dateOfBirth'] = new SimpleDateFormat("dd/MM/yyyy").parse(params['dateOfBirth'])
		}
		Account account = new Account(params)
		if(account.validate()){
			account.save(flush: true)
			AccountRole.create account, userRole
			account
		} else {
			null
		}
    }
	
	def update(Map params) {
		Account account = Account.get(params['id'])
		account.with{
			account.firstName = params['firstName']
			account.lastName = params['lastName']
			account.email = params['email']
			account.phoneNumber = params['phoneNumber']
			account.address = params['address']
			account.gender = params['gender']
			if(params['dateOfBirth'] != ''){
				account.dateOfBirth = new SimpleDateFormat("dd/MM/yyyy").parse(params['dateOfBirth'])
			}
			account.password = params['password']
			account.username = params['username']
		}
		account.save(flush: true)
	}
}
