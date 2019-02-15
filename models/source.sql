
with gen as (
    select
        row_number() over (order by random()) as i
    from {{ ref('moby_dick') }}
)

select
    now() - (interval '1 minute' * i) as loaded_at

from gen
