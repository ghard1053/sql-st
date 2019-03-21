-- チューニング

-- IN, EXISTS
-- 遅い
select *
from Class_A
where id in (select id from Class_B);

-- 速い
select *
from Class_A A
where exists (
  select *
  from Class_B B
  where A.id = B.id
);

-- INの方が可読性が高い
-- INのパフォーマンスも改善してきている

-- INを結合で代用
select A.id, A.name
from Class_A A inner join Class_B B
on A.id = B.id;



-- DISTINCTをEXISTSで代用
-- DISTINCT
select distinct I.item_no
from Items I inner join SalesHistory SH
on I.item_no = SH.item_no;

-- EXISTS
select item_no
from Items I
where exists (
  select *
  from SalesHistory SH
  where I.item_no = SH.item_no
);



-- WHERE句で書ける条件はHAVING句には書かない
select sale_date, sum(quantity)
from SalesHistory
group by sale_date
having sale_date = '2007-10-01';

select sale_date, sum(quantity)
from SalesHistory
where sale_date = '2007-10-01'
group by sale_date;



-- index
-- indexが使用されない
select * from SomeTable where col_1 * 1.1 > 100;
-- indexが使用される
select * from SomeTable where col_1 > 100 / 1.1;

-- 左辺に関数を適用していてもindexが使用されない
select * from SomeTable where substr(col_1, 1, 1) = 'a';

-- indexが利用できない　is null, is not null, <>, !=, not in

-- LIKEは前方一致検索のみ
select * from SomeTable where col_1 like 'a%';

-- 暗黙の型変換は行わない
select * from SomeTable where col_1 = '10';
select * from SomeTable where col_1 = cast(10, as char(2));



-- 中間テーブルを減らす
-- 無駄な中間テーブル
select *
from (
  select sale_date, max(quantity) as max_qty
  from SalesHistory
  group by sale_date
) TMP -- 無駄
where max_qty >= 10;

-- HAVINGを使用する
select sale_date, max(quantity)
from SalesHistory
group by sale_date
having max(quantity) >= 10;

-- INで複数のキーを使用する場合は, １つにまとめる
select id, state, city
from Addresses1 A1
where state in (
  select state
  from Addresses2 A2
  where A1.id = A2.id
)
and city in (
  select city
  from Addresses2 A2
  where A1.id = A2.id
);

select *
from Addresses1 A1
where id || state || city in (
  select id || state || city
  from Addresses2 A2
);

select *
from Addresses1 A1
where (id, state, city) in (
  select id, state, city
  from Addresses2 A2
);

