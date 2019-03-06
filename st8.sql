-- 集合演算 

select count(*) as row_cnt
from (
  select *
  from tbl_A
  union
  select *
  from tbl_B
) TMP;

select
  case when count(*) = 0
       then '等しい'
       else '異なる' end as result
from (
  (select * from tbl_A
   union
   select * from tbl_B)
   except
  (select * from tbl_A
   intersect
   select * from tbl_B)
) TMP;

-- テーブル同士のdiff
(select * from tbl_A
 except
 select * from tbl_B)
 union all
(select * from tbl_B
 except
 select * from tbl_A);

-- 差集合で関係除算（剰余を持った除算）
select distinct emp
from EmpSkills ES1
where not exists
  (select skill
   from Skills
   except
   select skill
   from EmpSkills ES2
   where ES1.emp = ES2.emp);