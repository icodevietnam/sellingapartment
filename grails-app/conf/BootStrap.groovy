import java.util.prefs.PreferenceChangeEvent;

import com.sellingapartment.Account
import com.sellingapartment.AccountRole
import com.sellingapartment.Preference;
import com.sellingapartment.Role

class BootStrap {
	def init = {
		servletContext ->
		def adminRole
		def userRole
		def criteriaRoleAdmin = Role.createCriteria()
		
		//Create Default Preference 
		/*def preference = new Preference()
		preference.name = "Sunrise City"
		preference.address = "590 Cach Mang Thang 8"
		preference.url = "www.sunrisecity.com.vn"
		preference.email = "sellingapartment2015@gmail.com"
		preference.country = "VN"
		preference.features = "The new Features"
		preference.company = "Selling Apartment Company"
		preference.ceo = "Quang Nhat"
		preference.save();*/
		//
		
		if(!criteriaRoleAdmin.list {
			eq 'authority', 'ROLE_ADMIN'
		}){
			adminRole = new Role(authority: 'ROLE_ADMIN')
			adminRole.save(flush: true)
		}
		def criteriaRoleUser = Role.createCriteria()
		if(!criteriaRoleUser.list {
			eq 'authority', 'ROLE_USER'
		}){
			userRole = new Role(authority: 'ROLE_USER')
			userRole.save(flush: true)
		}
		def criteriaUser = Account.createCriteria()
		if(!criteriaUser.list {
			eq 'username', 'admin'
		}){
			def adminUser = new Account(username: 'admin', password: '123456')
			adminUser.save(flush: true)
			
			AccountRole.create adminUser, adminRole, true
		
			assert Account.count() == 1
			assert Role.count() == 2
			assert AccountRole.count() == 1
		}
	}
	def destroy = {
	}
}
