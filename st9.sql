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


select deal_date, 
       price, 
       case sign(
         price - max(price)
                   over(
                     order by deal_date
                     rows between 1 preceding
                     and 1 preceding
                   )
       )
       when 1 then 'up'
       when 0 then 'stay'
       when -1 then 'down' else null end as diff
from MyStock;

create VIEW MyStockUpSeq(deal_date, price, row_num) as
select deal_date, price, row_num
from (
  select deal_date, 
        price, 
        case sign(
          price - max(price)
                    over(
                      order by deal_date
                      rows between 1 preceding
                      and 1 preceding
                    )
        )
        when 1 then 'up'
        when 0 then 'stay'
        when -1 then 'down' else null end as diff,
        row_number() over(order by deal_date) as row_num
  from MyStock
) TMP
where diff = 'up';

select min(deal_date) as start_date,
       '~',
       max(deal_date) as end_date
from (select M1.deal_date,
             count(m2.row_num) - min(M1.row_num) as gap
      from MyStockUpSeq M1 inner join MyStockUpSeq M2
      on M2.row_num <= M1.row_num
      group by M1.deal_date) TMP
group by gap;

