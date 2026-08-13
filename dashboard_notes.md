# Dashboard Notes: State Sectoral Growth KPI Dashboard

## Page 1 — Executive Summary
- **KPI cards**: fastest-growing state overall (latest year), national
  average growth per sector — from Query 3 in `kpi_analysis.sql`
- **Bar chart**: top 5 states by Industry growth — Query 2
- **Callout**: fastest state per sector — Query 1

## Page 2 — Geographic View
- **Choropleth map of India**, one tab per sector (Agriculture/Industry/
  Services), colored by `growth_rate_pct` for the latest year — Query 6
- Requires an India state-boundary shapefile/GeoJSON (Power BI: use the
  Shape Map visual with a custom TopoJSON; Tableau: use a state-name join,
  Tableau has built-in India state geocoding under "State/Province")
- Add a filter/legend distinguishing `verified` vs illustrative rows if
  using the demo dataset, so viewers know which figures are real

## Page 3 — Momentum / Trend
- **Slope chart or line chart**: national average growth per sector across
  the 3 years — Query 3
- **Table**: states that flipped from below- to above-average Services
  growth — Query 4. This is the "who's emerging" story, good for a
  callout box ("3 states moved into above-average Services growth in
  the latest year: Rajasthan, Tamil Nadu, Telangana")

## Page 4 — State Deep Dive
- **Sortable ranking table**: full state x sector ranking — Query 6,
  with a state/sector slicer so a viewer can look up any state
- **Bar chart**: sector-growth spread per state (top 10) — Query 5,
  framed as "which states have the most lopsided sector growth"

## Presentation tips
- Title each page with the business question it answers, not the metric
  name ("Where is growth accelerating?" not "YoY Trend")
- If using the demo dataset, add a small footer note on every page:
  "Some figures are illustrative — see data/SOURCES.md" — this is a
  portfolio project, so transparency about data provenance is itself a
  good signal to reviewers, not a weakness to hide
- Once you swap in the real bulk CSV from data.gov.in, remove the
  verified/illustrative distinction entirely — the dashboard's SQL and
  layout don't otherwise change
