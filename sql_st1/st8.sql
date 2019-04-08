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

-- 等しい部分集合
select SP1.sup as s1, SP2.sup as s2
from SupParts SP1, SupParts SP2
where SP1.sup < SP2.sup
and SP1.part = SP2.part
group by SP1.sup, SP2.sup
having count(*) = (
  select count(*)
  from SupParts SP3
  where SP3.sup = SP1.sup
) and count(*) = (
  select count(*)
  from SupParts SP4
  where SP4.sup = SP2.sup
);

-- 重複行を削除する高速なクエリ
delete from Products
where rowid in (
  select rowid
  from Products
  except
  select max(rowid)
  from Products
  group by name, price
);

delete from Products
where rowid not in (
  select max(rowid)
  from Products
  group by name, price
);