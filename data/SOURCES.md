# Data Sources

## Real dataset (recommended for production use)
**State-wise Sectoral Growth of Gross Value Added (GVA) on yearly basis**
https://www.data.gov.in/resource/state-wise-sectoral-growth-gross-value-added-gva-yearly-basis
(Open Government Data Platform India / MOSPI)

This is the authoritative bulk dataset this project is designed for. Download
it from the link above and replace `data/state_sector_gva_growth.csv` with
it — the SQL and dashboard require no schema changes if you keep the same
column meaning (state, year, sector, growth rate).

## Demo dataset (included, for running the project today)
Rows marked `verified=1` in the generated CSV are real, cited figures:

| State | Year | Sector | Growth | Source |
|---|---|---|---|---|
| Maharashtra | 2023-24 | Agriculture & Allied | 1.9% | Maharashtra Economic Survey 2023-24, tabled by Dy CM Ajit Pawar (newsonair.gov.in) |
| Maharashtra | 2023-24 | Industry | 7.6% | Same source |
| Maharashtra | 2023-24 | Services | 8.8% | Same source |
| Punjab | 2023-24 | Agriculture & Allied | 2.4% | Punjab Economic Survey 2023-24, reported by The Tribune |
| Punjab | 2022-23 | Agriculture & Allied | 2.7% | Same source |
| Karnataka | 2022-23 | Agriculture & Allied | ~-1.8% (directional) | Karnataka Economic Survey 2022-23, reported by Deccan Herald — sector's GSDP *share* fell from 15.36% to 15.08%; used here as a directional growth proxy, not an exact official growth-rate figure |
| Mizoram | 2022-23 | Services | 13.5% (overall GSDP proxy) | Mizoram Economic Survey 2023-24, reported by Business Standard — this is the state's overall GSDP growth, service-sector-led per the survey; used as a services-sector proxy |

National sectoral benchmarks used to keep illustrative (`verified=0`) rows
directionally realistic:

| Year | Primary/Agri | Secondary/Industry | Tertiary/Services | Source |
|---|---|---|---|---|
| 2022-23 | 4.7% | 3.8% | 7.9% | MOSPI, "New Series of GDP Estimates with Base Year 2022-23" (PIB press release) |
| 2023-24 | 2.6% | 11.6% | 7.9% (7.3% used) | Same source |

**All other state/year/sector combinations are illustrative**, generated
with a per-state random offset plus noise around these national benchmarks.
They are NOT real government figures — don't cite them as such. They exist
so the SQL and dashboard have a full, non-trivial dataset to run against
before you plug in the real bulk file.
