{{config(materialized='table')}}

with
  moby_dick as (select * from {{ref('moby_dick_base')}})
, words as (
  select

    word,
    count(*) as ct

  from moby_dick,

  unnest(string_to_array(moby_dick.body, ' ')) word

  group by 1

  order by 2 desc
)

select
  *

from words
