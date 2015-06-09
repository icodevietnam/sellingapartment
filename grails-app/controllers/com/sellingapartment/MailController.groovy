package com.sellingapartment

import grails.plugin.springsecurity.annotation.Secured;

class MailController {
	
	static allowedMethods = [testMail:'GET',create:'POST', update:'POST', delete:'POST', edit:'GET']
	
	
	@Secured(['ROLE_ANONYMOUS', 'ROLE_ADMIN', 'ROLE_USER'])
	def index(){
		render("Hello world")
	}
	
	@Secured(['ROLE_ANONYMOUS', 'ROLE_ADMIN', 'ROLE_USER'])
	def testMail(){
		def toEmail = params['to']
		def subject = params['subject'] 
		def content = params['content']
		def success = EmailHelper.sendSSLGmail(toEmail,subject,content)
		render(success);
	}
}
