with 

WesternTerritory as (
select State_ID
from UpdatedNightly.dbo.StatesAndDC
where SalesRegion in (5,8)
union
select 'TX'
union
select 'BC'
union
select 'YT'
)

select 
  'SSC' as SoldBy,
  smy.STATE as ShippedTo,
  iv.ITMCLSCD,
  iv.ITMGEDSC,
  iv.ITMSHNAM,
  det.ITEMNMBR, 
  iv.ITEMDESC,
  det.QUANTITY,
  det.XTNDPRCE
from DataWarehouse.dbo.SOP30200 smy
join DataWarehouse.dbo.SOP30300 det
on smy.SOPNUMBE=det.SOPNUMBE
and smy.SOPTYPE=det.SOPTYPE
join DataWarehouse.dbo.IV00101 iv
on det.ITEMNMBR=iv.ITEMNMBR

where smy.SOPTYPE=3
and smy.docdate >= dateadd(day, -365, current_timestamp)
and iv.ITMCLSCD in ('DRAIN INV','DRAINCABLE','DSHIP-JTTR')
and smy.STATE in (select STATE_ID from WesternTerritory)
and smy.CUSTNMBR<>'124630'

union all

select 
  'SSW' as SoldBy,
  smy.STATE as ShippedTo,
  iv.ITMCLSCD,
  iv.ITMGEDSC,
  iv.ITMSHNAM,
  det.ITEMNMBR, 
  iv.ITEMDESC,
  det.QUANTITY,
  det.XTNDPRCE
from GPWest.dbo.SOP30200 smy
join GPWest.dbo.SOP30300 det
on smy.SOPNUMBE=det.SOPNUMBE
and smy.SOPTYPE=det.SOPTYPE
join GPWest.dbo.IV00101 iv
on det.ITEMNMBR=iv.ITEMNMBR

where smy.SOPTYPE=3
and smy.docdate >= dateadd(day, -365, current_timestamp)
and iv.ITMCLSCD in ('DRAIN INV','DRAINCABLE','DSHIP-JTTR')
and smy.STATE in (select STATE_ID from WesternTerritory)
and smy.CUSTNMBR<>'124630'

order by 
  ITMCLSCD,
  ITMGEDSC,
  ITMSHNAM,
  ITEMNMBR
