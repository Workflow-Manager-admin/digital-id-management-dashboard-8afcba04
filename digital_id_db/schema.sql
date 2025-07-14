-- digital_id_db/schema.sql
-- PostgreSQL schema for Digital ID Management Dashboard
-- Defines: admins, users, digital_id_profiles, unique_numbers
-- Structure includes foreign keys, indexes, constraints, and explanatory comments

-- Table: admins
CREATE TABLE admins (
    id SERIAL PRIMARY KEY,
    username VARCHAR(64) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL, -- Store only hash, not raw password
    email VARCHAR(255) UNIQUE,
    is_superadmin BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Table: users
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(128) NOT NULL,
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(32),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Table: digital_id_profiles
CREATE TABLE digital_id_profiles (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    digital_id_number VARCHAR(64) UNIQUE NOT NULL,
    status VARCHAR(32) DEFAULT 'active',
    issued_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (user_id),
    CHECK (status IN ('active', 'suspended', 'revoked'))
);

-- Table: unique_numbers
CREATE TABLE unique_numbers (
    id SERIAL PRIMARY KEY,
    unique_number VARCHAR(64) NOT NULL UNIQUE,
    assigned_profile_id INTEGER REFERENCES digital_id_profiles(id) ON DELETE SET NULL,
    assigned_at TIMESTAMP WITH TIME ZONE,
    status VARCHAR(32) DEFAULT 'available',
    CHECK (status IN ('available', 'assigned', 'blocked'))
);

-- Relationships and Indexes

-- Index to efficiently find digital IDs by user
CREATE INDEX idx_digital_id_profiles_user_id ON digital_id_profiles(user_id);

-- Index for quick lookup of available unique numbers
CREATE INDEX idx_unique_numbers_status ON unique_numbers(status);

-- Index for searching users by email or phone
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_phone ON users(phone);

-- Additional security constraints for admin accounts can be defined at the application layer.

-- End of schema.sql
