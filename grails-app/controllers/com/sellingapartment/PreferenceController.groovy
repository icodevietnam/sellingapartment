package com.sellingapartment
import com.sun.xml.internal.ws.api.streaming.XMLStreamReaderFactory.Default;

import grails.plugin.springsecurity.annotation.Secured

class PreferenceController {
	
	def preferenceService
	
	@Secured(['ROLE_ADMIN'])
	def index(){
		Preference currentPreference = preferenceService.getCurrentPreference()
		[preference:currentPreference]
	}
	
	@Secured(['ROLE_ANONYMOUS', 'ROLE_ADMIN', 'ROLE_USER'])
	def currentPreferenceJson(){
		render(preferenceService.getCurrentPreference() as grails.converters.JSON)
	}
	
	@Secured(['ROLE_ADMIN'])
	def update(){
		def message = ""
		def status 
		if(preferenceService.updatePreference(params)){
			message = "Update preference " + params['name'] + " successfully."
			status = true
		}
		else{
			message = "Fail to update preference " + params['name'] + "."
			status = false
		}
		redirect (action: "index", params: [message: message, status: status])
	}
	
	
}
