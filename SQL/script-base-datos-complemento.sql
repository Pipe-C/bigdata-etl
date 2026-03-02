-- BASE DE DATOS "bigdata"
-- d. Funciones de validación de fechas
-- e. Tabla regiones
-- f. Modificación de tabla operaciones (campo id_region)
-- d. FUNCIONES DE VALIDACIÓN DE FECHAS
-- Formato válido: AAAA-MM-DD

-- Función 1: Retorna TRUE si el formato de fecha es válido
CREATE OR REPLACE FUNCTION fecha_formato_valido(p_fecha VARCHAR)
RETURNS BOOLEAN AS $$
BEGIN
    RETURN p_fecha ~ '^\d{4}-\d{2}-\d{2}$';
END;
$$ LANGUAGE plpgsql;

-- Función 2: Retorna TRUE si además de tener buen formato, la fecha existe en el calendario
CREATE OR REPLACE FUNCTION fecha_valida(p_fecha VARCHAR)
RETURNS BOOLEAN AS $$
BEGIN
    PERFORM p_fecha::date;
    RETURN TRUE;
EXCEPTION
    WHEN others THEN RETURN FALSE;
END;
$$ LANGUAGE plpgsql;

-- Pruebas:
-- SELECT fecha_formato_valido('2024-01-15');  -- TRUE
-- SELECT fecha_formato_valido('15-01-2024');  -- FALSE
-- SELECT fecha_valida('2024-02-30');          -- FALSE (no existe en el calendario)
-- SELECT fecha_valida('2024-02-28');          -- TRUE


-- =============================================================================
-- e. TABLA REGIONES
-- Regiones de Colombia según el DANE
-- =============================================================================

-- DROP TABLE IF EXISTS public.regiones;
CREATE TABLE IF NOT EXISTS public.regiones (
    id_region integer      NOT NULL,
    nombre    varchar(60)  NOT NULL,
    CONSTRAINT regiones_pkey PRIMARY KEY (id_region)
);

INSERT INTO regiones (id_region, nombre) VALUES
    (1, 'Region Caribe'),
    (2, 'Region Centro Oriente'),
    (3, 'Region Centro Sur'),
    (4, 'Region Eje Cafetero - Antioquia'),
    (5, 'Region Llano'),
    (6, 'Region Pacifico')
ON CONFLICT (id_region) DO NOTHING;

-- SELECT * FROM regiones;


-- =============================================================================
-- f. MODIFICAR TABLA OPERACIONES: agregar campo id_region
-- =============================================================================

ALTER TABLE public.operaciones
    ADD COLUMN IF NOT EXISTS id_region integer DEFAULT 0;

-- Poblar id_region a partir del codigo_region de cada departamento
UPDATE public.operaciones o
SET    id_region = d.codigo_region
FROM   public.departamentos d
WHERE  d.id_departamento = o.id_departamento;

-- Verificar:
-- SELECT id_registro, id_departamento, id_region, fecha, estado FROM operaciones LIMIT 20;
