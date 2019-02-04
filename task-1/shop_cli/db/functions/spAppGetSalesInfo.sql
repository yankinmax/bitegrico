-- FUNCTION: external."spAppGetSalesInfo"(character varying(255))

-- DROP FUNCTION external."spAppGetSalesInfo"(character varying(255));

CREATE OR REPLACE FUNCTION external."spAppGetSalesInfo"(
    "pProductName" character varying(255)
    )
    RETURNS TABLE("ProductName" character varying(255), "Brand" character varying(255),
                "Price" numeric(8,2), "Weight" numeric(6,2), "Quantity" integer, 
                "BroughtPrice" numeric(8,2), "CustomerName" character varying(255), 
                "Currency" character varying(3)) 
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE SECURITY DEFINER 
    ROWS 1000
AS $BODY$
begin
return query
    select tb."ProductName",
            (select ps."Brand" from external."tbProducts" ps 
                where ps."ProductName"="pProductName") as "Brand", 
            tb."Price", 
            tb."Weight", 
            tb."Quantity",
            tb."BroughtPrice",
            tb."CustomerName",             
            (select ps."Currency" from external."tbCustomers" ps 
                where ps."CustomerName"=tb."CustomerName") as "Currency" 
    from external."tbBroughtProducts" tb   
    where tb."ProductName"= "pProductName";
end;
$BODY$;

ALTER FUNCTION external."spAppGetSalesInfo"(character varying(255))
    OWNER TO odoo;

