-- exists

select distinct M1.meeting, M2.person
from Meetings M1 cross join Meetings M2;

select distinct M1.meeting, M2.person
from Meetings M1 cross join Meetings M2
where not exists
  (select *
   from Meetings M3
   where M1.meeting = M3.meeting
   and M2.person = M3.person);

select M1.meeting, M2.person
from Meetings M1, Meetings M2
except
select meeting, person
from Meetings;


select distinct student_id
from TestScores TS1
where not exists
  (select *
   from TestScores TS2
   where TS2.student_id = TS1.student_id
   and TS2.score < 50);

select distinct student_id
from TestScores TS1
where subject in ('math', 'english')
and not exists
  (select *
   from TestScores TS2
   where TS2.student_id = TS1.student_id
   and 1 = case when subject = 'math' and score < 80 then 1
                when subject = 'english' and score < 50 then 1
                else 0 end);

select distinct student_id
from TestScores TS1
where subject in ('math', 'english')
and not exists
  (select *
   from TestScores TS2
   where TS2.student_id = TS1.student_id
   and 1 = case when subject = 'math' and score < 80 then 1
                when subject = 'english' and score < 50 then 1
                else 0 end)
group by student_id
having count(*) = 2;


select project_id
from Projects
group by project_id
having count(*) = sum(case when step_nbr <= 1 and status = 'finish' then 1
                           when step_nbr  > 1 and status = 'waitting' then 1
                           else 0 end);

select *
from Projects P1
where not exists
  (select status
   from Projects P2
   where P1.project_id = P2.project_id
   and status <> case when step_nbr <= 1
                      then 'finish'
                      else 'waitting' end);
