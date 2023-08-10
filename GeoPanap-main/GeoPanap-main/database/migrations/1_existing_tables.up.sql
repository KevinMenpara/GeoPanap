-- +migrate Up
CREATE TABLE IF NOT EXISTS gmail_accounts (
    id BIGSERIAL PRIMARY KEY,
    email text,
    password bytea,
    created_at TIMESTAMP WITH TIME ZONE,
    updated_at TIMESTAMP WITH TIME ZONE
);

CREATE table IF NOT EXISTS customers (
    id BIGSERIAL PRIMARY KEY,
    name text,
    tel_number text,
    gmail_account_id bigint,
    created_at TIMESTAMP WITH TIME ZONE,
    updated_at TIMESTAMP WITH TIME ZONE,
    constraint fk_customers_gmail_account_id FOREIGN KEY(gmail_account_id) REFERENCES gmail_accounts(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS minerals (
    id BIGSERIAL PRIMARY KEY,
    name TEXT,
    created_at TIMESTAMP WITH TIME ZONE,
    deleted_at TIMESTAMP WITH TIME ZONE
);


CREATE TABLE IF NOT EXISTS leases (
    id BIGSERIAL PRIMARY KEY,
    survey_number text,
    customer_id bigint,
    "area" text,
    villege text,
    taluka text,
    city text,
    mineral_id BIGINT,
    expiry_date date,
    created_at TIMESTAMP WITH TIME ZONE,
    updated_at TIMESTAMP WITH TIME ZONE,
    constraint fk_leases_customer_id FOREIGN KEY(customer_id) REFERENCES customers(id) ON DELETE CASCADE,
    constraint fk_leases_mineral_id FOREIGN KEY(mineral_id) REFERENCES minerals(id) ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS contacts (
    id BIGSERIAL PRIMARY KEY,
    lease_id bigint,
    name text,
    tel_number text,
    created_at TIMESTAMP WITH TIME ZONE,
    updated_at TIMESTAMP WITH TIME ZONE,
    constraint fk_contacts_lease_id FOREIGN KEY(lease_id) REFERENCES leases(id) ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS lease_notes (
    id BIGSERIAL PRIMARY KEY,
    lease_id bigint,
    note text,
    is_current bool default false,
    created_at TIMESTAMP WITH TIME ZONE,
    constraint fk_lease_notes_lease_id FOREIGN KEY(lease_id) REFERENCES leases(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS ec_records (
    id BIGSERIAL PRIMARY KEY,
    lease_id bigint,
    expiry_date date,
    environmental_password bytea,
    status text,
    presentation_date date,
    created_at TIMESTAMP WITH TIME ZONE,
    updated_at TIMESTAMP WITH TIME ZONE,
    constraint fk_ec_records_lease_id FOREIGN KEY(lease_id) REFERENCES leases(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS ec_notes (
    id BIGSERIAL PRIMARY KEY,
    ec_id bigint,
    note text,
    is_current bool default false,
    created_at TIMESTAMP WITH TIME ZONE,
    constraint fk_ec_notes_ec_id FOREIGN KEY(ec_id) REFERENCES ec_records(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS ec_documents (
    id BIGSERIAL PRIMARY KEY,
    ec_id bigint,
    path text,
    size text,
    mime_type text,
    created_at TIMESTAMP WITH TIME ZONE,
    constraint fk_ec_documents_ec_id FOREIGN KEY(ec_id) REFERENCES ec_records(id) ON DELETE CASCADE,
    UNIQUE(ec_id, path)
);

CREATE TABLE IF NOT EXISTS gpcb_records (
    id BIGSERIAL PRIMARY KEY,
    lease_id bigint,
    ifp_id text,
    ifp_password bytea,
    gpcb_id text,
    gpcb_password bytea,
    noc_status text,
    cca_status text,
    udhyog_aadhar text,
    created_at TIMESTAMP WITH TIME ZONE,
    updated_at TIMESTAMP WITH TIME ZONE,
    constraint fk_gpcb_records_lease_id FOREIGN KEY(lease_id) REFERENCES leases(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS gpcb_notes (
    id BIGSERIAL PRIMARY KEY,
    gpcb_id bigint,
    note text,
    is_current bool default false,
    created_at TIMESTAMP WITH TIME ZONE,
    constraint fk_gpcb_notes_gpcb_id FOREIGN KEY(gpcb_id) REFERENCES gpcb_records(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS gpcb_documents (
    id BIGSERIAL PRIMARY KEY,
    gpcb_id bigint,
    path text,
    size text,
    mime_type text,
    created_at TIMESTAMP WITH TIME ZONE,
    constraint fk_gpcb_documents_gpcb_id FOREIGN KEY(gpcb_id) REFERENCES gpcb_records(id) ON DELETE CASCADE,
    unique(gpcb_id, path)
);

CREATE TABLE IF NOT EXISTS other_documents (
    id BIGSERIAL PRIMARY KEY,
    lease_id bigint,
    path text,
    size text,
    mime_type text,
    created_at TIMESTAMP WITH TIME ZONE,
    constraint fk_other_documents_lease_id FOREIGN KEY(lease_id) REFERENCES leases(id) ON DELETE CASCADE,
    UNIQUE(lease_id, path)
);

CREATE EXTENSION pgcrypto;
