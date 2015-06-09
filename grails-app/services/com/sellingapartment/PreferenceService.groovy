package com.sellingapartment

import java.awt.TexturePaintContext.Int;

import grails.transaction.Transactional;

@Transactional
class PreferenceService {
	
	def getCurrentPreference(){
		Preference preference = Preference.getAll().get(0) 
		return preference;
	}
	
	def updatePreference(Map params){
		Preference preference = getCurrentPreference()
		preference.name = params.get("name")
		preference.address = params.get("address")
		preference.url = params.get("url")
		preference.country = params.get("country")
		preference.email = params.get("email")
		preference.phone = params.get("phone")
		preference.features = params.get("features")
		preference.company = params.get("company")
		preference.ceo = params.get("ceo")
		preference.slogan = params.get("slogan")
		preference.floorNumber = Integer.parseInt(params.get("floorNumber"))
		preference.save(flush:true)
		/*def images = params.get("images")
		if(images !=null && images == ''){
			if(images instanceof String){
				def imageParams = images.split(",")
				def imageInstance = new Image()
				imageInstance.code = imageParams[0]
				imageInstance.fileName = imageParams[1]
				System.out.println(imageParams[0] + "-" + imageInstance[1])
				File storagePath = new File(grailsApplication.config.storageFolder + preference.id)
				if(!storagePath.exists()){
					try{
						storagePath.mkdirs();
					}
					catch(SecurityException se){
						println "Can't create storage path."
					}
				}
				imageInstance.fullPath = grailsApplication.config.storageFolder + preference.id + "/" + imageParams[0] + "-" + imageParams[1]
				InputStream input = null;
				OutputStream output = null;
				try {
					input = new FileInputStream(grailsApplication.config.uploadFolder + imageParams[0] + "-" + imageParams[1]);
					output = new FileOutputStream(imageInstance.fullPath);
					byte[] buf = new byte[1024];
					int bytesRead;
					while ((bytesRead = input.read(buf)) > 0) {
						output.write(buf, 0, bytesRead);
					}
				} finally {
					input.close();
					output.close();
				}
				preference.addToImages(imageInstance).save(flush: true)
			}
		}
		else{
			for(image in images){
				def imageParams = image.split(",")
				def imageInstance = new Image()
				imageInstance.code = imageParams[0]
				imageInstance.fileName = imageParams[1]
				System.out.println(imageParams[0] + "-" + imageInstance[1])
				File storagePath = new File(grailsApplication.config.storageFolder + preference.id)
				if(!storagePath.exists()){
					try{
						storagePath.mkdirs();
					}
					catch(SecurityException se){
						println "Can't create storage path."
					}
				}
				imageInstance.fullPath = grailsApplication.config.storageFolder + preference.id + "/" + imageParams[0] + "-" + imageParams[1]
				InputStream input = null;
				OutputStream output = null;
				try {
					input = new FileInputStream(grailsApplication.config.uploadFolder + imageParams[0] + "-" + imageParams[1]);
					output = new FileOutputStream(imageInstance.fullPath);
					byte[] buf = new byte[1024];
					int bytesRead;
					while ((bytesRead = input.read(buf)) > 0) {
						output.write(buf, 0, bytesRead);
					}
				} finally {
					input.close();
					output.close();
				}
				preference.addToImages(imageInstance).save(flush: true)
			}
		}*/
	}
}
