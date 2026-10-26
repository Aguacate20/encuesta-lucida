# Encuesta Lúcida (empatizar)

Página estática: `index.html` + `config.js` + `andy.png`. No necesita build.

## 1. Supabase (una sola vez)
En el panel de Supabase → SQL Editor → pega `supabase.sql` y ejecútalo.
Crea la tabla `encuesta_respuestas` (aparte de las del juego) y la vista `encuesta_resumen`.

## 2. Configurar
Edita `config.js`:
- `SUPABASE_URL` y `SUPABASE_ANON_KEY`: Supabase → Settings → API (URL y clave `anon public`).
- `JUEGO_URL`: la dirección del juego en Vercel con `?demo=1` al final.

## 3. Subir a Vercel
Opción rápida (sin git): vercel.com → Add New → Project → arrastra esta carpeta.
Opción con git: crea un repo (p. ej. `EdTechEncuesta`), sube estos archivos, impórtalo en Vercel.
Framework: "Other". Sin comando de build. Directorio de salida: `.` (raíz).

## 4. Rotarla
Enlace base: `https://TU-ENCUESTA.vercel.app/`
Por canal, para saber de dónde llega cada respuesta:
- `?c=profes`, `?c=estudiantes`, `?c=directivos`, `?c=ig`, `?c=whatsapp`…

## 5. Ver respuestas
Supabase → Table Editor → `encuesta_respuestas`, o en SQL Editor: `select * from encuesta_resumen;`
Exportar a CSV: Table Editor → botón Export.
