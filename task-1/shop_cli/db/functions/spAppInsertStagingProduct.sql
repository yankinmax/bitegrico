-- FUNCTION: external."spAppInsertStagingProduct"(text, text, numeric(8,2), numeric(8,2), numeric(6,2))

-- DROP FUNCTION external."spAppInsertStagingProduct"(text, text, numeric(8,2), numeric(8,2), numeric(6,2));

CREATE OR REPLACE FUNCTION external."spAppInsertStagingProduct"(
	"pProductName" text,
	"pBrand" text,
	"pCostPrice" numeric(8,2),
	"pPrice" numeric(8,2),
	"pWeight" numeric(6,2)
	)
    RETURNS void
    LANGUAGE 'sql'

    COST 100
    VOLATILE 
AS $BODY$

update external."tbProducts" as pu    
    set 
        "CostPrice" = "pCostPrice"::decimal,
        "Price" = "pPrice"::decimal,
        "Weight" = "pWeight"::decimal   
    where pu."ProductName"="pProductName";
  
insert into external."tbProducts"(
		"ProductName", "Brand", 
		"ProductHash", "CostPrice", "Price", "Weight")
select "pProductName", 
		"pBrand", 
		md5("pProductName"), 
		"pCostPrice", 
		"pPrice", 
		"pWeight"
where not exists 
        (select ps."ProductName" from external."tbProducts" as ps 
            where ps."ProductName" = "pProductName");

$BODY$;

ALTER FUNCTION external."spAppInsertStagingProduct"(text, text, numeric(8,2), numeric(8,2), numeric(6,2))
    OWNER TO odoo;