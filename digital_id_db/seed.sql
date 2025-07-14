-- digital_id_db/seed.sql
-- Seed data for Digital ID Management Dashboard database
-- IMPORTANT: Password hash below is an example (bcrypt for 'admin123').

-- Seed: initial super admin
INSERT INTO admins (username, password_hash, email, is_superadmin)
VALUES (
    'admin',
    '$2b$12$uQiCF3r5Mpi5TtIFpHE8SOwV1H82Ss6NgTJe7Ubd5PUJJyXD5Afy.', -- admin123 (bcrypt, 12 rounds)
    'admin@example.com',
    TRUE
);

-- Example user/holder record
INSERT INTO users (full_name, email, phone, is_active)
VALUES
('Alice Holder', 'alice.holder@example.com', '+1234567890', TRUE),
('Bob Profile', 'bob.profile@example.com', '+1987654321', TRUE);

-- Example digital ID profiles (one per user), status 'active'
INSERT INTO digital_id_profiles (user_id, digital_id_number, status)
VALUES
(1, 'DID-0001-ALICE', 'active'),
(2, 'DID-0002-BOB', 'active');

-- Example unique numbers (not yet assigned)
INSERT INTO unique_numbers (unique_number, status)
VALUES
('UN-20240001', 'available'),
('UN-20240002', 'available'),
('UN-20240003', 'available'),
('UN-20240004', 'available');

-- Link a unique number to digital_id_profile
-- (example: assign 'UN-20240001' to Alice's profile)
UPDATE unique_numbers
SET assigned_profile_id = 1, assigned_at = CURRENT_TIMESTAMP, status = 'assigned'
WHERE unique_number = 'UN-20240001';

-- End of seed.sql
