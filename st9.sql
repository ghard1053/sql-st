-- 数列

select D1.digit + (D2.digit * 10) as seq
from Digits D1 cross join Digits D2
order by seq;

create VIEW Sequence (seq) as
select D1.digit + (D2.digit * 10) + (D3.digit * 100)
from Digits D1
  cross join Digits D2
  cross join Digits D3;

select seq
from Sequence
where seq between 1 and 100
order by seq;

select seq
from Sequence
where seq between 1 and 12
except
select seq
from SeqTbl;

select seq
from Sequence
where seq between 1 and 12
and seq not in (
  select seq from SeqTbl
);


select S1.seat as start_seat, '~' , S2.seat as end_seat
from Seats S1, Seats S2
where S2.seat = S1.seat + (:head_cnt - 1)
and not exists (
  select *
  from Seats S3
  where S3.seat between S1.seat and S2.seat
  and S3.status <> '空'
);

select seat, '~', seat + (:head_cnt - 1)
from (
  select seat,
         max(seat)
          over(order by seat
               rows between (:head_cnt - 1) following
                    and (:head_cnt - 1) following )
                    as end_seat
  from Seats
  where status = '空'
) TMP
where end_seat - seat = (:head_cnt - 1);


select S1.seat as start_seat, '~' , S2.seat as end_seat
from Seats S1, Seats S2
where S2.seat = S1.seat + (:head_cnt - 1)
and not exists (
  select *
  from Seats S3
  where S3.seat between S1.seat and S2.seat
  and S3.status <> '空' or S3.line_id <> S1.line_id
);

select seat, '~', seat + (:head_cnt - 1)
from (
  select seat,
         max(seat)
          over(
            partition by line_id
            order by seat
            rows between (:head_cnt - 1) following
            and (:head_cnt - 1) following
          ) as end_seat
  from Seats
  where status = '空'
) TMP
where end_seat - seat = (:head_cnt - 1);

