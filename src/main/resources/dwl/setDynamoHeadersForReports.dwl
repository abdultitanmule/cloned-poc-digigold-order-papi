 %dw 2.0
import p from Mule
output application/java
---
{
	("KeyLastUpdatedInMillis": payload.lastEvaluatedKey.LASTUPDATED_INMILLIS.n) if (payload.lastEvaluatedKey?),
	("KeyTransactionId": payload.lastEvaluatedKey.TRANSACTION_ID.n) if (payload.lastEvaluatedKey?),
	"client_secret" : p('secure::digigold-order-papi.clientSecret'),
	"X-Correlation-Id" : correlationId,
	"x-source-channel" : p('dynamo-sapi.sourceChannel'),
	"client_id" : p('secure::digigold-order-papi.clientId'),
	"ReportType" : 
	    (if(payload.reportType != p('reports.transactionConsolidatedReport.reportType'))
	      payload.reportType
	    else
	      p('reports.transactionReport.reportType')),
	"StartDate" : payload.variables.startDate,
	"EndDate" : payload.variables.endDate	
}