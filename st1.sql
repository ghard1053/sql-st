-- case

select case pref_name
    when '香川' then '四国'
    when '福岡' then '九州'
  else 'その他' end as district,
  sum(population)
from PopTbl
group by case pref_name
    when '香川' then '四国'
    when '福岡' then '九州'
  else 'その他' end;

select case
    when population < 100 then '01'
    when population >= 100 and population < 200 then '02'
    when population >= 200 and population < 300 then '03'
    when population >= 300 then '04'
  else null end as pop_class,
  count(*) as cnt
from PopTbl
group by case 
    when population < 100 then '01'
    when population >= 100 and population < 200 then '02'
    when population >= 200 and population < 300 then '03'
    when population >= 300 then '04'
  else null end;

select case pref_name
    when '香川' then '四国'
    when '福岡' then '九州'
  else 'その他' end as district,
  sum(population)
from PopTbl
group by district;


select pref_name,
        -- 男性の人口
      sum( case when sex = '1' then population else 0 end) as cnt_m,
        -- 女性の人口
      sum( case when sex = '2' then population else 0 end) as cnt_f
  from PopTbl2
  group by pref_name;


constraint check_salaly check
  ( case when sex = '2'
      then case when salary <= 200000
      then 1 else 0 end
    else 1 end = 1 )

constraint check_salaly check
  ( sex = "2" and salary <= 200000)


update Personnel
  set salary = case when salary >= 300000
                    then salary * 0.9
                    when salary >= 250000 and salary < 280000
                    then salary * 1.2
                else salary end;


update SomeTable
  set p_key = case
    when p_key = 'a'
    then 'b'
    when p_key = 'b'
    then 'a'
  else p_key end
where p_key in ('a', 'b');


select course_name,
    case when course_id in
      (select course_id from OpenCourses
        where month = 201806) then '○'
      else '×' end as "6月",
    case when course_id in
      (select course_id from OpenCourses
        where month = 201807) then '○'
      else '×' end as "7月",
    case when course_id in
      (select course_id from OpenCourses
        where month = 201808) then '○'
      else '×' end as "8月"
  from CourseMaster;

select CM.course_name,
    case when exists
      (select course_id from OpenCourses OC
        where month = 201806
          and OC.course_id = CM.course_id) then '○'
      else '×' end as "6月",
    case when exists
      (select course_id from OpenCourses OC
        where month = 201807
          and OC.course_id = CM.course_id) then '○'
      else '×' end as "7月",
    case when exists
      (select course_id from OpenCourses OC
        where month = 201808
          and OC.course_id = CM.course_id) then '○'
      else '×' end as "8月"
  from CourseMaster CM;


select std_id,
    case when count(*) = 1
      then max(club_id)
    else max(case when main_club_flg = 'Y'
      then club_id
      else null end) end as main_club
  from StudentClub
  group by std_id;