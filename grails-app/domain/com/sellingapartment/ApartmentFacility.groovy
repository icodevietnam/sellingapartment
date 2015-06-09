package com.sellingapartment

class ApartmentFacility {

    Facility facility
	Apartment apartment
	
	static constraints = {
	}
	
	static List<ApartmentFacility> getByApartmentId(long apartmentId) {
		ApartmentFacility.where {
			apartment == Apartment.load(apartmentId)
		}.list()
	}
	
	static ApartmentFacility create(Apartment apartment, Facility facility, boolean flush = false) {
		def instance = new ApartmentFacility(apartment: apartment, facility: facility)
		instance.save(flush: flush, insert: true)
		instance
	}
	
	static void removeAll(Apartment apartmentParam, boolean flush = false) {
		if (apartmentParam == null){ 
			return
		}
		ApartmentFacility.where {
			apartment == Apartment.load(apartmentParam.id)
		}.deleteAll()
		if (flush) { 
			AccountRole.withSession {
				it.flush() 
			} 
		}
	}
	
	static boolean remove(Apartment apartmentParam, Facility facilityParam, boolean flush = false) {
		if (apartmentParam == null || facilityParam == null) {
			return false
		}
		int rowCount = ApartmentFacility.where {
			apartment == Apartment.load(apartmentParam.id) &&
			facility == Facility.load(facilityParam.id)
		}.deleteAll()

		if (flush) { 
			ApartmentFacility.withSession { 
				it.flush() 
			} 
		}
		rowCount > 0
	}
	
	static boolean exists(long apartmentId, long facilityId) {
		ApartmentFacility.where {
			apartment == Apartment.load(apartmentId) &&
			facility == Facility.load(facilityId)
		}.count() > 0
	}
	
	static List<Integer> getFacilityIdsByApartmentId(long apartmentId) {
		def criteria = ApartmentFacility.createCriteria()
		return criteria.list {
			eq 'apartment.id', apartmentId
			projections {
				property 'facility.id'
			}
		}
	}
	
	static List<Facility> getFacilitiesByApartmentId(long apartmentId) {
		def criteria = ApartmentFacility.createCriteria()
		return criteria.list {
			eq 'apartment.id', apartmentId
			projections {
				property 'facility'
			}
		}
	}
}
