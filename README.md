# BigQuery Information Schema dbt Package
# 📣 What does this dbt package do?
- Materializes staging views and persists documentation so you no longer have to reference the documentation when composing a query. Currently includes:
    - JOBS
    - JOBS_TIMELINE
    - COLUMNS
    - TABLE_OPTIONS
    - TABLE_STORAGE
    - TABLES
    - VIEWS
    - ASSIGNMENTS
    - ASSIGNMENT_CHANGES
    - CAPACITY_COMMITMENTS
    - CAPACITY_COMMITMENT_CHANGES
    - RESERVATIONS
    - RESERVATION_CHANGES
- Incrementally builds tables (i.e. JOBS, JOBS_TIMELINE, etc.) to remove the 180 day data rentention barrier.
- Provides insightful models to help answer questions like:
  - If I switch from on-demand pricing to capacity-compute pricing, how many slots should I reserve?
  - Am I building/storing tables which are hardly used?

# 🎯 How do I use the dbt package?
## Step 1: Prerequisites
To use this dbt package, you must have the following:
- An account with the following IAM permissions:
  - bigquery.jobs.listAll
  - bigquery.tables.get
  - bigquery.tables.list
  - bigquery.routines.get
  - bigquery.routines.list
  - bigquery.reservationAssignments.list (_if capacity-compute pricing_)
  - bigquery.capacityCommitments.list (_if capacity-compute pricing_)
  - bigquery.reservations.list (_if capacity-compute pricing_)

## Step 2: Install the package
Include the package in your `packages.yml` file.
docs.getdbt.com/docs/package-management) for more information on installing packages.
```yaml
packages:
  - git: "https://github.com/jamesrayoub/dbt_bigquery_info_schema.git" # git URL
    revision: 0.0.1 # tag or branch name
```
## Step 3: Set variable for capacity-compute pricing (if applicable)
If you use capacity-compute pricing, you'll need to set the `capacity_compute_pricing_enabled` variable equal to `true` in your `dbt_project.yml` file to enable staging models related to reservations.


```yml
# dbt_project.yml
vars:
  bigquery_info_schema:
    capacity_compute_pricing_enabled: false
```

## (Optional) Step 4: Additional configurations

### Change the build schema
By default, this package builds the models within a schema titled (`<target_schema>` + `_bq_info_schema`) in your destination. If this is not where you would like your data to be written to, add the following configuration to your root `dbt_project.yml` file:

```yml
models:
    bigquery_info_schema:
      +schema: my_new_schema_name # leave blank for just the target_schema
```

# 🙌 Contributions
Reach out to me on dbt Slack (@James Ayoub) or raise an issue or pull request on GitHub!
