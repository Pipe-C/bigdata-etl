
--
-- SCRIPT PARA CORREGIR id_region SALGA = 0; LE ASIGNAMOS ID A PARTIR DE id_departamento.
-- 

UPDATE operaciones o
SET id_region = d.codigo_region
FROM departamentos d
WHERE d.id_departamento = o.id_departamento;

SELECT id_region, COUNT(*)
FROM operaciones
GROUP BY id_region;