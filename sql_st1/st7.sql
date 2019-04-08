-- outer join

select
  coalesce(A.id, B.id) as id,
  A.name as A_name,
  B.name as B_name
from Class_A A full outer join Class_B B
on A.id = B.id;

select A.id as id, A.name, B.name
from Class_A A left outer join Class_B
on A.id = B.id
union
select B.id as id, A.name, B.name
from Class_A A right outer join Class_B B
on A.id = B.id;

select A.id as id, A.name as A_name
from Class_A A left outer join Class_B B
on A.id = B.id
where B.name is null;

select B.id as id, B.name as B_name
from Class_A A right outer join Class_B B
on A.id = B.id
where A.name is null;

select
  coalesce(A.id, B.id) as id,
  coalesce(A.name, B.name) as name
from Class_A A full outer join Class_B B
on A.id = B.id
where A.name is null
  or B.nam is null;


select c0.name,
  case when c1.name is not null then '○' else null and as "SQL"
  case when c2.name is not null then '○' else null and as "UNIX"
  case when c3.name is not null then '○' else null and as "Java"
from (select distinct name from Courses) c0
left outer join
  (select name from Courses where course = 'SQL') c1
  on c0.name = c1.name
left outer join
  (select name from Courses where course = 'UNIX') c2
  on c0.name = c2.name
left outer join
  (select name from Courses where course = 'Java') c3
  on c0.name = c3.name

select 
  c0.name,
  (select '○'
   from Courses c1
   where course = 'SQL'
   and c1.name = c0.name) as 'SQL',
  (select '○'
   from Courses c2
   where course = 'UNIX'
   and c2.name = c0.name) as 'UNIX',
  (select '○'
   from Courses c3
   where course = 'Java'
   and c3.name = c0.name) as 'Java',
from (select distinct name from Courses) c0;

select name,
  case when sum(case when course = 'SQL' then 1 else null end) = 1
       then '○' else null end as "SQL",
  case when sum(case when course = 'UNIX' then 1 else null end) = 1
       then '○' else null end as "UNIX",
  case when sum(case when course = 'Java' then 1 else null end) = 1
       then '○' else null end as "Java"
from Courses
group by name;


select employee, child_1 as child from Personnel
union all
select employee, child_2 as child from Personnel
union all
select employee, child_3 as child from Personnel;

create view Children(child)
as 
  select child_1 from Personnel
union 
  select child_2 from Personnel
union
  select child_3 from Personnel

select EMP.employee, Children.child
from Personnel EMP
left outer join Children
on Children.child in (EMP.child_1, EMP.child_2, EMP.child_3);


select MASTER.age_class as age_class,
       MASTER.sex_cd as sex_cd,
       DATA.pop_tohoku as pop_tohoku,
       DATA.pop_kanto as pop_kanto
from (select age_class, sex_cd
      from TblAge cross join TblSex) MASTER
  left outer join
    (select age_class, sex_cd,
      sum(case when pref_name in ('青森', '秋田')
               then population else null end) as pop_tohoku,
      sum(case when pref_name in ('東京', '千葉')
               then population else null end) as pop_kanto
     from TblPop
     group by age_class, sex_cd) DATA
     on MASTER.age_class = DATA.age_class
     and MASTER.sex_cd = DATA.sex_cd;

select I.item_no, SH.total_qty
from Items I
  left outer join
    (select item_no, SUM(quantity) as total_qty
     from SalesHistory
     group by item_no) SH
  on I.item_no = SH.item_no;

select I.item_no, sum(SH.quantity) as total_qty
from Items I left outer join SalesHistory SH
on I.item_no = SH.item_no
group by I.item_no