%dw 2.0
output application/json
---
{
	"transactionId": correlationId,
	"errorCode": vars.errorCode default error.errorType.identifier,
	"errorMessage": vars.errorMessage default error.description,
	"errorDescription": error.errorDescription default error.detailedDescription,
	"timestamp" : now()
}