-- +migrate Up
ALTER TABLE leases ADD COLUMN name text, ADD COLUMN type text;
