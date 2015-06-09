package com.sellingapartment

import grails.plugin.springsecurity.annotation.Secured

class CategoryController {
	static allowedMethods = [create:'POST', update:'POST', delete:'POST', edit:'GET']
	def categoryService


	@Secured(['ROLE_ADMIN'])
	def showAllCatNew(){
		return categoryService.showAllCatNew()
	}

	@Secured(['ROLE_ANONYMOUS', 'ROLE_ADMIN', 'ROLE_USER'])
	def showAllCatNewJson(){
		render(categoryService.showAllCatNew() as grails.converters.JSON)
	}

	@Secured(['ROLE_ANONYMOUS', 'ROLE_ADMIN', 'ROLE_USER'])
	def showAll(){
		def categories = categoryService.getAllCategories()
		render(categories as grails.converters.JSON)
	}

	@Secured(['ROLE_ADMIN'])
	def index() {
		def message = params["message"]
		def status = params["status"]
		def categories = categoryService.getAllCategories()
		[categories: categories, message: message, status: status]
	}

	@Secured(['ROLE_ADMIN'])
	def create() {
		if(categoryService.saveCategory(params)){
			render(view: 'list', model:[categories: categoryService.getAllCategories()])
		} else {
			render 'fail'
		}
	}
	@Secured(['ROLE_ADMIN'])
	def edit(Long id){
		Category category = categoryService.getCategory(id)
		if(!category){
			render "Can not found category."
		}
		else {
			[category:category]
		}
	}
	@Secured(['ROLE_ADMIN'])
	def update() {
		def message = ""
		def status
		if(categoryService.updateCategory(params)){
			message = "Update category " + params['name'] + " successfully."
			status = true
		}
		else{
			message = "Fail to update category " + params['name'] + "."
			status = false
		}
		redirect (action: "index", params: [message: message, status: status])
	}
	@Secured(['ROLE_ADMIN'])
	def delete(Long id) {
		if(categoryService.deleteCategory(id)){
			render(view: 'list', model:[categories: categoryService.getAllCategories()])
		} else {
			render 'fail'
		}
	}
}
