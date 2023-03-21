%dw 2.0

var customerGrouped=vars.customerSearchResponse groupBy $.CUSTOMER_NO
fun lookupCustomer(MEMBER_ID) =
    customerGrouped[MEMBER_ID][0]
output application/csv
---
payload.items map ((item) -> 
    {
    "SAFEGOLD_USERID": (customerGrouped[item.MEMBER_ID])[0].SAFEGOLD_USERID,
    "EMAIL": 	(customerGrouped[item.MEMBER_ID])[0].EMAIL,
    "MOBILEPHONE": (customerGrouped[item.MEMBER_ID])[0].MOBILEPHONE,
    ("PAY_TRANSACTION_ID": item.DGORDER_ID ++ "_" ++ item.TRANSACTION_ID) if(payload.reportType == p('reports.dropOrderReport.reportType')),
    ("REGISTRATION_DATE": (customerGrouped[item.MEMBER_ID])[0].REGISTRATION_DATE) if(payload.reportType != p('reports.dropOrderReport.reportType')),   
    ("SAFEGOLDTRANSACTION_ID": item.TRANSACTION_ID) if(payload.reportType != p('reports.dropOrderReport.reportType')),
    "TRANSACTION_DATE": item.TRANSACTION_DATE,
    "RATE_ID": item.RATE_ID,
    "GOLD_RATE": item.GOLD_RATE ,
    "GRAMS_PURCHASED": item.GRAMS_PURCHASED,
    "TOTALAMOUNT_INR": item.TOTAL_GOLD_AMOUNT,
    "TRANSACTION_TYPE": item.TRANSACTION_TYPE,
    "CHANNEL": item.CHANNEL,
    "PAYMENT_GATEWAY": item.PAYMENT_GATEWAY,
    "PAYMENT_METHOD": item.PAYMENT_METHOD,
    "TRANSACTION_STATUS": item.TRANSACTION_STATUS,
    ("SAFEGOLDTRANSACTION_ID": item.TRANSACTION_ID) if(payload.reportType == p('reports.dropOrderReport.reportType'))
    }
)


//payload.items map ((item) -> 
//	((customerGrouped[item.MEMBER_ID])[0] default {}) - 'CUSTOMER_NO' 
//	++ item
//)