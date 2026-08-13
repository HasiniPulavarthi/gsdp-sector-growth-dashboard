-- ============================================================
-- kpi_analysis.sql
-- Business question: "Which states show the fastest growth in
-- which sectors, and how has that shifted year over year?"
--
-- Written for SQLite (portable). Assumes a table `gva_growth`
-- loaded from data/state_sector_gva_growth.csv with columns:
-- state, year, sector, growth_rate_pct, verified
-- ============================================================

-- 1. Fastest-growing state per sector, most recent year (2023-24)
SELECT sector, state, growth_rate_pct, verified
FROM gva_growth
WHERE year = '2023-24'
  AND growth_rate_pct = (
      SELECT MAX(g2.growth_rate_pct)
      FROM gva_growth g2
      WHERE g2.sector = gva_growth.sector AND g2.year = '2023-24'
  )
ORDER BY sector;

-- 2. Top 5 states by Industry sector growth, most recent year
SELECT state, growth_rate_pct, verified
FROM gva_growth
WHERE sector = 'Industry' AND year = '2023-24'
ORDER BY growth_rate_pct DESC
LIMIT 5;

-- 3. Year-over-year growth trend per sector, national average
SELECT year, sector, ROUND(AVG(growth_rate_pct), 2) AS avg_growth_pct
FROM gva_growth
GROUP BY year, sector
ORDER BY sector, year;

-- 4. States that flipped from below-average to above-average growth
--    in Services between 2022-23 and 2023-24 (momentum shift -- useful
--    for spotting emerging markets, not just current leaders)
WITH yearly_avg AS (
    SELECT year, sector, AVG(growth_rate_pct) AS avg_growth
    FROM gva_growth
    GROUP BY year, sector
),
state_vs_avg AS (
    SELECT
        g.state, g.year, g.sector, g.growth_rate_pct,
        ya.avg_growth,
        CASE WHEN g.growth_rate_pct > ya.avg_growth THEN 1 ELSE 0 END AS above_avg
    FROM gva_growth g
    JOIN yearly_avg ya ON ya.year = g.year AND ya.sector = g.sector
    WHERE g.sector = 'Services' AND g.year IN ('2022-23', '2023-24')
)
SELECT
    s1.state,
    s1.growth_rate_pct AS growth_2022_23,
    s2.growth_rate_pct AS growth_2023_24
FROM state_vs_avg s1
JOIN state_vs_avg s2 ON s1.state = s2.state
WHERE s1.year = '2022-23' AND s2.year = '2023-24'
  AND s1.above_avg = 0 AND s2.above_avg = 1
ORDER BY s2.growth_rate_pct DESC;

-- 5. Sector mix volatility per state: which states have the widest
--    spread between their fastest- and slowest-growing sector
--    (a proxy for how concentrated/diversified a state's economy is)
SELECT
    state,
    year,
    MAX(growth_rate_pct) - MIN(growth_rate_pct) AS sector_growth_spread,
    MAX(growth_rate_pct) AS fastest_sector_growth,
    MIN(growth_rate_pct) AS slowest_sector_growth
FROM gva_growth
WHERE year = '2023-24'
GROUP BY state, year
ORDER BY sector_growth_spread DESC
LIMIT 10;

-- 6. Ranking table for the dashboard: every state's rank within each
--    sector, most recent year (feeds a sortable table visual)
SELECT
    sector,
    state,
    growth_rate_pct,
    RANK() OVER (PARTITION BY sector ORDER BY growth_rate_pct DESC) AS rank_in_sector,
    verified
FROM gva_growth
WHERE year = '2023-24'
ORDER BY sector, rank_in_sector;
