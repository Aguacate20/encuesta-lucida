-- Encuesta de empatizar · tabla aparte, no toca nada del juego.
create table if not exists public.encuesta_respuestas (
  id uuid primary key default gen_random_uuid(),
  creado timestamptz not null default now(),
  canal text,                      -- ?c=profes, ?c=ig…: por dónde llegó
  rol text,
  respuestas jsonb not null,       -- todas las respuestas, por clave de pregunta
  tutorial_completado boolean not null default false,
  segundos integer,                -- cuánto tardó en toda la encuesta
  dispositivo text                 -- 'movil' | 'escritorio'
);

alter table public.encuesta_respuestas enable row level security;

-- cualquiera puede ENVIAR una respuesta; nadie, desde la web, puede LEERLAS
create policy "encuesta: insertar anonimo"
  on public.encuesta_respuestas for insert
  to anon with check (true);

-- (no hay política de SELECT a propósito: las respuestas solo se ven desde el panel de Supabase)

-- vista rápida de totales, para mirar desde el editor SQL del panel
create or replace view public.encuesta_resumen as
select
  rol,
  count(*) as respuestas,
  count(*) filter (where tutorial_completado) as jugaron,
  round(avg((respuestas->>'divertido')::numeric), 2) as divertido_prom,
  round(avg((respuestas->>'entendi')::numeric), 2) as entendi_prom,
  round(avg((respuestas->>'aprendi')::numeric), 2) as aprendi_prom,
  round(avg((respuestas->>'recomendaria')::numeric), 2) as nps_prom,
  round(avg((respuestas->>'precio_bueno')::numeric)) as precio_bueno_prom,
  round(avg((respuestas->>'precio_caro')::numeric)) as precio_caro_prom
from public.encuesta_respuestas
group by rol;
