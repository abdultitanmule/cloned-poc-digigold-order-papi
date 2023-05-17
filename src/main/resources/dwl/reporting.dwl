%dw 2.0
output application/csv header= false, separator= '|', bodyStartLineNumber = 1
import * from dw::core::Strings

fun addIndex(rootIndex, finalIndex) = [rootIndex + 1, finalIndex + 1]

fun getFinancialYear(date :Date) = do {
    var firstQuarter = 1 to 3
    var otherQuarter = 4 to 12
    ---

    if (firstQuarter contains (date as String { format: "M"} as Number))
    (date as String {format: "MMM"} ++ (date as String {format: "yy"} as Number - 1) ++ "-" ++ (date as String {format: "yy"} as Number ))
    else (date as String {format: "MMM"} ++ (date as String {format: "yy"}) ++ "-" ++ (date as String {format: "yy"} as Number + 1 ))
}

type roundUp = String {format: "0.00", roundMode:"HALF_DOWN"}

//index 0 --> Debit
//index 1 --> credit

---
flatten(payload.items map using ( item = $, rootIndex = $$) (
     addIndex(rootIndex, rootIndex + 1) map {
        FIELD1:"NEW",
        FIELD2:1,
        FIELD3:"INR",
        FIELD4:"DIGIGOLD",
        FIELD5:if($$ == 0) item.TOTAL_GOLD_AMOUNT as Number as roundUp else "",
        FIELD6:if($$ == 1) item.TOTAL_GOLD_AMOUNT as Number as roundUp else "",
        FIELD7:if($$ == 0) item.TOTAL_GOLD_AMOUNT as Number as roundUp else "",
        FIELD8:if($$ == 1) item.TOTAL_GOLD_AMOUNT as Number as roundUp else "",
        FIELD9:rootIndex + $,
        FIELD10:100,
        FIELD11:9081,
        FIELD12:(if(item.TRANSACTION_STATUS ~= "buy confirmed" and $$ == 0) 
				p('order-papi.buyConfirmed.debit')
            else if (item.TRANSACTION_STATUS ~= "buy confirmed" and $$ == 1)
                p('order-papi.buyConfirmed.credit')
			else if(item.TRANSACTION_STATUS ~= "redemption" and $$ == 0) 
				p('order-papi.redemption.debit')
			else p('order-papi.redemption.credit')),
        FIELD13:"JEWL",
        FIELD14:"TQ",
        FIELD15:"00",
        FIELD16:getFinancialYear(item.LASTUPDATED as LocalDateTime {format: p('dateformat.datadateformat')} as Date), 
        FIELD17:item.LASTUPDATED as LocalDateTime {format: p('dateformat.datadateformat')} as String{format: "dd-MMM-yy"},
        FIELD18:"DIGIGOLD",
        FIELD19:item.LASTUPDATED as LocalDateTime {format: p('dateformat.datadateformat')} as String{format: "dd-MMM-yy"},
        FIELD20:1058,
        FIELD21:"A",
        FIELD22:"4265",
        FIELD23:(if(item.TRANSACTION_STATUS ~= "buy confirmed" and $$ == 0) 
				("UEC" ++ item.LASTUPDATED as LocalDateTime {format: p('dateformat.datadateformat')} as String {format: "ddMMyyyy"} ++ "_Online")
            else if (item.TRANSACTION_STATUS ~= "buy confirmed" and $$ == 1)
                (item.TRANSACTION_ID)
			else item.TRANSACTION_ID),
        FIELD24:if(item.TRANSACTION_STATUS ~= "buy confirmed") item.DGORDER_ID else item.ADDITIONAL_FIELD2,
        FIELD25:(if(item.TRANSACTION_STATUS ~= "buy confirmed") 
				"DIGIGOLD BOND PURCHASE_ONLINE"
			    else  "DIGIGOLD BOND REDEMPTION_UEC"),
        FIELD26:rootIndex + $,
        FIELD27:"UEC",
        FIELD28:item.LASTUPDATED as LocalDateTime {format: p('dateformat.datadateformat')} as String{format: "dd-MMM-yy"},
        FIELD29: vars.outputReportName
    
    }
))
