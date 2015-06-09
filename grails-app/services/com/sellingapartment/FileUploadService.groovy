package com.sellingapartment

import grails.transaction.Transactional;

import org.codehaus.groovy.grails.web.context.ServletContextHolder;
import org.springframework.web.multipart.MultipartFile;

@Transactional
class FileUploadService {
	
	def fileUploadService
	
	def String uploadFile(MultipartFile file,String name, String destinationDirectory){
		
		def servletContext = ServletContextHolder.servletContext
		def storagePath = servletContext.getRealPath(destinationDirectory);
		
		//Create storage path directory if it does not exist
		
		def storagePathDirectory = new File(storagePath)
		if(!storagePathDirectory.exists()){
			print "CREATING DIRECTORY ${storagePath}:"
			if(storagePathDirectory.mkdir()){
				println "SUCCESS"
			}
			else{
				println "FAILED"
			}
		}
		
		if(!file.isEmpty()){
			file.transferTo(new File("${storagePath}/${name}"))
			println "Saved file: ${storagePath}/${name} "
			return "${storagePath}/${name}"
		}
		else{
			println "File ${file.inspect()} was empty"
			return null
		}
	}
	
	def save(String name,String destinationDirectory){
		def image = params['image'].toString()
		if(!image.isEmpty()){
			fileUploadService.uploadFile(image, name, destinationDirectory)
		}
	}

}
