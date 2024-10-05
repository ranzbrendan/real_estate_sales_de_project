{# -- put this in macros/generate_schema_name.sql #}
{% macro generate_schema_name(custom_schema_name=none, node=none) -%}
    {%- set default_schema = target.schema -%}
    {%- if target.name == 'ci' -%}
        real_estates_project_db1
    {%- else -%}
        {{ default_schema }}
    {%- endif -%}
{%- endmacro %}