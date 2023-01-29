{{
    config(
        materialized='incremental'
    )
}}

SELECT 
    * 
FROM `bd-practices.base_dataset.test_table_np` 
--ORDER BY YEAR DESC

{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  where year > (select max(year) from {{ this }})

{% endif %}