{{ config(
    alias='microdados',

    schema='br_ibge_pnadc',

    materialized='incremental',

    partition_by={
      "field": "ano",
      "data_type": "int64",
      "range": {
        "start": 2010,
        "end": 2015,
        "interval": 1
      }
    },
    
    cluster_by = ["ano", "sigla_uf", "id_uf"]
)}} 

SELECT 
    CAST(ano AS INT64) ano,
    CAST(trimestre AS INT64) trimestre,
    CAST(id_uf AS STRING) id_uf,
    CAST(sigla_uf AS STRING) sigla_uf,
    CAST(V1028 AS FLOAT64) V1028,
FROM `bd-practices-staging.br_ibge_pnadc.microdados`
-- maybe we can put a condition here in order
-- to get only the new data

-- start: jinja section
{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  where ano > (select max(ano) from {{ this }})

{% endif %}
-- end: jinja section