-- Table: external."tbCurrency"

-- DROP TABLE external."tbCurrency";

CREATE TABLE external."tbCurrency"
(
    "Currency" character varying(3) COLLATE pg_catalog."default" NOT NULL,
    "Description" character varying(25) COLLATE pg_catalog."default",
    CONSTRAINT "tbCurrency_pkey" PRIMARY KEY ("Currency")
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

INSERT INTO external."tbCurrency" VALUES ('UAH', 'Hryvnia');
INSERT INTO external."tbCurrency" VALUES ('USD', 'Dollar');
INSERT INTO external."tbCurrency" VALUES ('EUR', 'Euro');
INSERT INTO external."tbCurrency" VALUES ('GBP', 'Pound Sterling');
										
ALTER TABLE external."tbCurrency"
    OWNER to odoo;
	
