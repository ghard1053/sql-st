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

