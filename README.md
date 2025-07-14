# digital-id-management-dashboard-8afcba04

## Database Schema Overview

The PostgreSQL database is structured for secure and flexible Admin Dashboard operations:

**Tables:**
- `admins`: Stores administrator accounts with hashed passwords. Supports super-admin flag.
- `users`: Represents individuals/holders managed by the system.
- `digital_id_profiles`: Each `user` can have one digital ID profile, identified by a unique digital ID number. Profile status can be `active`, `suspended`, or `revoked`.
- `unique_numbers`: Pool of unique numbers (tokens, IDs, etc). Can be assigned to a digital ID profile, or remain available.

**Relationships:**
- `digital_id_profiles.user_id` references `users(id)`, enforcing one-to-one mapping.
- `unique_numbers.assigned_profile_id` references `digital_id_profiles(id)`, allowing linkage of numbers to digital IDs.

**Indexes:**
- Created for frequent queries (by user, email, status, etc) to optimize dashboard responsiveness.

**Seeding:**
- The `seed.sql` script inserts an initial super admin (username: 'admin', password hash for 'admin123'), example users, and available unique numbers.
- Update the hash for any production/deployment with a secure, freshly generated hash.

**How to Apply:**
1. Load schema: `psql <schema.sql>`
2. Seed data: `psql <seed.sql>`

Passwords are always stored hashed; never store raw passwords.
