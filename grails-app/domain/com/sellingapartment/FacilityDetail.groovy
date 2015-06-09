package com.sellingapartment

import com.sellingapartment.Apartment;
import com.sellingapartment.Facility;

class FacilityDetail {
	Facility facility
	Apartment apartment
	
	static constraints = {
	}
	
	static FacilityDetail create(Apartment apartment, Facility facility, boolean flush = false) {
		def instance = new FacilityDetail(apartment: apartment, facility: facility)
		instance.save(flush: flush, insert: true)
		instance
	}
}
