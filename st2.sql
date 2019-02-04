-- Window

select shohin_id, shohin_nama, hanbai_price,
    avg (hanbai_price) over 
      (order by shohin_id
        rows between 2 preceding and current row) as moving_avg
from Shohin;

select shohin_id, shohin_nama, hanbai_price,
    avg (hanbai_price) over w as moving_avg
  from Shohin
window w as (order by shohin_id
              rows between 2 preceding and current row);

select shohin_id, shohin_nama, hanbai_price,
    avg(hanbai_price)  over w as moving_avg,
    sum(hanbai_price)  over w as moving_sum,
    count(hanbai_price)  over w as moving_count,
    max(hanbai_price)  over w as moving_max
  from Shohin
window w as (order by shohin_id
              rows between 2 preceding and current row);


select sample_date as cur_date,
    min(sample_date)
      over (order by sample_date asc
            rows between 1 preceding and 1 preceding) as latest_date
  from LoadSample;

select sample_date as cur_date,
    load_val as cur_load,
    min(sample_date)
      over (order by sample_date asc
            rows between 1 preceding and 1 preceding) as latest_date,
    min(load_val)
      over (order by sample_date asc
            rows between 1 preceding and 1 preceding) as latest_load
  from LoadSample;

select sample_date as cur_date,
       load_val    as cur_load,
       min(sample_date) over w as latest_date,
       min(load_val)    over w as latest_load
  from LoadSample
window w as (order by sample_date asc
             rows between 1 preceding and 1 preceding);

select sample_date as cur_date,
       load_val    as cur_load,
       min(sample_date) over w as next_date,
       min(load_val)    over w as next_load
  from LoadSample
window w as (order by sample_date asc
             rows between 1 following and 1 following);

select sample_date as cur_date,
       load_val    as cur_load,
       min(sample_date)
         over (order by sample_date asc
               range between interval '1' day preceding
                         and interval '1' day preceding
              ) as day1_before,
       min(load_val)
         over (order by sample_date asc
               range between interval '1' day preceding
                         and interval '1' day preceding
              ) as load_day1_before
  from LoadSample;