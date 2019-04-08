
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