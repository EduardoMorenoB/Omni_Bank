ALTER TABLE core.accounts
    ADD COLUMN iban VARCHAR(34);

ALTER TABLE core.accounts
    ADD CONSTRAINT uq_accounts_iban UNIQUE (iban);

ALTER TABLE core.customers
    ADD COLUMN credit_score INTEGER;

ALTER TABLE core.customers
    ADD CONSTRAINT chk_customers_credit_score_range
    CHECK (credit_score BETWEEN 300 AND 850);

CREATE TYPE core.loan_status_enum AS ENUM (
    'ACTIVE',
    'PAID',
    'DEFAULTED',
    'CANCELLED'
);

ALTER TABLE core.loans
    ALTER COLUMN status DROP DEFAULT;

ALTER TABLE core.loans
    ALTER COLUMN status TYPE core.loan_status_enum
    USING status::core.loan_status_enum;

ALTER TABLE core.loans
    ALTER COLUMN status
    SET DEFAULT 'ACTIVE'::core.loan_status_enum;