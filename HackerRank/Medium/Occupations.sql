WITH drs AS (
    SELECT name, ROW_NUMBER() OVER () AS rn FROM occupations
    WHERE occupation='Doctor'
    ORDER BY name ASC
),
prof AS (
    SELECT name, ROW_NUMBER() OVER () AS rn FROM occupations
    WHERE occupation='Professor'
    ORDER BY name ASC
),
sing As (
    SELECT name, ROW_NUMBER() OVER () AS rn FROM occupations
    WHERE occupation='Singer'
    ORDER BY name ASC
),
act As (
    SELECT name, ROW_NUMBER() OVER () AS rn FROM occupations
    WHERE occupation='Actor'
    ORDER BY name ASC
)
SELECT dr_name, prof_name, sing_name, act_name FROM
(
    SELECT drs.name AS dr_name, drs.rn AS dr_rn, prof.name AS prof_name, prof.rn AS prof_rn FROM drs
    LEFT JOIN prof ON drs.rn = prof.rn
    UNION
    SELECT drs.name AS dr_name, drs.rn AS dr_rn, prof.name AS prof_name, prof.rn AS prof_rn FROM drs
    RIGHT JOIN prof ON drs.rn=prof.rn
) AS dr_prof
LEFT JOIN 
(
    SELECT sing.name AS sing_name, sing.rn AS sing_rn, act.name AS act_name, act.rn AS act_rn FROM sing
    LEFT JOIN act ON sing.rn = act.rn
    UNION
    SELECT sing.name AS sing_name, sing.rn AS sing_rn, act.name AS act_name, act.rn AS act_rn FROM sing
    RIGHT JOIN act ON sing.rn = act.rn
) AS sing_act ON prof_rn=sing_rn
UNION
SELECT dr_name, prof_name, sing_name, act_name FROM
(
    SELECT drs.name AS dr_name, drs.rn AS dr_rn, prof.name AS prof_name, prof.rn AS prof_rn FROM drs
    LEFT JOIN prof ON drs.rn = prof.rn
    UNION
    SELECT drs.name AS dr_name, drs.rn AS dr_rn, prof.name AS prof_name, prof.rn AS prof_rn FROM drs
    RIGHT JOIN prof ON drs.rn=prof.rn
) AS dr_prof2
RIGHT JOIN 
(
    SELECT sing.name AS sing_name, sing.rn AS sing_rn, act.name AS act_name, act.rn AS act_rn FROM sing
    LEFT JOIN act ON sing.rn = act.rn
    UNION
    SELECT sing.name AS sing_name, sing.rn AS sing_rn, act.name AS act_name, act.rn AS act_rn FROM sing
    RIGHT JOIN act ON sing.rn = act.rn
) AS sing_act2 ON prof_rn=sing_rn;