
-- ABS(m)

-- MOD(a, b)
SELECT n,
       p,
       MOD(n, p) AS mod_col
FROM SampleMath;

-- ROUND(m, n)

-- abc || def
SELECT str1, str2,
       str1 || str2 AS str_concat
FROM SampleStr;

-- LENGTH(str)

-- LOWER(str)
-- UPPER(str)

-- REPLACE(a, b, c)
SELECT str1, str2, str3
       REPLACE(str1, str2, str3) AS rep_str
FROM SampleStr;

-- SUBSTRING(str FROM 3 FOR 2)
SELECT str1,
       SUBSTRING(str1 FROM 3 FOR 2) AS sub_str
FROM SampleStr;

-- CURRENT_DATE + CURRENT_TIME = CURRENT_TIMESTAMP
SELECT CURRENT_DATE;

-- EXTRACT(** FROM CURRENT_TIMESTAMP)
SELECT CURRENT_TIMESTAMP,
       EXTRACT(DAY FROM CURRENT_TIMESTAMP) AS day;

-- CAST(** AS **)

-- COALESCE(**, **, ..)
SELECT COALESCE(NULL, 1) AS col_1,
       COALESCE(NULL, 'test', NULL)

SELECT COALESCE(str2, 'is NULL')
FROM SampleStr;

-- EXISTS(相関サブクエリ)
SELECT shohin_name, hanbai_price
FROM Shohin AS S
WHERE EXISTS (
  SELECT *
  FROM TenpoShohin AS TS
  WHERE TS.tenpo_id = '000C'
  AND TS.shohin_id = S.shohin_id
);

SELECT shohin_name, hanbai_price
FROM Shohin AS S
WHERE NOT EXISTS (
  SELECT *
  FROM TempoShohin AS TS
  WHERE TS.tenpo_id = '000A'
  AND TS.shohin_id = S.shohin_id
);
