-- having

select case when count(*) = 0 or min(seq) > 1 then 1
            else (select min(seq + 1)
                  from SeqTbl S1
                  where not exists
                    (select *
                     from SeqTbl S2
                     where S2.seq = S1.seq + 1)) end
  from SeqTbl;

select income, count(*) as cnt
from Graduates
group by income
having count(*) >= all 
  (select count(*)
   from Graduates
   group by income);

select income, count(*) as cnt
from Graduates
group by income
having count(*) >=
  (select max(cnt)
   from (select count(*) as cnt
         from Graduates
         group by income) TMP );

select dpt
from Students
group by dpt
having count(*) = count(sbmt_date);

select dpt
from Students
group by dpt
having count(*) = sum(case when sbmt_date is not null
                        then 1 else 0 end);

select class
from TestResults
group by class
having count(*) * 0.75
  <= sum(case when score >= 80
            then 1
            else 0 end);

select class
from TestResults
group by class
having sum(case when score >= 50 and sex = 'men'
            then 1 else 0 end)
      > sum(case when score >= 50 and sex = 'women'
            then 1 else 0 end);

select class
from TestResults
group by class
having avg(case when sex = 'men' then score else 0 end)
  < avg(class when sex = 'women' then score else 0 end)

select class
from TestResults
group by class
having avg(case when sex = 'men' then score else null end)
  < avg(class when sex = 'women' then score else null end)

select team_id, member
from Teams T1
where not exists
  (select *
   from Teams T2
   where T1.team_id = T2.team_id
   and status <> 'wait');

select team_id
from Teams
group by team_id
having count(*) 
  = sum(case when status = 'wait' then 1 else 0 end);

select team_id
from Teams
group by team_id
having max(status) = 'wait'
  and min(status) = 'wait';

select team_id,
  case when max(status) = 'wait' and min(status) = 'wait'
    then 'スタンバイ'
    else '不足' end as status
from Teams group by team_id;

select center
from Materials
group by center
having count(material) <> count(distinct material);

select center,
  case when count(material) <> count(distinct material)
    then '余りあり'
    else '余りなし'
    end as status
from Materials
group by center;

select center, material
from Materials M1
where exists
  (select *
   from Materials M2
   where M1.center = M2.center
   and M1.receive_date <> M2.receive_date
   and M1.material = M2.material);

select SI.shop
from ShopItems SI inner join Items I
on SI.item = I.item
group by SI.shop
having count(SI.item) = (select count(item from Items));

select SI.shop
from ShopItems SI left outer join Items I
on SI.item = I.item
group by SI.shop
having count(SI.item) = (select count(item) from Items)
  and  count(I.item) = (select count(item) from Items);

