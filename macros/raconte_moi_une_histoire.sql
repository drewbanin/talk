
{% macro get_lines(limit) %}

    -- call me ishmael
    {% call statement("get_lines", fetch_result=true) %}

        select body as line
        from {{ ref('moby_dick') }}
        limit {{ limit }}

    {% endcall %}

    {% set lines = load_result('get_lines').table.columns['line'].values() -%}
    {{ return(lines) }}

{% endmacro %}

{% macro log_it(line, delay=1) %}
    {{ log(line, info=True) }}
    {% call statement() %}
        select 1 as id from pg_sleep({{ delay }})
    {% endcall %}
{% endmacro %}


{% macro raconte_moi_une_histoire() %}

    -- {{ ref('moby_dick') }}

    {% if not execute %}
        {{ return([]) }}
    {% endif %}

    {% set lines = get_lines(limit=var('limit', 100)) %}

    {%- for line in lines %}
        {% set text = line_chunk | join("\n") %}
        {{ log_it(text, 5) }}
    {% endfor %}

{% endmacro %}
