-- Table: external."tbCustomers"

-- DROP TABLE external."tbCustomers";

CREATE TABLE external."tbCustomers"
(
    id serial,
    "CustomerName" character varying(255) COLLATE pg_catalog."default" NOT NULL,
    "Discount" integer,
    "Currency" character varying(5) COLLATE pg_catalog."default",
    CONSTRAINT "tbCustomers_pkey" PRIMARY KEY ("CustomerName"),
    CONSTRAINT "tbCustomers_Currency_fkey" FOREIGN KEY ("Currency")
        REFERENCES external."tbCurrency" ("Currency") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE external."tbCustomers"
    OWNER to postgres;