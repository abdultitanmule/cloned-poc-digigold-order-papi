%dw 2.0
import p from Mule
import toBase64 from dw::core::Binaries
output application/json
---
{
	"from": p('reportsEmail.from'),
  	(to: (p('reportsEmail.to') splitBy  "," ) )  if (!isEmpty(p('reportsEmail.to')) ),  
 	 (cc: (p('reportsEmail.cc') splitBy  "," ) )  if (!isEmpty(p('reportsEmail.cc')) ),  				
	"subject": vars.reportType ++ " Attachments",
	"body": vars.emailTemplate,
//	"body": vars.reportType ++ " Attachments",
	"bodyType": p('reportsEmail.contentType'),
	"attachments": [{
		"name": (vars.reportType replace " " with "") ++ "s.zip",
		"content": toBase64(write(payload, "application/octet-stream")),
		"contentType": "application/zip"
	}]
}