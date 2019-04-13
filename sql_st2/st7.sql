
-- UNION 重複行を排除
-- UNION ALL 重複行を排除しない
SELECT shohin_id, shohin_mei
FROM Shohin
UNION ALL
SELECT shohin_id, shohin_mei
FROM Shohin2:

-- INTERSECT 共通部分の選択

-- EXCEPT 差

-- INNER JOIN

-- OUTER JOIN

-- CROSS JOIN
