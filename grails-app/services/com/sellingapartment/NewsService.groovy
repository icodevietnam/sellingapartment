package com.sellingapartment

import grails.transaction.Transactional

import org.springframework.dao.DataIntegrityViolationException

@Transactional
class NewsService {
	
	def springSecurityService
	def categoryService
	def grailsApplication

	def getAllNews() {
		News.getAll()
	}

	def showAllNewsOrderByName(){
		def criteria = News.createCriteria()
		def result = criteria.list { order("title","asc") }
	}

	def getNews(Long id){
		News.get(id)
	}

	def saveNews(Map params){
		def currentUser = (Account)springSecurityService.currentUser
		News news = new News(
				title: params['title'],
				description: params['description'],
				content: params['content'],
				tag: params['tag'],
				dateCreated: new Date(),
				dateUpdated : new Date()
				)
		news.category = categoryService.getCategory(Long.parseLong(params['catId']))
		news.author = currentUser
		news.save(flush: true)
	}

	def updateNews(Map params){
		def currentUser = (Account)springSecurityService.currentUser
		News news = getNews(Long.valueOf(params['id']))
		news.title = params['title']
		news.content = params['content']
		news.description = params['description']
		news.tag = params['tag']
		news.dateUpdated = new Date()
		news.category = categoryService.getCategory(Long.parseLong(params['catId']))
		news.author = currentUser
		news.save(flush: true)
	}

	def deleteNews(Long id){
		News news = News.get(id)
		try {
			news.delete(flush: true)
			return true
		} catch (DataIntegrityViolationException e) {
			return false
		}
	}
}
