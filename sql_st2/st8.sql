
-- Window

SELECT shohin_mai, shohin_bunrui, hanbai_tanka,
       RANK () OVER (
         PARTITION BY shohin_bunrui
         ORDER BY hanbai_tanka
       ) AS ranking
FROM Shohin;

--- DENSE_RANK
--- ROW_NUMBER

SELECT shohin_mai, shohin_bunrui, hanbai_tanka,
       RANK () OVER (ORDER BY hanbai_tanka) AS ranking,
       DENSE_RANK () OVER (ORDER BY hanbai_tanka) AS dense_ranking,
       ROW_NUMBER () OVER (ORDER BY hanbai_tanka) AS row_num
FROM Shohin;