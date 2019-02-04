-- Table: external."tbBroughtProducts"

-- DROP TABLE external."tbBroughtProducts";

CREATE TABLE external."tbBroughtProducts"
(
    id serial,
    "ProductName" character varying(255) COLLATE pg_catalog."default" NOT NULL,
    "CustomerName" character varying(255) COLLATE pg_catalog."default",
    "Price" numeric(8,2),
    "Weight" numeric(6,2),
    "Quantity" integer,
    "BroughtPrice" numeric(8,2),
    CONSTRAINT "tbBroughtProducts_pkey" PRIMARY KEY (id),
    CONSTRAINT "tbBroughtProducts_ProductName_fkey" FOREIGN KEY 
        ("ProductName", "Price", "Weight")
        REFERENCES external."tbProducts" ("ProductName", "Price", "Weight")

)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE external."tbBroughtProducts"
    OWNER to postgres;