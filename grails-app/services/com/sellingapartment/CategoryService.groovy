package com.sellingapartment

import java.util.Map;

import org.springframework.dao.DataIntegrityViolationException;

import grails.transaction.Transactional;

@Transactional
class CategoryService {
	
	def showAllCatNew(){
		def criteria = Category.createCriteria()
		def results	= criteria.list {
			eq("type","news")
			order("name","asc")
		}
	}
	
	def getAllCategories(){
		Category.getAll()
	}
	
	def getCategory(Long id){
		Category.get(id)
	}
	
	def saveCategory(Map params){
		Category category = new Category(params);
		category.save(flush: true)
	}

	def updateCategory(Map params){
		Category category = getCategory(Long.valueOf(params.get("id")))
		category.name = params.get("name")
		category.description = params.get("description")
		category.type = params.get("type")
		category.shortName = params.get("shortName")
		category.save(flush: true)
	}
	
	def deleteCategory(Long id){
		Category category = Category.get(id)
		try {
			category.delete(flush: true)
			return true
		} catch (DataIntegrityViolationException e) {
			return false
		}
	}
}
