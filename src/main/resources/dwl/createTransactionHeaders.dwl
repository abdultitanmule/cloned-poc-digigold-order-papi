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
} 