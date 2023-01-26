# Dbt and BigQuery: setup and practices


Export GCP credentials
```bash
export GOOGLE_APPLICATION_CREDENTIALS='/tmp/my_key.json'
```

BQ source tables:
- test_table_np: **non partitioned** table containing date, year, and value (random numver)
- test_table_pp: **partitioned** table containing date, year, and value (random numver)