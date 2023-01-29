{{ config(
    materialized='incremental',
    partition_by={
      "field": "year",
      "data_type": "int64",
      "range": {
        "start": 2000,
        "end": 2023,
        "interval": 1
      }
    }
)}} 

SELECT 
    * 
FROM `bd-practices.base_dataset.test_table_np` 
--ORDER BY YEAR DESC

{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  where year > (select max(year) from {{ this }})

{% endif %}