{{config(materialized='table')}}

with
  moby_dick as (select * from {{ref('moby_dick_base')}})
, words as (
  select

    word.value::string as word,
    count(*) as ct

  from moby_dick,

  lateral flatten (input => split(moby_dick.body, ' ')) word

  group by 1

  order by 2 desc
)

select
  *

from words
