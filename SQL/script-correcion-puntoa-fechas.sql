-- 
-- Punto 6 - Tipo A (casos especiales)
-- 
-- Registros identificados:
--   10001  "-21-4--20"   corrupto → imputado 2024-06-15
--   18056  "09-09-24"    formato DD-MM-YY
--   11599  "08-02-24"    formato DD-MM-YY
--   12110  "-17--0-02"   corrupto → imputado 2024-06-15
--   14368  "10-28-24"    formato americano MM-DD-YY
--   15955  "09-27-24"    formato americano MM-DD-YY
--   16558  "24-02-01"    formato YY-MM-DD
-- 

-- Caso 1: Formato DD-MM-YY
UPDATE public.operaciones
SET fecha = '20' || substring(fecha,7,2) || '-'
          || LPAD(substring(fecha,4,2),2,'0') || '-'
          || LPAD(substring(fecha,1,2),2,'0')
WHERE id_registro IN (18056, 11599);

-- Caso 2: Formato americano MM-DD-YY
UPDATE public.operaciones
SET fecha = '20' || substring(fecha,7,2) || '-'
          || LPAD(substring(fecha,1,2),2,'0') || '-'
          || LPAD(substring(fecha,4,2),2,'0')
WHERE id_registro IN (14368, 15955);

-- Caso 3: Formato YY-MM-DD
UPDATE public.operaciones
SET fecha = '20' || substring(fecha,1,2) || '-'
          || substring(fecha,4,2) || '-'
          || substring(fecha,7,2)
WHERE id_registro = 16558;

-- Caso 4: Fechas corruptas, se imputa fecha central del año
UPDATE public.operaciones
SET fecha = '2024-06-15'
WHERE id_registro IN (10001, 12110);

-- Para verificar al final: debe devolver 0 filas
SELECT id_registro, fecha
FROM public.operaciones
WHERE fecha !~ '^\d{4}-\d{2}-\d{2}$';