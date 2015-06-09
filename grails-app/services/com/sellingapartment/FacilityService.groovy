package com.sellingapartment

import grails.transaction.Transactional

import org.springframework.dao.DataIntegrityViolationException
import org.springframework.web.multipart.MultipartFile

@Transactional
class FacilityService {

	private static final okImageTypes = ['image/png', 'image/jpeg,', 'image/gif']
	
	def showAllFacility(){
		def criteria = Facility.createCriteria()
		def results	= criteria.list {
			eq("type","apartment")
			order("name","asc")
		}
	}

	def getAllFacilities() {
		Facility.getAll()
	}

	def getFacility(Long id){
		Facility.get(id)
	}

	def saveFacility(Map params){
		Facility facility = new Facility(params)
		facility.save(flush: true)
	}

	def updateFacility(Map params){
		Facility facility = getFacility(Long.valueOf(params.get("id")))
		facility.name = params.get("name")
		facility.description = params.get("description")
		facility.type = params.get("type")
		facility.save(flush: true)
	}

	def deleteFacility(Long id){
		Facility facility = Facility.get(id)
		try {
			facility.delete(flush: true)
			return true
		} catch (DataIntegrityViolationException e) {
			return false
		}
	}
}
