-- 

select count(*) as row_cnt
from (
  select *
  from tbl_A
  UNION
  select *
  from tbl_B
) TMP;