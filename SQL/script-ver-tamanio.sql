
--
-- SCRIPT PARA MEDIR TAMAÑO TABLA, TAMAÑO BD Y PORCENTAJE DE USO
-- 

SELECT
    pg_size_pretty(pg_total_relation_size('tamanio')) AS tamanio_tabla,
    pg_size_pretty(pg_database_size(current_database())) AS tamanio_bd,
    ROUND(
        (pg_total_relation_size('tamanio')::numeric
        / pg_database_size(current_database())::numeric) * 100,
        2
    ) AS porcentaje_uso;