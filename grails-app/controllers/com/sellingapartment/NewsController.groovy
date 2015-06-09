package com.sellingapartment

import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.annotation.Secured

class NewsController {
	static allowedMethods = [create:'POST', update:'POST', delete:'POST', edit:'GET', showNewByCategoryasJson:'GET']

	def newsService
	def categoryService
	def springSecurityService

	@Secured(['ROLE_ANONYMOUS', 'ROLE_ADMIN', 'ROLE_USER'])
	def show(){
		def currentUser
		String postUrl
		def config = SpringSecurityUtils.securityConfig
		if (springSecurityService.isLoggedIn()) {
			currentUser = springSecurityService.currentUser
		}
		def catID = params.catId
		Category category = categoryService.getCategory(Long.parseLong(catID))
		def news = category.news
		render (view:'show',model:[currentUser:currentUser,category:category,news:news])
	}
	
	@Secured(['ROLE_ANONYMOUS', 'ROLE_ADMIN', 'ROLE_USER'])
	def showNewByCategoryasJson() {
		def catId = params['catId']
		Category category = categoryService.getCategory(Long.parseLong(catId))
		def news = category.news
		render(news as grails.converters.JSON)
	}


	@Secured(['ROLE_ANONYMOUS', 'ROLE_ADMIN', 'ROLE_USER'])
	def showAllAsJson(){
		def news = newsService.showAllNewsOrderByName()
		render(news as grails.converters.JSON)
	}

	@Secured(['ROLE_ANONYMOUS', 'ROLE_ADMIN', 'ROLE_USER'])
	def getNewsByIdJson(Long id){
		def news = newsService.getNews(id)
		render(news as grails.converters.JSON)
	}

	@Secured(['ROLE_ADMIN'])
	def index() {
		def message = params["message"]
		def status = params["status"]
		def categories = categoryService.showAllCatNew()
		[categories: categories, message: message, status: status]
	}

	@Secured(['ROLE_ADMIN', 'ROLE_USER'])
	def view(Long id) {
		def news = newsService.getNews(id);
		[news: news]
	}

	@Secured(['ROLE_ADMIN'])
	def create(){
		if(newsService.saveNews(params)){
			println("Create news " + params['title'] + " successfully.");
			render('')
		} else {
			println("Fail to Create news " + params['title'] + ".");
			render('')
		}
	}

	@Secured(['ROLE_ADMIN'])
	def edit(Long id){
		Apartment news = newsService.getNews(id)
		if(!news){
			render ''
		}
		else {
		}
	}

	@Secured(['ROLE_ADMIN'])
	def update() {
		if(newsService.updateNews(params)){
			println("Update news " + params['title'] + " successfully.");
			render ''
		}
		else{
			println("Fail to update news " + params['title'] + ".");
			render ''
		}
	}

	@Secured(['ROLE_ADMIN'])
	def delete(Long id) {
		if(newsService.deleteNews(id)){
			render('')
		} else {
			render 'fail'
		}
	}
}
