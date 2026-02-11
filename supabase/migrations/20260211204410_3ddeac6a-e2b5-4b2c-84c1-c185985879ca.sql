
-- user_roles table (used by has_role RPC)
CREATE TABLE public.user_roles (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL,
  role TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(user_id, role)
);
ALTER TABLE public.user_roles ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can read own roles" ON public.user_roles FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Service role manages roles" ON public.user_roles FOR ALL USING (true) WITH CHECK (true);

-- has_role function
CREATE OR REPLACE FUNCTION public.has_role(_user_id UUID, _role TEXT)
RETURNS BOOLEAN
LANGUAGE sql
STABLE
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT EXISTS (SELECT 1 FROM public.user_roles WHERE user_id = _user_id AND role = _role);
$$;

-- profiles table
CREATE TABLE public.profiles (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID NOT NULL UNIQUE,
  display_name TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can read own profile" ON public.profiles FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can update own profile" ON public.profiles FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Users can insert own profile" ON public.profiles FOR INSERT WITH CHECK (auth.uid() = user_id);

-- leads table
CREATE TABLE public.leads (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT,
  phone TEXT,
  message TEXT,
  source TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.leads ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Anyone can insert leads" ON public.leads FOR INSERT WITH CHECK (true);
CREATE POLICY "Admins can read leads" ON public.leads FOR SELECT USING (public.has_role(auth.uid(), 'admin'));

-- couple_ministry_signups table
CREATE TABLE public.couple_ministry_signups (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  phone TEXT,
  email TEXT,
  message TEXT,
  source_slug TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.couple_ministry_signups ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Anyone can insert signups" ON public.couple_ministry_signups FOR INSERT WITH CHECK (true);
CREATE POLICY "Admins can read signups" ON public.couple_ministry_signups FOR SELECT USING (public.has_role(auth.uid(), 'admin'));

-- kids_ministry_signups table
CREATE TABLE public.kids_ministry_signups (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  source_slug TEXT,
  parent_name TEXT NOT NULL,
  child_name TEXT NOT NULL,
  child_age INT,
  phone TEXT,
  email TEXT,
  message TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.kids_ministry_signups ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Anyone can insert kids signups" ON public.kids_ministry_signups FOR INSERT WITH CHECK (true);
CREATE POLICY "Admins can read kids signups" ON public.kids_ministry_signups FOR SELECT USING (public.has_role(auth.uid(), 'admin'));

-- children table
CREATE TABLE public.children (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT,
  birth_date DATE,
  allergies TEXT,
  notes TEXT,
  active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.children ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Authenticated users can read children" ON public.children FOR SELECT USING (auth.uid() IS NOT NULL);
CREATE POLICY "Authenticated users can insert children" ON public.children FOR INSERT WITH CHECK (auth.uid() IS NOT NULL);
CREATE POLICY "Authenticated users can update children" ON public.children FOR UPDATE USING (auth.uid() IS NOT NULL);

-- checkins table
CREATE TABLE public.checkins (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  child_id UUID NOT NULL REFERENCES public.children(id),
  status TEXT NOT NULL DEFAULT 'checked_in',
  checked_in_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  checked_out_at TIMESTAMPTZ,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.checkins ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Authenticated users can read checkins" ON public.checkins FOR SELECT USING (auth.uid() IS NOT NULL);
CREATE POLICY "Authenticated users can insert checkins" ON public.checkins FOR INSERT WITH CHECK (auth.uid() IS NOT NULL);
CREATE POLICY "Authenticated users can update checkins" ON public.checkins FOR UPDATE USING (auth.uid() IS NOT NULL);

-- events table
CREATE TABLE public.events (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  starts_at TIMESTAMPTZ,
  active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.events ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Authenticated users can read events" ON public.events FOR SELECT USING (auth.uid() IS NOT NULL);
CREATE POLICY "Authenticated users can insert events" ON public.events FOR INSERT WITH CHECK (auth.uid() IS NOT NULL);

-- assistant_conversations table
CREATE TABLE public.assistant_conversations (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL DEFAULT 'Conversa',
  created_by UUID NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.assistant_conversations ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can read own conversations" ON public.assistant_conversations FOR SELECT USING (auth.uid() = created_by);
CREATE POLICY "Users can insert own conversations" ON public.assistant_conversations FOR INSERT WITH CHECK (auth.uid() = created_by);
CREATE POLICY "Users can update own conversations" ON public.assistant_conversations FOR UPDATE USING (auth.uid() = created_by);

-- assistant_messages table
CREATE TABLE public.assistant_messages (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  conversation_id UUID NOT NULL REFERENCES public.assistant_conversations(id) ON DELETE CASCADE,
  role TEXT NOT NULL,
  content TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.assistant_messages ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Users can read messages of own conversations" ON public.assistant_messages FOR SELECT USING (
  EXISTS (SELECT 1 FROM public.assistant_conversations WHERE id = conversation_id AND created_by = auth.uid())
);
CREATE POLICY "Users can insert messages to own conversations" ON public.assistant_messages FOR INSERT WITH CHECK (
  EXISTS (SELECT 1 FROM public.assistant_conversations WHERE id = conversation_id AND created_by = auth.uid())
);

-- finance_monthly table
CREATE TABLE public.finance_monthly (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  month DATE NOT NULL UNIQUE,
  tithes NUMERIC NOT NULL DEFAULT 0,
  offerings NUMERIC NOT NULL DEFAULT 0,
  donations NUMERIC NOT NULL DEFAULT 0,
  expenses NUMERIC NOT NULL DEFAULT 0,
  notes TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.finance_monthly ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Authenticated users can read finance" ON public.finance_monthly FOR SELECT USING (auth.uid() IS NOT NULL);
CREATE POLICY "Admins can manage finance" ON public.finance_monthly FOR ALL USING (public.has_role(auth.uid(), 'admin'));

-- ministries table (for ministry-media edge function)
CREATE TABLE public.ministries (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  slug TEXT NOT NULL UNIQUE,
  title TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.ministries ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Anyone can read ministries" ON public.ministries FOR SELECT USING (true);
CREATE POLICY "Admins can manage ministries" ON public.ministries FOR ALL USING (public.has_role(auth.uid(), 'admin'));

-- ministry_image_cache table
CREATE TABLE public.ministry_image_cache (
  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
  ministry_id UUID NOT NULL UNIQUE REFERENCES public.ministries(id),
  images JSONB NOT NULL DEFAULT '[]',
  sources JSONB,
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
ALTER TABLE public.ministry_image_cache ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Anyone can read image cache" ON public.ministry_image_cache FOR SELECT USING (true);
CREATE POLICY "Admins can manage image cache" ON public.ministry_image_cache FOR ALL USING (public.has_role(auth.uid(), 'admin'));
