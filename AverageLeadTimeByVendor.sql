select
  VendorID,
  count(*) as NumberOfItemsSupplied,
  avg(avrgldtm * 0.01) as AverageLeadTime
  
from IV00103

group by VendorID

order by VendorID
;
