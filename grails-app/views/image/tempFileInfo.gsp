<li class="imageItem">
	<input class="hidden" type="text" name="images" value="${fileId + "," + fileName}" />
	<g:link action="downloadTempFile" id="${fileId}" params="[fileName: "${fileName}"]">
		${fileName}
	</g:link>
</li>