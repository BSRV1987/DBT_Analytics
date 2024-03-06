/*
If we dont materialize the table using config then by default it becomes a view.
*/
WITH HitData AS (
    SELECT date,
        TRY_PARSE_JSON(hits):hitNumber::INT AS hit_number,
        TRY_PARSE_JSON(hits):hour::INT AS hour,
        TRY_PARSE_JSON(hits):isEntrance::BOOLEAN AS is_entrance,
        TRY_PARSE_JSON(hits):isExit::BOOLEAN AS is_exit
    FROM
          {{ ref('GA_Sessions') }}
)
SELECT
    date,
    COUNT(*) AS total_hits,
    SUM(CASE WHEN is_entrance THEN 1 ELSE 0 END) AS total_entrances,
    SUM(CASE WHEN is_exit THEN 1 ELSE 0 END) AS total_exits,
FROM
    HitData
GROUP BY
   date
