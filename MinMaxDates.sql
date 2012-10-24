declare @SchemaName nvarchar(128);
declare @TableName nvarchar(128);
declare @ColumnName nvarchar(128);
declare @MinDate datetime;
declare @MaxDate datetime;

declare @qry nvarchar(4000);

declare @MinMaxDates table (SchemaName nvarchar(128), TableName nvarchar(128), ColumnName nvarchar(128), MinDate datetime, MaxDate datetime);

declare curs cursor for 

with

DataTypes(system_type_id) as (
  select system_type_id
  from sys.types
  where [name] like '%date%'
)

,

TablesAndColumns(SchemaName, TableName, ColumnName) as (
  select 
    sch.name as SchemaName,
    tab.name as TableName,
    col.name as ColumnName
  
  from datatypes typ
  join sys.columns col
  on typ.system_type_id=col.system_type_id
  join sys.tables tab
  on col.object_id=tab.object_id
  join sys.schemas sch
  on tab.schema_id=sch.schema_id
)

select 
  rtrim(SchemaName) as SchemaName,
  rtrim(TableName) as TableName,
  rtrim(ColumnName) as ColumnName,
  'SELECT @MinDateOut = MIN(' + rtrim(ColumnName) + '), @MaxDateOut = MAX(' + rtrim(ColumnName) + ') FROM ' + rtrim(SchemaName) + '.' + rtrim(TableName) + ' WHERE ' + rtrim(ColumnName) + '>''1900-12-31'' AND ' + rtrim(ColumnName) + '<''9999-01-01'';' as qry
from TablesAndColumns
order by SchemaName, TableName, ColumnName
;

open curs;

fetch next from curs into @SchemaName, @TableName, @ColumnName, @qry;

while @@fetch_status = 0
  begin
  
  execute sp_executesql @qry, N'@MinDateOut datetime output, @MaxDateOut datetime output', @MinDateOut=@MinDate output, @MaxDateOut=@MaxDate output;
  
  insert into @MinMaxDates
    select @SchemaName, @TableName, @ColumnName, @MinDate, @MaxDate
    where @MinDate is not null
    ;
  
  fetch next from curs into @SchemaName, @TableName, @ColumnName, @qry;
  end;
  
close curs;
deallocate curs;

select * from @MinMaxDates;
