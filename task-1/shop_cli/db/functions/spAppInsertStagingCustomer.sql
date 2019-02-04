-- FUNCTION: external."spAppInsertStagingCustomer"(text, integer, character varying(5))

-- DROP FUNCTION external."spAppInsertStagingCustomer"(text, integer, character varying(5));

CREATE OR REPLACE FUNCTION external."spAppInsertStagingCustomer"(
	"pCustomerName" text,
	"pDiscount" integer,
	"pCurrency" character varying(5)
	)
    RETURNS void
    LANGUAGE 'sql'

    COST 100
    VOLATILE 
AS $BODY$

INSERT INTO external."tbCustomers"(
		"CustomerName", "Discount", "Currency")
VALUES ("pCustomerName", "pDiscount", "pCurrency");

$BODY$;

ALTER FUNCTION external."spAppInsertStagingCustomer"(text, integer, character varying(5))
    OWNER TO odoo;