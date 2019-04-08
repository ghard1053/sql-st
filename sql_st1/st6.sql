-- window 2

select year, current_sale
  from (select year,
               sale as current_sale,
               sum(sale) over (order by year
                               range between 1 preceding
                                     and 1 preceding) as pre_sale
        from Sales) TMP
  where current_sale = pre_sale
  order by year;

select year, current_sale as sale
  case when current_sale = pre_sale
       then '→'
       when current_sale > pre_sale
       then '↑'
       when current_sale < pre_sale
       then '↓'
  else '-' end as var
from (select year,
             sale as current_sale,
             sum(sale) over (order by year
                             range between 1 preceding
                                   and 1 preceding) as pre_sale
      from Sales) TMP
order by year;

select year, current_sale
  from (
    select 
      year,
      sale as current_sale,
      sum(sale) over (order by year
                      rows between 1 preceding
                           and 1 preceding) as pre_sale
    from Sales2) TMP
  where current_sale = pre_sale
  order by year;

  select shohin_mei, shohin_bunrui, hanbai_tanka
  from (select shohin_mei, shohin_bunrui, hanbai_tanka, avg(hanbai_tanka)
        over (partition by shohin_bunrui) as avg_tanka
        from Shohin) TMP
  where hanbai_tanka > avg_tanka;

select reserver, next_reserver
from (
  select
    reserver,
    start_date,
    end_date,
    MAX(start_date)
      over (
        order by start_date
        rows between 1 following
            and 1 following
      ) as next_start_date,
    MAX(reserver)
      over (
        order by start_date
        rows between 1 following
            and 1 following
      ) as next_reserver
  from Reservations
) TMP
where next_start_date between start_date and end_date;