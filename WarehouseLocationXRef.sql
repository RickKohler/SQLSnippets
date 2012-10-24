select
  coalesce(mi.PartNumber,mo.PartNumber) as PartNumber,
  
  coalesce(mi.AreaDesignator,'') as MillburyArea,
  coalesce(cast(mi.Rack as varchar(12)),'') as MillburyRack,
  coalesce(cast(mi.Shelf as varchar(12)),'') as MillburyShelf,
  coalesce(cast(mi.Slot as varchar(12)),'') as MillburySlot,
  
  coalesce(mo.AreaDesignator,'') as MonclovaArea,
  coalesce(cast(mo.Rack as varchar(12)),'') as MonclovaRack,
  coalesce(cast(mo.Shelf as varchar(12)),'') as MonclovaShelf,
  coalesce(cast(mo.Slot as varchar(12)),'') as MonclovaSlot

from PartNumberLocations mi
full join PartNumberLocationsTest mo
on mi.PartNumber=mo.PartNumber
  
order by
  coalesce(mi.AreaDesignator,''),
  coalesce(cast(mi.Rack as varchar(12)),''),
  coalesce(cast(mi.Shelf as varchar(12)),''),
  coalesce(cast(mi.Slot as varchar(12)),'')
