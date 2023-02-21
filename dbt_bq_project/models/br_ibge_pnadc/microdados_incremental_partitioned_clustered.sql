{{ config(
    alias='microdados',

    schema='br_ibge_pnadc',

    materialized='incremental',

    partition_by={
      "field": "ano",
      "data_type": "int64",
      "range": {
        "start": 2010,
        "end": 2025,
        "interval": 1
      }
    },
    
    cluster_by = ["ano", "sigla_uf", "id_uf"]
)}} 

--## TODO: select all columns
WITH pnadc_microdados AS (
  SELECT 
      CAST(ano       AS INT64)         ano,
      CAST(trimestre AS INT64)   trimestre,
      CAST(id_uf     AS STRING)      id_uf,
      CAST(sigla_uf  AS STRING)   sigla_uf,
      CAST(V1028     AS FLOAT64)     V1028,
  FROM `bd-practices-staging.br_ibge_pnadc.microdados`
)
SELECT 
    * 
from pnadc_microdados

{% if is_incremental() %}
  -- this filter will only be applied on an incremental run

  -- selecting the maximum year in the materialized table (if already exists) if it is
  -- greater than current yearl. Else, it brings the current year
  {% set max_year = run_query(
    "SELECT max_year from (
      SELECT 
        IF(MAX(ano) > EXTRACT(YEAR FROM CURRENT_DATE('America/Sao_Paulo')),
          EXTRACT(YEAR FROM CURRENT_DATE('America/Sao_Paulo')), 
          MAX(ano)) AS max_year 
      FROM" ~ this ~")"
    ).columns[0].values()[0] 
  %}

  WHERE ano = {{ max_year }} AND

  trimestre > (SELECT max(trimestre) FROM {{ this }} WHERE ano = {{ max_year }})

{% endif %}
-- end: jinja section