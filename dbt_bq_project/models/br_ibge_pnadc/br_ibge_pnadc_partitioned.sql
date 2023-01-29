{{ config(
    materialized='incremental',
    partition_by={
      "field": "ano",
      "data_type": "int64",
      "range": {
        "start": 2010,
        "end": 2015,
        "interval": 1
      }
    }
)}} 

SELECT 
    * 
FROM `bd-practices.base_dataset.br_ibge_pnadc` 
--ORDER BY YEAR DESC

{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  where ano > (select max(ano) from {{ this }})

{% endif %}