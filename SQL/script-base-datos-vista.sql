
--
-- ESTA VISTA  ES UNA HERRAMIENTA ESPECIAL PARA REALIZAR CONSULTAS
-- 
-- Operaciones completas
-- Nombres de departamento, municipio, producto, cantidad, precio y monto
-- La corregimos para añadir id_region.
-- DROP VIEW vista_operaciones
CREATE VIEW vista_operaciones AS
SELECT
    ope.id_registro,

    dep.nombre  AS departamento,
    ope.id_departamento,

    reg.nombre  AS region,
    ope.id_region,

    mun.nombre  AS municipio,
    ope.id_municipio,

    pro.nombre  AS producto,
    ope.id_producto,

    ope.fecha,
    ope.cantidad,
    pro.precio,
    ope.cantidad * pro.precio AS venta,
    ope.estado

FROM operaciones ope
JOIN departamentos dep ON dep.id_departamento = ope.id_departamento
JOIN municipios    mun ON mun.id_municipio    = ope.id_municipio
JOIN productos     pro ON pro.id_producto     = ope.id_producto
LEFT JOIN regiones reg ON reg.id_region       = ope.id_region

ORDER BY
    reg.nombre,
    dep.nombre,
    mun.nombre,
    pro.nombre;