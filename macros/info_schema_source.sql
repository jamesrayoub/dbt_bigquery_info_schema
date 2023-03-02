{%- macro info_schema_source(info_schema_view, dataset, region='region-us') -%}
{%- if dataset -%}
`{{ target.database }}`.`{{ dataset }}`.INFORMATION_SCHEMA.{{ info_schema_view }}
{%- else -%}
`{{ target.database }}`.`{{ region }}`.INFORMATION_SCHEMA.{{ info_schema_view }}
{%- endif -%}
{%- endmacro -%}