-- Execute no SQL Editor se o projeto Supabase já possui a tabela books.
alter table public.books add column if not exists sample_text text;
-- Preencha sample_text apenas com capítulo autorizado ou texto em domínio público.
-- Não armazene capítulos protegidos sem licença.
