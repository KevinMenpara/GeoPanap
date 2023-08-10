-- +migrate Up
CREATE TABLE instructions (id SERIAL PRIMARY KEY, path TEXT, size TEXT, mime_type TEXT, created_at TIMESTAMP WITH TIME ZONE);
