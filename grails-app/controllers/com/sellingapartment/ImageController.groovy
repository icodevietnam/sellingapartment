package com.sellingapartment

import grails.plugin.springsecurity.annotation.Secured

class ImageController {
	/*@Secured(['ROLE_ADMIN', 'ROLE_USER', 'ROLE_ANONYMOUS'])
	def tempFileInfo() {
		[fileId: params['fileId'], fileName: params['fileName']]
	}
	
	@Secured(['ROLE_ADMIN', 'ROLE_USER', 'ROLE_ANONYMOUS'])
	def upload() {
		def file = params.get('file')
		long fileId = System.currentTimeMillis() + 123
		if(file.empty) {
			flash.message = "File cannot be empty"
		} else {
			File storagePath = new File(grailsApplication.config.uploadFolder)
			if(!storagePath.exists()){
				try{
					storagePath.mkdirs();
				}
				catch(SecurityException se){
					println "Can't create storage path."
				}
			}
			file.transferTo(new File(grailsApplication.config.uploadFolder + fileId + "-" + file.originalFilename))
		}
		redirect (action: 'tempFileInfo', params: [fileId: fileId, fileName: file.originalFilename])
	}
	
	@Secured(['ROLE_ADMIN', 'ROLE_USER', 'ROLE_ANONYMOUS'])
	def downloadTempFile(String id) {
		response.setContentType("APPLICATION/OCTET-STREAM")
		response.setHeader("Content-Disposition", "Attachment;Filename=\"${params['fileName']}\"")
		def file = new File(grailsApplication.config.uploadFolder + id + "-" + params['fileName'])
		System.out.println(file.getAbsolutePath())
		def fileInputStream = new FileInputStream(file)
		def outputStream = response.getOutputStream()
		byte[] buffer = new byte[4096];
		int len;
		while ((len = fileInputStream.read(buffer)) > 0) {
			outputStream.write(buffer, 0, len);
		}
		outputStream.flush()
		outputStream.close()
		fileInputStream.close()
	}
	
	@Secured(['ROLE_ADMIN', 'ROLE_USER', 'ROLE_ANONYMOUS'])
	def downloadFile(String id) {
		response.setContentType("APPLICATION/OCTET-STREAM")
		response.setHeader("Content-Disposition", "Attachment;Filename=\"${params['fileName']}\"")
		def file = new File(grailsApplication.config.storageFolder + params['apartmentId'] + "/" + id + "-" + params['fileName'])
		def fileInputStream = new FileInputStream(file)
		def outputStream = response.getOutputStream()
		byte[] buffer = new byte[4096];
		int len;
		while ((len = fileInputStream.read(buffer)) > 0) {
			outputStream.write(buffer, 0, len);
		}
		outputStream.flush()
		outputStream.close()
		fileInputStream.close()
	}
	
	@Secured(['ROLE_ADMIN', 'ROLE_USER', 'ROLE_ANONYMOUS'])
	def get(String id) {
		response.setContentType("image/jpg")
		response.setHeader("Content-Disposition", "Attachment;Filename=\"${params['fileName']}\"")
		def file = new File(grailsApplication.config.storageFolder + params['apartmentId'] + "/" + id + "-" + params['fileName'])
		def fileInputStream = new FileInputStream(file)
		def outputStream = response.getOutputStream()
		byte[] buffer = new byte[4096];
		int len;
		while ((len = fileInputStream.read(buffer)) > 0) {
			outputStream.write(buffer, 0, len);
		}
		outputStream.flush()
		outputStream.close()
		fileInputStream.close()
	}*/
}
