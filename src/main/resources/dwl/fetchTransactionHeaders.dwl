%dw 2.0
import p from Mule
output application/json
---
{
  
  "x-correlation-id": attributes.headers."x-correlation-id",
  "x-source-channel": attributes.headers."x-source-channel",
  "x-target-channel": attributes.headers."x-target-channel",
  "client_id": p('secure::digigold-order-papi.clientId'),
  "client_secret": p('secure::digigold-order-papi.clientSecret'),
  "MemberId": attributes.headers."memberid",
  "ReportType": attributes.headers."reporttype",
  "StartDate": attributes.headers."startdate",
  "EndDate": attributes.headers."enddate",
  "KeyLastUpdatedInMillis": attributes.headers."keylastupdatedinmillis",
  "KeyTransactionId": attributes.headers."keytransactionid",
  "KeyMemberId": attributes.headers."keymemberid",
} filterObject ((value, key, index) -> value != null)


  
  