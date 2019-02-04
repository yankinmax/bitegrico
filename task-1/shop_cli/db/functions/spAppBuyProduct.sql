-- FUNCTION: external."spAppBuyProduct"(character varying(255), character varying(255), integer)

-- DROP FUNCTION external."spAppBuyProduct"(character varying(255), character varying(255), integer);

CREATE OR REPLACE FUNCTION external."spAppBuyProduct"(
    "pProductName" character varying(255),
    "pCustomerName" character varying(255),    
    "pQuantity" integer)
    RETURNS void
    LANGUAGE 'sql'

    COST 100
    VOLATILE 
AS $BODY$
  
insert into external."tbBroughtProducts"("ProductName", "CustomerName", "Price", "Weight", 
                    "Quantity", "BroughtPrice")
select ps."ProductName", 
        "pCustomerName",
        ps."Price",
        ps."Weight",
        "pQuantity", 
        ps."Price"*"pQuantity"
from external."tbProducts" as ps 
where "pProductName"=ps."ProductName";
$BODY$;
ALTER FUNCTION external."spAppBuyProduct"(character varying(255), character varying(255), integer)
    OWNER TO odoo;
