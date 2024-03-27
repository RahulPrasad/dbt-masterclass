{% macro get_max_partition() -%}

{%- call statement('max_partition_timestamp', fetch_result=True) -%}
    SELECT MAX(DATE(partition_timestamp)) AS max_partition_timestamp FROM {{this}}
{%- endcall -%}

{% if execute %}
    {% set max_partition_timestamp = load_result('max_partition_timestamp')['data'][0][0] %}
{% else %}
    {% set max_partition_timestamp = '1900-01-01' %}
{% endif %}

CAST("{{ max_partition_timestamp }}" AS DATE)

{%- endmacro %}
