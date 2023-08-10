-- +migrate Up
CREATE TABLE audit_logs ("id" SERIAL PRIMARY KEY, "subject" text, "action" text, "resource" text, "object" text, "created_at" TIMESTAMP WITH TIME ZONE);
