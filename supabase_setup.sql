-- STREAMING_CHUNK:Creating database extensions and table schemas for Kisan Dost...

-- Enable UUID Extension if needed
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 1. Create PROFILES Table to store farmer registration info
CREATE TABLE IF NOT EXISTS public.profiles (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id TEXT NOT NULL UNIQUE,
    mobile VARCHAR(15) NOT NULL,
    district VARCHAR(100) NOT NULL,
    mandal VARCHAR(100) NOT NULL,
    lang VARCHAR(10) DEFAULT 'en',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Create BOOKINGS Table to persist machinery & service orders
CREATE TABLE IF NOT EXISTS public.bookings (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id TEXT NOT NULL,
    provider_name TEXT NOT NULL,
    owner_name TEXT NOT NULL,
    phone VARCHAR(15) NOT NULL,
    location TEXT NOT NULL,
    hours VARCHAR(20) NOT NULL,
    total VARCHAR(20) NOT NULL,
    payment_type VARCHAR(20) NOT NULL,
    status VARCHAR(50) DEFAULT 'En Route',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- STREAMING_CHUNK:Setting up Row Level Security (RLS) policies for anonymous and authenticated access...

-- Enable RLS on both tables
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.bookings ENABLE ROW LEVEL SECURITY;

-- Allow Public/Anon users to SELECT, INSERT, and UPDATE profiles
CREATE POLICY "Allow public read profiles" ON public.profiles FOR SELECT USING (true);
CREATE POLICY "Allow public insert profiles" ON public.profiles FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow public update profiles" ON public.profiles FOR UPDATE USING (true);

-- Allow Public/Anon users to SELECT and INSERT bookings
CREATE POLICY "Allow public read bookings" ON public.bookings FOR SELECT USING (true);
CREATE POLICY "Allow public insert bookings" ON public.bookings FOR INSERT WITH CHECK (true);
