package com.sellingapartment

class Account {

	transient springSecurityService

	String username
	String password
	String email
	String address
	Date dateOfBirth
	String firstName
	String lastName
	String gender
	String phoneNumber
	static hasMany = [news:News]
	boolean enabled = true
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired

	static transients = ['springSecurityService']

	static constraints = {
		username blank: false, unique: true
		password blank: false
		email nullable: true
		address nullable: true
		dateOfBirth nullable: true
		firstName nullable: true
		lastName nullable: true
		gender nullable: true
		phoneNumber nullable: true
	}

	static mapping = {
		password column: '`password`'
	}

	Set<Role> getAuthorities() {
		AccountRole.findAllByAccount(this).collect { it.role }
	}

	def beforeInsert() {
		encodePassword()
	}

	def beforeUpdate() {
		if (isDirty('password')) {
			encodePassword()
		}
	}

	protected void encodePassword() {
		password = springSecurityService?.passwordEncoder ? springSecurityService.encodePassword(password) : password
	}
}
