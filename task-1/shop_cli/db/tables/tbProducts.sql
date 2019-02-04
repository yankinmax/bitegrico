-- Table: external."tbProducts"

-- DROP TABLE external."tbProducts";

CREATE TABLE external."tbProducts"
(
    id serial,
    "ProductName" character varying(255) COLLATE pg_catalog."default" NOT NULL,
    "Brand" character varying(255) COLLATE pg_catalog."default",
    "ProductHash" character varying(50) COLLATE pg_catalog."default",
    "CostPrice" numeric(8,2),
    "Price" numeric(8,2),
    "Weight" numeric(6,2),
    CONSTRAINT "tbProducts_pkey" PRIMARY KEY ("ProductName", "Price", "Weight")
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE external."tbProducts"
    OWNER to postgres;