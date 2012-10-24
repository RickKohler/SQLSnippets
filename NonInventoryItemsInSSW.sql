select *
from iv00101
where itemtype > 3
and itmgedsc not like 'COUPON'
and itmgedsc not like 'FEE'
and itmgedsc not like 'SPRING END'
and itmgedsc not like 'SHOPSUP'
and itmgedsc not like 'NO CHARGE'
and itmgedsc not like 'HANDLING'
and itmgedsc not like 'TOR END'
and itemnmbr not in ('3000','3001','3005','3010','SOLOSE','CLIPSE','MISCDOOR')
order by itemnmbr
