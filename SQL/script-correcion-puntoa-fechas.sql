-- Registros identificados (fechas originales en la fuente):
--   10001  "-21-4--20"   corrupto  → imputado 2024-06-15
--   11599  "08-02-24"    DD-MM-YY  → 2024-02-08
--   12110  "-17--0-02"   corrupto  → imputado 2024-06-15
--   14368  "10-28-24"    MM-DD-YY  → 2024-10-28
--   15955  "09-27-24"    MM-DD-YY  → 2024-09-27
--   16558  "24-02-01"    YY-MM-DD  → 2024-02-01
--   18056  "09-09-24"    DD-MM-YY  → 2024-09-09
-- =============================================================================

UPDATE public.operaciones SET fecha = '2024-06-15' WHERE id_registro = 10001;
UPDATE public.operaciones SET fecha = '2024-02-08' WHERE id_registro = 11599;
UPDATE public.operaciones SET fecha = '2024-06-15' WHERE id_registro = 12110;
UPDATE public.operaciones SET fecha = '2024-10-28' WHERE id_registro = 14368;
UPDATE public.operaciones SET fecha = '2024-09-27' WHERE id_registro = 15955;
UPDATE public.operaciones SET fecha = '2024-02-01' WHERE id_registro = 16558;
UPDATE public.operaciones SET fecha = '2024-09-09' WHERE id_registro = 18056;

-- Verificacion: debe devolver 0 filas
SELECT id_registro, fecha
FROM public.operaciones
WHERE fecha !~ '^\d{4}-\d{2}-\d{2}$';