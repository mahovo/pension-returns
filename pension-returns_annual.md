---
title: "Annual pension returns analysis"
author: Martin Hoshi Vognsen
header-includes:
   - \usepackage[default]{sourcesanspro}
   - \usepackage[fontsize=8pt]{scrextend}
output: 
  html_document:
    toc: true
    toc_depth: 3
    keep_md: yes
  pdf_document:
    toc: true
    toc_depth: 3
    latex_engine: xelatex
#fontsize: 10pt # for pdf. Limited to 10pt, 11pt and 12pt. Else use scrextend.
params:
  run_sim: FALSE ## TRUE: Run simulations and write output. FALSE: Read saved
                ## simulations output from disk instead of running the simulations.
  run_fits: FALSE
  run_exploratory: TRUE ## Include exploratory report?
  run_individual: TRUE ## Include individual reports? Depends on run_individual.
  run_comparison: TRUE ## Include comparison report? Depends on run_individual.
  run_comments: FALSE ## !!! OBS! Comments in separarte child doc deprecated
  run_appendix: FALSE ## !!! OBS! Appendix in separarte child doc deprecated
  run_mc_plot: TRUE
  run_is_sim: TRUE
  run_is_plot: TRUE
  include_long: TRUE
date: "07:27 24 June 2026"
---
































# Summary

*Role of this report.* This annual report is an artifact, not the substance of the study. Its
purpose is to show how far inference degrades when only annual data is available. Annual returns
are too sparse to estimate the distribution, so the report goes no further than establishing that.
The substance of the study is the monthly report, and the decision companion is the investor tool.

This is a **case study on a deliberately frozen data set** (annual returns 2011-2023),
not an up-to-date monitor. Fixing the data is what lets us interpret a specific set of
numbers and graphs. Three findings stand out.

1. **The "plans" are leverage levels on one portfolio, not distinct asset mixes.** Within
each provider the high-risk plan is almost exactly a scalar multiple of the medium-risk
plan ($\beta \approx 1.2$ for Velliv, $\approx 1.6$ for PFA, intercept $\approx 0$), and a
single common factor explains about 96% of the variation across all four plans. PFA's own
product description confirms it: profiles B and D are fixed weighted blends of the *same
two* underlying funds.

2. **"Risk" here means deeper drawdowns and start-date-dependent path ordering, not a
different kind of bet.** The high-risk plan amplifies the same factor in both directions:
it loses more in bad years (it underperformed the medium plan in 3-4 of 13 years), and its
cumulative path drops below the medium plan's whenever the index is started just before a
drawdown.

3. **The sample is far too short to estimate the tail, and -- at annual resolution -- it
contains no crash**, so every risk number is both barely identified and optimistically
biased. For *precise* tail estimates the honest verdict is close to Taleb's "better stay
home"; what survives is the *qualitative* structure -- fat tails, leverage, and asymmetric
drawdowns.

The Discussion at the end develops these points.

# Returns data 2011-2023.

Fit log returns to F-S skew standardized Student-t distribution.
`m`  is the location parameter.
`s` is the scale parameter.
`nu` is the estimated shape parameter (degrees of freedom).
`xi` is the estimated skewness parameter.

For 2011, medium risk data is used in the high risk data set, as no high risk fund data is available prior to 2012.  
`vmrl` is a long version of Velliv medium risk data, from 2007 to 2023. For 2007 to 2011 (both included) no high risk data is available.

PFA medium risk is risk profile B.  
PFA high risk is risk profile D.  








![](pension-returns_annual_files/figure-html/unnamed-chunk-3-1.png)<!-- -->




























































































## Summary of log-returns

The summary statistics are transformed back to the scale of gross returns by taking $exp()$ of each summary statistic. (Note: Taking arithmetic mean of gross returns directly is no good. Must be geometric mean.)







|         |   vmr|   vhr|  vmrl|   pmr|   phr|   mmr|   mhr| vmr_phr| vhr_pmr|
|:--------|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-------:|-------:|
|Min.   : | 0.868| 0.849| 0.801| 0.904| 0.878| 0.885| 0.864|   0.874|   0.873|
|1st Qu.: | 1.044| 1.039| 1.013| 1.042| 1.068| 1.059| 1.061|   1.064|   1.055|
|Median : | 1.097| 1.099| 1.085| 1.084| 1.128| 1.089| 1.127|   1.119|   1.104|
|Mean   : | 1.067| 1.080| 1.057| 1.063| 1.089| 1.065| 1.085|   1.079|   1.072|
|3rd Qu.: | 1.136| 1.160| 1.128| 1.107| 1.182| 1.121| 1.144|   1.139|   1.134|
|Max.   : | 1.168| 1.214| 1.193| 1.141| 1.208| 1.143| 1.211|   1.183|   1.163|


## Ranking

| Min.   :|ranking | 1st Qu.:|ranking | Median :|ranking | Mean   :|ranking | 3rd Qu.:|ranking | Max.   :|ranking |
|--------:|:-------|--------:|:-------|--------:|:-------|--------:|:-------|--------:|:-------|--------:|:-------|
|    0.904|pmr     |    1.068|phr     |    1.128|phr     |    1.089|phr     |    1.182|phr     |    1.214|vhr     |
|    0.885|mmr     |    1.064|vmr_phr |    1.127|mhr     |    1.085|mhr     |    1.160|vhr     |    1.211|mhr     |
|    0.878|phr     |    1.061|mhr     |    1.119|vmr_phr |    1.080|vhr     |    1.144|mhr     |    1.208|phr     |
|    0.874|vmr_phr |    1.059|mmr     |    1.104|vhr_pmr |    1.079|vmr_phr |    1.139|vmr_phr |    1.193|vmrl    |
|    0.873|vhr_pmr |    1.055|vhr_pmr |    1.099|vhr     |    1.072|vhr_pmr |    1.136|vmr     |    1.183|vmr_phr |
|    0.868|vmr     |    1.044|vmr     |    1.097|vmr     |    1.067|vmr     |    1.134|vhr_pmr |    1.168|vmr     |
|    0.864|mhr     |    1.042|pmr     |    1.089|mmr     |    1.065|mmr     |    1.128|vmrl    |    1.163|vhr_pmr |
|    0.849|vhr     |    1.039|vhr     |    1.085|vmrl    |    1.063|pmr     |    1.121|mmr     |    1.143|mmr     |
|    0.801|vmrl    |    1.013|vmrl    |    1.084|pmr     |    1.057|vmrl    |    1.107|pmr     |    1.141|pmr     |


## Correlations and covariance

Correlations

|    |   vmr|   vhr|   pmr|   phr|
|:---|-----:|-----:|-----:|-----:|
|vmr | 1.000| 0.993| 0.938| 0.941|
|vhr | 0.993| 1.000| 0.917| 0.939|
|pmr | 0.938| 0.917| 1.000| 0.957|
|phr | 0.941| 0.939| 0.957| 1.000|

Covariances

|    |   vmr|   vhr|   pmr|   phr|
|:---|-----:|-----:|-----:|-----:|
|vmr | 0.007| 0.009| 0.005| 0.008|
|vhr | 0.009| 0.011| 0.006| 0.010|
|pmr | 0.005| 0.006| 0.004| 0.007|
|phr | 0.008| 0.010| 0.007| 0.011|


# Compare pension plans

## Risk of loss

Risk of loss at least as big as row name in percent for a single period (year).

Skewed $t$-distribution (sstd):  






|   |    vmr|    vhr|    pmr|    phr|    mmr|    mhr| vmr_phr| vhr_pmr|
|:--|------:|------:|------:|------:|------:|------:|-------:|-------:|
|0  | 17.167| 19.667| 11.833| 16.000| 16.667| 17.000|  15.000|  14.500|
|5  |  9.167| 12.500|  5.667|  9.333|  8.500| 10.500|   8.667|   7.333|
|10 |  5.000|  8.000|  3.000|  5.333|  4.500|  6.500|   5.000|   3.833|
|25 |  0.667|  2.167|  0.500|  0.833|  0.667|  1.667|   1.000|   0.333|
|50 |  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|   0.000|   0.000|
|90 |  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|   0.000|   0.000|
|99 |  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|   0.000|   0.000|


Standardized $t$-distribution (std):  




|   |    vmr|    vhr|   pmr|   phr|   mmr|    mhr| vmr_phr| vhr_pmr|
|:--|------:|------:|-----:|-----:|-----:|------:|-------:|-------:|
|0  | 10.500| 16.167| 5.500| 8.500| 7.000| 20.167|   8.000|   8.500|
|5  |  4.167|  6.833| 2.167| 4.500| 3.000|  8.667|   4.000|   3.667|
|10 |  1.667|  2.500| 1.000| 2.667| 1.500|  2.500|   2.167|   1.667|
|25 |  0.000|  0.000| 0.000| 0.500| 0.167|  0.000|   0.333|   0.000|
|50 |  0.000|  0.000| 0.000| 0.000| 0.000|  0.000|   0.000|   0.000|
|90 |  0.000|  0.000| 0.000| 0.000| 0.000|  0.000|   0.000|   0.000|
|99 |  0.000|  0.000| 0.000| 0.000| 0.000|  0.000|   0.000|   0.000|


Normal distribution:  




|   |    vmr|    vhr|    pmr|    phr|    mmr|    mhr| vmr_phr| vhr_pmr|
|:--|------:|------:|------:|------:|------:|------:|-------:|-------:|
|0  | 21.167| 21.667| 16.500| 19.667| 18.667| 20.167|  19.833|  19.167|
|5  |  7.333|  9.500|  3.333|  8.500|  5.167|  8.667|   7.667|   6.333|
|10 |  1.500|  2.833|  0.000|  2.667|  0.500|  2.500|   1.833|   1.167|
|25 |  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|   0.000|   0.000|
|50 |  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|   0.000|   0.000|
|90 |  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|   0.000|   0.000|
|99 |  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|   0.000|   0.000|


### Worst ranking for loss percentiles

Skewed $t$-distribution (sstd):  


|      0|ranking |      5|ranking |    10|ranking |    25|ranking | 50|ranking | 90|ranking | 99|ranking |
|------:|:-------|------:|:-------|-----:|:-------|-----:|:-------|--:|:-------|--:|:-------|--:|:-------|
| 19.667|vhr     | 12.500|vhr     | 8.000|vhr     | 2.167|vhr     |  0|vmr     |  0|vmr     |  0|vmr     |
| 17.167|vmr     | 10.500|mhr     | 6.500|mhr     | 1.667|mhr     |  0|vhr     |  0|vhr     |  0|vhr     |
| 17.000|mhr     |  9.333|phr     | 5.333|phr     | 1.000|vmr_phr |  0|pmr     |  0|pmr     |  0|pmr     |
| 16.667|mmr     |  9.167|vmr     | 5.000|vmr     | 0.833|phr     |  0|phr     |  0|phr     |  0|phr     |
| 16.000|phr     |  8.667|vmr_phr | 5.000|vmr_phr | 0.667|vmr     |  0|mmr     |  0|mmr     |  0|mmr     |
| 15.000|vmr_phr |  8.500|mmr     | 4.500|mmr     | 0.667|mmr     |  0|mhr     |  0|mhr     |  0|mhr     |
| 14.500|vhr_pmr |  7.333|vhr_pmr | 3.833|vhr_pmr | 0.500|pmr     |  0|vmr_phr |  0|vmr_phr |  0|vmr_phr |
| 11.833|pmr     |  5.667|pmr     | 3.000|pmr     | 0.333|vhr_pmr |  0|vhr_pmr |  0|vhr_pmr |  0|vhr_pmr |


Standardized $t$-distribution (std):  


|      0|ranking |     5|ranking |    10|ranking |    25|ranking | 50|ranking | 90|ranking | 99|ranking |
|------:|:-------|-----:|:-------|-----:|:-------|-----:|:-------|--:|:-------|--:|:-------|--:|:-------|
| 20.167|mhr     | 8.667|mhr     | 2.667|phr     | 0.500|phr     |  0|vmr     |  0|vmr     |  0|vmr     |
| 16.167|vhr     | 6.833|vhr     | 2.500|vhr     | 0.333|vmr_phr |  0|vhr     |  0|vhr     |  0|vhr     |
| 10.500|vmr     | 4.500|phr     | 2.500|mhr     | 0.167|mmr     |  0|pmr     |  0|pmr     |  0|pmr     |
|  8.500|phr     | 4.167|vmr     | 2.167|vmr_phr | 0.000|vmr     |  0|phr     |  0|phr     |  0|phr     |
|  8.500|vhr_pmr | 4.000|vmr_phr | 1.667|vmr     | 0.000|vhr     |  0|mmr     |  0|mmr     |  0|mmr     |
|  8.000|vmr_phr | 3.667|vhr_pmr | 1.667|vhr_pmr | 0.000|pmr     |  0|mhr     |  0|mhr     |  0|mhr     |
|  7.000|mmr     | 3.000|mmr     | 1.500|mmr     | 0.000|mhr     |  0|vmr_phr |  0|vmr_phr |  0|vmr_phr |
|  5.500|pmr     | 2.167|pmr     | 1.000|pmr     | 0.000|vhr_pmr |  0|vhr_pmr |  0|vhr_pmr |  0|vhr_pmr |


Normal distribution:  


|      0|ranking |     5|ranking |    10|ranking | 25|ranking | 50|ranking | 90|ranking | 99|ranking |
|------:|:-------|-----:|:-------|-----:|:-------|--:|:-------|--:|:-------|--:|:-------|--:|:-------|
| 21.667|vhr     | 9.500|vhr     | 2.833|vhr     |  0|vmr     |  0|vmr     |  0|vmr     |  0|vmr     |
| 21.167|vmr     | 8.667|mhr     | 2.667|phr     |  0|vhr     |  0|vhr     |  0|vhr     |  0|vhr     |
| 20.167|mhr     | 8.500|phr     | 2.500|mhr     |  0|pmr     |  0|pmr     |  0|pmr     |  0|pmr     |
| 19.833|vmr_phr | 7.667|vmr_phr | 1.833|vmr_phr |  0|phr     |  0|phr     |  0|phr     |  0|phr     |
| 19.667|phr     | 7.333|vmr     | 1.500|vmr     |  0|mmr     |  0|mmr     |  0|mmr     |  0|mmr     |
| 19.167|vhr_pmr | 6.333|vhr_pmr | 1.167|vhr_pmr |  0|mhr     |  0|mhr     |  0|mhr     |  0|mhr     |
| 18.667|mmr     | 5.167|mmr     | 0.500|mmr     |  0|vmr_phr |  0|vmr_phr |  0|vmr_phr |  0|vmr_phr |
| 16.500|pmr     | 3.333|pmr     | 0.000|pmr     |  0|vhr_pmr |  0|vhr_pmr |  0|vhr_pmr |  0|vhr_pmr |


## Chance of min gains

Chance of gains of at least `x` percent for a single period (year).  
`x` values are row names.


Skewed $t$-distribution (sstd):  






|    |    vmr|    vhr|    pmr|    phr|    mmr|    mhr| vmr_phr| vhr_pmr|
|:---|------:|------:|------:|------:|------:|------:|-------:|-------:|
|0   | 82.833| 80.333| 88.167| 84.000| 83.333| 83.000|  85.000|  85.500|
|5   | 68.333| 69.333| 71.667| 73.000| 66.500| 72.500|  73.167|  71.167|
|10  | 44.667| 53.333| 32.500| 55.833| 35.667| 56.167|  53.000|  46.000|
|25  |  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|   0.000|   0.000|
|50  |  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|   0.000|   0.000|
|100 |  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|   0.000|   0.000|


Standardized $t$-distribution (std):  




|    |    vmr|    vhr|    pmr|    phr|    mmr|    mhr| vmr_phr| vhr_pmr|
|:---|------:|------:|------:|------:|------:|------:|-------:|-------:|
|0   | 89.500| 83.833| 94.500| 91.500| 93.000| 79.833|  92.000|  91.500|
|5   | 73.000| 67.667| 81.333| 83.000| 79.500| 63.000|  82.167|  77.833|
|10  | 43.833| 47.000| 38.500| 65.500| 43.333| 44.333|  59.167|  48.667|
|25  |  4.167|  7.500|  2.000| 11.667|  3.167|  7.167|   7.333|   4.500|
|50  |  0.167|  0.000|  0.000|  1.667|  0.333|  0.000|   1.000|   0.333|
|100 |  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|   0.000|   0.000|


Normal distribution:  




|    |    vmr|    vhr|    pmr|    phr|    mmr|    mhr| vmr_phr| vhr_pmr|
|:---|------:|------:|------:|------:|------:|------:|-------:|-------:|
|0   | 78.833| 78.333| 83.500| 80.333| 81.333| 79.833|  80.167|  80.833|
|5   | 57.667| 61.333| 57.667| 64.167| 57.833| 63.000|  61.833|  60.167|
|10  | 35.167| 42.500| 29.000| 46.167| 32.167| 44.333|  41.333|  37.167|
|25  |  2.167|  6.667|  0.000|  8.333|  0.833|  7.167|   4.833|   2.333|
|50  |  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|   0.000|   0.000|
|100 |  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|   0.000|   0.000|



### Best ranking for gains percentiles


Skewed $t$-distribution (sstd):  


|      0|ranking |      5|ranking |     10|ranking | 25|ranking | 50|ranking | 100|ranking |
|------:|:-------|------:|:-------|------:|:-------|--:|:-------|--:|:-------|---:|:-------|
| 88.167|pmr     | 73.167|vmr_phr | 56.167|mhr     |  0|vmr     |  0|vmr     |   0|vmr     |
| 85.500|vhr_pmr | 73.000|phr     | 55.833|phr     |  0|vhr     |  0|vhr     |   0|vhr     |
| 85.000|vmr_phr | 72.500|mhr     | 53.333|vhr     |  0|pmr     |  0|pmr     |   0|pmr     |
| 84.000|phr     | 71.667|pmr     | 53.000|vmr_phr |  0|phr     |  0|phr     |   0|phr     |
| 83.333|mmr     | 71.167|vhr_pmr | 46.000|vhr_pmr |  0|mmr     |  0|mmr     |   0|mmr     |
| 83.000|mhr     | 69.333|vhr     | 44.667|vmr     |  0|mhr     |  0|mhr     |   0|mhr     |
| 82.833|vmr     | 68.333|vmr     | 35.667|mmr     |  0|vmr_phr |  0|vmr_phr |   0|vmr_phr |
| 80.333|vhr     | 66.500|mmr     | 32.500|pmr     |  0|vhr_pmr |  0|vhr_pmr |   0|vhr_pmr |


Standardized $t$-distribution (std):  


|      0|ranking |      5|ranking |     10|ranking |     25|ranking |    50|ranking | 100|ranking |
|------:|:-------|------:|:-------|------:|:-------|------:|:-------|-----:|:-------|---:|:-------|
| 94.500|pmr     | 83.000|phr     | 65.500|phr     | 11.667|phr     | 1.667|phr     |   0|vmr     |
| 93.000|mmr     | 82.167|vmr_phr | 59.167|vmr_phr |  7.500|vhr     | 1.000|vmr_phr |   0|vhr     |
| 92.000|vmr_phr | 81.333|pmr     | 48.667|vhr_pmr |  7.333|vmr_phr | 0.333|mmr     |   0|pmr     |
| 91.500|phr     | 79.500|mmr     | 47.000|vhr     |  7.167|mhr     | 0.333|vhr_pmr |   0|phr     |
| 91.500|vhr_pmr | 77.833|vhr_pmr | 44.333|mhr     |  4.500|vhr_pmr | 0.167|vmr     |   0|mmr     |
| 89.500|vmr     | 73.000|vmr     | 43.833|vmr     |  4.167|vmr     | 0.000|vhr     |   0|mhr     |
| 83.833|vhr     | 67.667|vhr     | 43.333|mmr     |  3.167|mmr     | 0.000|pmr     |   0|vmr_phr |
| 79.833|mhr     | 63.000|mhr     | 38.500|pmr     |  2.000|pmr     | 0.000|mhr     |   0|vhr_pmr |


Normal distribution:  


|      0|ranking |      5|ranking |     10|ranking |    25|ranking | 50|ranking | 100|ranking |
|------:|:-------|------:|:-------|------:|:-------|-----:|:-------|--:|:-------|---:|:-------|
| 83.500|pmr     | 64.167|phr     | 46.167|phr     | 8.333|phr     |  0|vmr     |   0|vmr     |
| 81.333|mmr     | 63.000|mhr     | 44.333|mhr     | 7.167|mhr     |  0|vhr     |   0|vhr     |
| 80.833|vhr_pmr | 61.833|vmr_phr | 42.500|vhr     | 6.667|vhr     |  0|pmr     |   0|pmr     |
| 80.333|phr     | 61.333|vhr     | 41.333|vmr_phr | 4.833|vmr_phr |  0|phr     |   0|phr     |
| 80.167|vmr_phr | 60.167|vhr_pmr | 37.167|vhr_pmr | 2.333|vhr_pmr |  0|mmr     |   0|mmr     |
| 79.833|mhr     | 57.833|mmr     | 35.167|vmr     | 2.167|vmr     |  0|mhr     |   0|mhr     |
| 78.833|vmr     | 57.667|vmr     | 32.167|mmr     | 0.833|mmr     |  0|vmr_phr |   0|vmr_phr |
| 78.333|vhr     | 57.667|pmr     | 29.000|pmr     | 0.000|pmr     |  0|vhr_pmr |   0|vhr_pmr |


## MC risk percentiles

Risk of loss at least as big as row name in percent from first to last period.  




Skewed $t$-distribution (sstd):  




|   |  vmr|  vhr|  pmr|  phr|  mmr|  mhr| vmr_phr| vhr_pmr|
|:--|----:|----:|----:|----:|----:|----:|-------:|-------:|
|0  | 1.58| 3.99| 1.86| 0.90| 2.31| 2.34|    1.88|    0.67|
|5  | 1.32| 3.72| 1.70| 0.77| 1.96| 2.16|    1.66|    0.54|
|10 | 1.13| 3.40| 1.48| 0.65| 1.59| 1.84|    1.51|    0.44|
|25 | 0.64| 2.28| 1.13| 0.42| 1.08| 1.28|    1.11|    0.26|
|50 | 0.24| 1.04| 0.55| 0.17| 0.43| 0.58|    0.46|    0.08|
|90 | 0.02| 0.14| 0.07| 0.01| 0.06| 0.10|    0.03|    0.00|
|99 | 0.00| 0.00| 0.00| 0.00| 0.00| 0.00|    0.00|    0.00|




Standardized $t$-distribution (std):  




|   |  vmr| vhr|  pmr|  phr|  mmr|  mhr| vmr_phr| vhr_pmr|
|:--|----:|---:|----:|----:|----:|----:|-------:|-------:|
|0  | 0.30|   0| 0.47| 0.66| 0.67| 0.01|    0.68|    0.25|
|5  | 0.27|   0| 0.46| 0.63| 0.62| 0.00|    0.62|    0.23|
|10 | 0.25|   0| 0.42| 0.59| 0.59| 0.00|    0.61|    0.22|
|25 | 0.16|   0| 0.34| 0.50| 0.46| 0.00|    0.50|    0.18|
|50 | 0.10|   0| 0.26| 0.41| 0.30| 0.00|    0.36|    0.08|
|90 | 0.02|   0| 0.07| 0.19| 0.06| 0.00|    0.15|    0.02|
|99 | 0.00|   0| 0.00| 0.00| 0.00| 0.00|    0.00|    0.00|


Normal distribution:  




|   |  vmr|  vhr| pmr|  phr| mmr|  mhr| vmr_phr| vhr_pmr|
|:--|----:|----:|---:|----:|---:|----:|-------:|-------:|
|0  | 0.02| 0.05|   0| 0.02|   0| 0.02|    0.02|    0.02|
|5  | 0.02| 0.04|   0| 0.02|   0| 0.02|    0.01|    0.01|
|10 | 0.02| 0.02|   0| 0.01|   0| 0.00|    0.01|    0.01|
|25 | 0.00| 0.00|   0| 0.01|   0| 0.00|    0.00|    0.00|
|50 | 0.00| 0.00|   0| 0.00|   0| 0.00|    0.00|    0.00|
|90 | 0.00| 0.00|   0| 0.00|   0| 0.00|    0.00|    0.00|
|99 | 0.00| 0.00|   0| 0.00|   0| 0.00|    0.00|    0.00|


### Worst ranking for MC loss percentiles

Skewed $t$-distribution (sstd):  


|    0|ranking |    5|ranking |   10|ranking |   25|ranking |   50|ranking |   90|ranking | 99|ranking |
|----:|:-------|----:|:-------|----:|:-------|----:|:-------|----:|:-------|----:|:-------|--:|:-------|
| 3.99|vhr     | 3.72|vhr     | 3.40|vhr     | 2.28|vhr     | 1.04|vhr     | 0.14|vhr     |  0|vmr     |
| 2.34|mhr     | 2.16|mhr     | 1.84|mhr     | 1.28|mhr     | 0.58|mhr     | 0.10|mhr     |  0|vhr     |
| 2.31|mmr     | 1.96|mmr     | 1.59|mmr     | 1.13|pmr     | 0.55|pmr     | 0.07|pmr     |  0|pmr     |
| 1.88|vmr_phr | 1.70|pmr     | 1.51|vmr_phr | 1.11|vmr_phr | 0.46|vmr_phr | 0.06|mmr     |  0|phr     |
| 1.86|pmr     | 1.66|vmr_phr | 1.48|pmr     | 1.08|mmr     | 0.43|mmr     | 0.03|vmr_phr |  0|mmr     |
| 1.58|vmr     | 1.32|vmr     | 1.13|vmr     | 0.64|vmr     | 0.24|vmr     | 0.02|vmr     |  0|mhr     |
| 0.90|phr     | 0.77|phr     | 0.65|phr     | 0.42|phr     | 0.17|phr     | 0.01|phr     |  0|vmr_phr |
| 0.67|vhr_pmr | 0.54|vhr_pmr | 0.44|vhr_pmr | 0.26|vhr_pmr | 0.08|vhr_pmr | 0.00|vhr_pmr |  0|vhr_pmr |


Standardized $t$-distribution (std):  


|    0|ranking |    5|ranking |   10|ranking |   25|ranking |   50|ranking |   90|ranking | 99|ranking |
|----:|:-------|----:|:-------|----:|:-------|----:|:-------|----:|:-------|----:|:-------|--:|:-------|
| 0.68|vmr_phr | 0.63|phr     | 0.61|vmr_phr | 0.50|phr     | 0.41|phr     | 0.19|phr     |  0|vmr     |
| 0.67|mmr     | 0.62|mmr     | 0.59|phr     | 0.50|vmr_phr | 0.36|vmr_phr | 0.15|vmr_phr |  0|vhr     |
| 0.66|phr     | 0.62|vmr_phr | 0.59|mmr     | 0.46|mmr     | 0.30|mmr     | 0.07|pmr     |  0|pmr     |
| 0.47|pmr     | 0.46|pmr     | 0.42|pmr     | 0.34|pmr     | 0.26|pmr     | 0.06|mmr     |  0|phr     |
| 0.30|vmr     | 0.27|vmr     | 0.25|vmr     | 0.18|vhr_pmr | 0.10|vmr     | 0.02|vmr     |  0|mmr     |
| 0.25|vhr_pmr | 0.23|vhr_pmr | 0.22|vhr_pmr | 0.16|vmr     | 0.08|vhr_pmr | 0.02|vhr_pmr |  0|mhr     |
| 0.01|mhr     | 0.00|vhr     | 0.00|vhr     | 0.00|vhr     | 0.00|vhr     | 0.00|vhr     |  0|vmr_phr |
| 0.00|vhr     | 0.00|mhr     | 0.00|mhr     | 0.00|mhr     | 0.00|mhr     | 0.00|mhr     |  0|vhr_pmr |


Normal distribution:  


|    0|ranking |    5|ranking |   10|ranking |   25|ranking | 50|ranking | 90|ranking | 99|ranking |
|----:|:-------|----:|:-------|----:|:-------|----:|:-------|--:|:-------|--:|:-------|--:|:-------|
| 0.05|vhr     | 0.04|vhr     | 0.02|vmr     | 0.01|phr     |  0|vmr     |  0|vmr     |  0|vmr     |
| 0.02|vmr     | 0.02|vmr     | 0.02|vhr     | 0.00|vmr     |  0|vhr     |  0|vhr     |  0|vhr     |
| 0.02|phr     | 0.02|phr     | 0.01|phr     | 0.00|vhr     |  0|pmr     |  0|pmr     |  0|pmr     |
| 0.02|mhr     | 0.02|mhr     | 0.01|vmr_phr | 0.00|pmr     |  0|phr     |  0|phr     |  0|phr     |
| 0.02|vmr_phr | 0.01|vmr_phr | 0.01|vhr_pmr | 0.00|mmr     |  0|mmr     |  0|mmr     |  0|mmr     |
| 0.02|vhr_pmr | 0.01|vhr_pmr | 0.00|pmr     | 0.00|mhr     |  0|mhr     |  0|mhr     |  0|mhr     |
| 0.00|pmr     | 0.00|pmr     | 0.00|mmr     | 0.00|vmr_phr |  0|vmr_phr |  0|vmr_phr |  0|vmr_phr |
| 0.00|mmr     | 0.00|mmr     | 0.00|mhr     | 0.00|vhr_pmr |  0|vhr_pmr |  0|vhr_pmr |  0|vhr_pmr |


## MC gains percentiles




Skewed $t$-distribution (sstd):  




|     |   vmr|   vhr|   pmr|   phr|   mmr|   mhr| vmr_phr| vhr_pmr|
|:----|-----:|-----:|-----:|-----:|-----:|-----:|-------:|-------:|
|0    | 98.42| 96.01| 98.14| 99.10| 97.69| 97.66|   98.12|   99.33|
|5    | 98.22| 95.65| 97.93| 98.99| 97.28| 97.38|   97.87|   99.24|
|10   | 97.87| 95.17| 97.62| 98.88| 96.89| 97.07|   97.64|   99.07|
|25   | 96.73| 93.58| 96.82| 98.48| 95.30| 96.20|   97.02|   98.40|
|50   | 94.14| 90.21| 94.87| 97.39| 91.83| 94.48|   95.33|   97.06|
|100  | 86.21| 82.80| 88.36| 93.62| 79.94| 89.15|   90.43|   91.81|
|200  | 60.00| 64.51| 58.32| 79.69| 43.17| 74.78|   74.18|   69.72|
|300  | 31.45| 44.64| 21.96| 62.03| 13.91| 56.66|   51.82|   40.16|
|400  | 13.13| 28.85|  4.09| 42.78|  2.34| 39.71|   31.31|   17.10|
|500  |  4.23| 17.79|  0.47| 26.76|  0.25| 25.93|   16.45|    5.03|
|1000 |  0.00|  0.64|  0.00|  1.10|  0.00|  1.33|    0.03|    0.00|




Standardized $t$-distribution (std):  




|     |   vmr|    vhr|   pmr|   phr|   mmr|   mhr| vmr_phr| vhr_pmr|
|:----|-----:|------:|-----:|-----:|-----:|-----:|-------:|-------:|
|0    | 99.70| 100.00| 99.53| 99.34| 99.33| 99.99|   99.32|   99.75|
|5    | 99.69| 100.00| 99.49| 99.32| 99.28| 99.97|   99.31|   99.72|
|10   | 99.66| 100.00| 99.48| 99.31| 99.24| 99.94|   99.28|   99.70|
|25   | 99.56|  99.96| 99.36| 99.23| 99.05| 99.89|   99.19|   99.57|
|50   | 99.30|  99.76| 99.10| 99.04| 98.66| 99.62|   98.96|   99.44|
|100  | 98.14|  99.00| 98.28| 98.57| 97.64| 97.67|   98.23|   98.60|
|200  | 91.21|  91.81| 93.31| 96.88| 92.44| 85.06|   96.04|   94.45|
|300  | 74.15|  76.57| 77.67| 94.20| 78.86| 63.95|   91.45|   83.72|
|400  | 52.89|  58.26| 50.37| 90.13| 57.50| 43.73|   83.16|   66.42|
|500  | 34.33|  41.54| 26.70| 84.31| 36.35| 28.08|   72.30|   48.40|
|1000 |  3.07|   5.36|  2.31| 45.74|  4.26|  2.29|   24.15|    6.89|


Normal distribution:  




|     |   vmr|   vhr|    pmr|   phr|    mmr|   mhr| vmr_phr| vhr_pmr|
|:----|-----:|-----:|------:|-----:|------:|-----:|-------:|-------:|
|0    | 99.98| 99.95| 100.00| 99.98| 100.00| 99.98|   99.98|   99.98|
|5    | 99.97| 99.91| 100.00| 99.97|  99.99| 99.97|   99.97|   99.98|
|10   | 99.93| 99.86|  99.99| 99.97|  99.99| 99.94|   99.96|   99.98|
|25   | 99.80| 99.67|  99.98| 99.90|  99.94| 99.87|   99.93|   99.94|
|50   | 98.88| 99.22|  99.66| 99.70|  99.47| 99.49|   99.52|   99.62|
|100  | 93.20| 96.68|  95.31| 98.11|  94.61| 97.50|   96.98|   96.61|
|200  | 63.11| 80.69|  57.67| 88.03|  60.69| 85.05|   80.27|   72.99|
|300  | 31.47| 58.10|  20.24| 70.20|  26.30| 63.51|   54.60|   41.88|
|400  | 13.59| 37.72|   4.54| 51.29|   8.32| 43.98|   32.95|   19.70|
|500  |  5.36| 22.81|   0.85| 35.10|   2.34| 28.60|   18.60|    8.74|
|1000 |  0.04|  1.51|   0.00|  3.81|   0.01|  2.25|    0.61|    0.06|



### Best ranking for MC gains percentiles

Skewed $t$-distribution (sstd):  


|     0|ranking |     5|ranking |    10|ranking |    25|ranking |    50|ranking |   100|ranking |
|-----:|:-------|-----:|:-------|-----:|:-------|-----:|:-------|-----:|:-------|-----:|:-------|
| 99.33|vhr_pmr | 99.24|vhr_pmr | 99.07|vhr_pmr | 98.48|phr     | 97.39|phr     | 93.62|phr     |
| 99.10|phr     | 98.99|phr     | 98.88|phr     | 98.40|vhr_pmr | 97.06|vhr_pmr | 91.81|vhr_pmr |
| 98.42|vmr     | 98.22|vmr     | 97.87|vmr     | 97.02|vmr_phr | 95.33|vmr_phr | 90.43|vmr_phr |
| 98.14|pmr     | 97.93|pmr     | 97.64|vmr_phr | 96.82|pmr     | 94.87|pmr     | 89.15|mhr     |
| 98.12|vmr_phr | 97.87|vmr_phr | 97.62|pmr     | 96.73|vmr     | 94.48|mhr     | 88.36|pmr     |
| 97.69|mmr     | 97.38|mhr     | 97.07|mhr     | 96.20|mhr     | 94.14|vmr     | 86.21|vmr     |
| 97.66|mhr     | 97.28|mmr     | 96.89|mmr     | 95.30|mmr     | 91.83|mmr     | 82.80|vhr     |
| 96.01|vhr     | 95.65|vhr     | 95.17|vhr     | 93.58|vhr     | 90.21|vhr     | 79.94|mmr     |


|   200|ranking |   300|ranking |   400|ranking |   500|ranking | 1000|ranking |
|-----:|:-------|-----:|:-------|-----:|:-------|-----:|:-------|----:|:-------|
| 79.69|phr     | 62.03|phr     | 42.78|phr     | 26.76|phr     | 1.33|mhr     |
| 74.78|mhr     | 56.66|mhr     | 39.71|mhr     | 25.93|mhr     | 1.10|phr     |
| 74.18|vmr_phr | 51.82|vmr_phr | 31.31|vmr_phr | 17.79|vhr     | 0.64|vhr     |
| 69.72|vhr_pmr | 44.64|vhr     | 28.85|vhr     | 16.45|vmr_phr | 0.03|vmr_phr |
| 64.51|vhr     | 40.16|vhr_pmr | 17.10|vhr_pmr |  5.03|vhr_pmr | 0.00|vmr     |
| 60.00|vmr     | 31.45|vmr     | 13.13|vmr     |  4.23|vmr     | 0.00|pmr     |
| 58.32|pmr     | 21.96|pmr     |  4.09|pmr     |  0.47|pmr     | 0.00|mmr     |
| 43.17|mmr     | 13.91|mmr     |  2.34|mmr     |  0.25|mmr     | 0.00|vhr_pmr |


Standardized $t$-distribution (std):  


|      0|ranking |      5|ranking |     10|ranking |    25|ranking |    50|ranking |   100|ranking |
|------:|:-------|------:|:-------|------:|:-------|-----:|:-------|-----:|:-------|-----:|:-------|
| 100.00|vhr     | 100.00|vhr     | 100.00|vhr     | 99.96|vhr     | 99.76|vhr     | 99.00|vhr     |
|  99.99|mhr     |  99.97|mhr     |  99.94|mhr     | 99.89|mhr     | 99.62|mhr     | 98.60|vhr_pmr |
|  99.75|vhr_pmr |  99.72|vhr_pmr |  99.70|vhr_pmr | 99.57|vhr_pmr | 99.44|vhr_pmr | 98.57|phr     |
|  99.70|vmr     |  99.69|vmr     |  99.66|vmr     | 99.56|vmr     | 99.30|vmr     | 98.28|pmr     |
|  99.53|pmr     |  99.49|pmr     |  99.48|pmr     | 99.36|pmr     | 99.10|pmr     | 98.23|vmr_phr |
|  99.34|phr     |  99.32|phr     |  99.31|phr     | 99.23|phr     | 99.04|phr     | 98.14|vmr     |
|  99.33|mmr     |  99.31|vmr_phr |  99.28|vmr_phr | 99.19|vmr_phr | 98.96|vmr_phr | 97.67|mhr     |
|  99.32|vmr_phr |  99.28|mmr     |  99.24|mmr     | 99.05|mmr     | 98.66|mmr     | 97.64|mmr     |


|   200|ranking |   300|ranking |   400|ranking |   500|ranking |  1000|ranking |
|-----:|:-------|-----:|:-------|-----:|:-------|-----:|:-------|-----:|:-------|
| 96.88|phr     | 94.20|phr     | 90.13|phr     | 84.31|phr     | 45.74|phr     |
| 96.04|vmr_phr | 91.45|vmr_phr | 83.16|vmr_phr | 72.30|vmr_phr | 24.15|vmr_phr |
| 94.45|vhr_pmr | 83.72|vhr_pmr | 66.42|vhr_pmr | 48.40|vhr_pmr |  6.89|vhr_pmr |
| 93.31|pmr     | 78.86|mmr     | 58.26|vhr     | 41.54|vhr     |  5.36|vhr     |
| 92.44|mmr     | 77.67|pmr     | 57.50|mmr     | 36.35|mmr     |  4.26|mmr     |
| 91.81|vhr     | 76.57|vhr     | 52.89|vmr     | 34.33|vmr     |  3.07|vmr     |
| 91.21|vmr     | 74.15|vmr     | 50.37|pmr     | 28.08|mhr     |  2.31|pmr     |
| 85.06|mhr     | 63.95|mhr     | 43.73|mhr     | 26.70|pmr     |  2.29|mhr     |


Normal distribution:  


|      0|ranking |      5|ranking |    10|ranking |    25|ranking |    50|ranking |   100|ranking |
|------:|:-------|------:|:-------|-----:|:-------|-----:|:-------|-----:|:-------|-----:|:-------|
| 100.00|pmr     | 100.00|pmr     | 99.99|pmr     | 99.98|pmr     | 99.70|phr     | 98.11|phr     |
| 100.00|mmr     |  99.99|mmr     | 99.99|mmr     | 99.94|mmr     | 99.66|pmr     | 97.50|mhr     |
|  99.98|vmr     |  99.98|vhr_pmr | 99.98|vhr_pmr | 99.94|vhr_pmr | 99.62|vhr_pmr | 96.98|vmr_phr |
|  99.98|phr     |  99.97|vmr     | 99.97|phr     | 99.93|vmr_phr | 99.52|vmr_phr | 96.68|vhr     |
|  99.98|mhr     |  99.97|phr     | 99.96|vmr_phr | 99.90|phr     | 99.49|mhr     | 96.61|vhr_pmr |
|  99.98|vmr_phr |  99.97|mhr     | 99.94|mhr     | 99.87|mhr     | 99.47|mmr     | 95.31|pmr     |
|  99.98|vhr_pmr |  99.97|vmr_phr | 99.93|vmr     | 99.80|vmr     | 99.22|vhr     | 94.61|mmr     |
|  99.95|vhr     |  99.91|vhr     | 99.86|vhr     | 99.67|vhr     | 98.88|vmr     | 93.20|vmr     |


|   200|ranking |   300|ranking |   400|ranking |   500|ranking | 1000|ranking |
|-----:|:-------|-----:|:-------|-----:|:-------|-----:|:-------|----:|:-------|
| 88.03|phr     | 70.20|phr     | 51.29|phr     | 35.10|phr     | 3.81|phr     |
| 85.05|mhr     | 63.51|mhr     | 43.98|mhr     | 28.60|mhr     | 2.25|mhr     |
| 80.69|vhr     | 58.10|vhr     | 37.72|vhr     | 22.81|vhr     | 1.51|vhr     |
| 80.27|vmr_phr | 54.60|vmr_phr | 32.95|vmr_phr | 18.60|vmr_phr | 0.61|vmr_phr |
| 72.99|vhr_pmr | 41.88|vhr_pmr | 19.70|vhr_pmr |  8.74|vhr_pmr | 0.06|vhr_pmr |
| 63.11|vmr     | 31.47|vmr     | 13.59|vmr     |  5.36|vmr     | 0.04|vmr     |
| 60.69|mmr     | 26.30|mmr     |  8.32|mmr     |  2.34|mmr     | 0.01|mmr     |
| 57.67|pmr     | 20.24|pmr     |  4.54|pmr     |  0.85|pmr     | 0.00|pmr     |






## Summary statistics  

### Fit summary

Summary for fit of log returns to an F-S skew standardized Student-t distribution.  
`m`  is the location parameter.  
`s` is the scale parameter.  
`nu` is the estimated degrees of freedom, or shape parameter.  
`xi` is the estimated skewness parameter.  


Skewed $t$-distribution (sstd):


|     |   vmr|   vhr|   pmr|   phr|   mmr|   mhr| vmr_phr| vhr_pmr|
|:----|-----:|-----:|-----:|-----:|-----:|-----:|-------:|-------:|
|m    | 0.060| 0.065| 0.058| 0.078| 0.052| 0.074|   0.070|   0.066|
|s    | 0.101| 0.150| 0.121| 0.113| 0.098| 0.139|   0.119|   0.090|
|nu   | 3.574| 3.144| 2.275| 3.856| 3.032| 3.095|   2.965|   3.569|
|xi   | 0.000| 0.002| 0.477| 0.015| 0.023| 0.006|   0.002|   0.003|
|PPCC | 0.993| 0.991| 0.991| 0.968| 0.992| 0.979|   0.977|   0.995|

The fits in this section are based on **n = 13** observations.

##### Standard errors

Standard errors for the skewed-$t$ parameters, from the observed Fisher information (the
inverse Hessian of the log-likelihood at the maximum). An entry of `NaN`/`NA` flags a
non-positive or singular information matrix: the parameter is then not locally identified
at this sample size.


|   |    vmr|   vhr|    pmr|    phr|   mmr| mhr| vmr_phr| vhr_pmr|
|:--|------:|-----:|------:|------:|-----:|---:|-------:|-------:|
|m  | 0.0022| 3e-04| 0.0252| 0.0001| 7e-04| NaN|  0.0001|     NaN|
|s  | 0.0022| 3e-04| 0.5618| 0.0001| 7e-04| NaN|  0.0001|     NaN|
|nu | 0.0058|   NaN| 2.7074| 0.0057| 2e-03| NaN|  0.0037|     NaN|
|xi |    NaN|   NaN| 0.2218|    NaN|   NaN| NaN|     NaN|  0.0167|



The four parameters split sharply by how much data they require. The location `m` and
scale `s` are pinned down even here -- their standard errors are a small fraction of the
estimates, on the order of what a Gaussian of the same mean and variance would give. The
tail index `nu` and skew `xi` are another matter. For 3 of the 8 funds the information matrix is singular, so nu and xi are not even locally identified. Where `nu` is identified its relative standard error
ranges from 0% to 119%; for `` vmr `` the
95% interval is approximately [3.6, 3.6], which
straddles both `nu = 2` (below which the variance ceases to exist) and `nu = 4` (below
which the kurtosis is infinite). At this sample size, then, the data cannot settle whether
the return variance is even finite. The skew for `` vmr `` is `xi` = 0
with 95% interval [NaN, NaN].
Because it is the tail parameters that carry the risk, this imprecision -- not the
well-determined mean -- is the binding constraint on what the fit can tell us (cf. the
$\kappa$ and $n_{\min}$ results below).


Standardized $t$-distribution (std):


|     |   vmr|   vhr|   pmr|   phr|   mmr|        mhr| vmr_phr| vhr_pmr|
|:----|-----:|-----:|-----:|-----:|-----:|----------:|-------:|-------:|
|m    | 0.086| 0.089| 0.085| 0.123| 0.088|      0.081|   0.109|   0.093|
|s    | 0.100| 0.101| 0.364| 0.276| 0.403|      0.099|   0.520|   0.118|
|nu   | 2.832| 6.486| 2.016| 2.104| 2.018| 435610.274|   2.020|   2.435|
|PPCC | 0.933| 0.955| 0.918| 0.897| 0.908|      0.937|   0.906|   0.923|


Normal distribution:  


|     |   vmr|   vhr|   pmr|   phr|   mmr|   mhr| vmr_phr| vhr_pmr|
|:----|-----:|-----:|-----:|-----:|-----:|-----:|-------:|-------:|
|m    | 0.064| 0.077| 0.061| 0.085| 0.063| 0.081|   0.076|   0.069|
|s    | 0.081| 0.099| 0.063| 0.101| 0.071| 0.099|   0.090|   0.081|
|PPCC | 0.933| 0.954| 0.916| 0.923| 0.911| 0.937|   0.924|   0.927|


#### AIC and BIC  


AIC





|       |     vmr|     vhr|     pmr|     phr|     mmr|     mhr| vmr_phr| vhr_pmr|
|:------|-------:|-------:|-------:|-------:|-------:|-------:|-------:|-------:|
|sstd   | -28.098| -21.425| -33.230| -23.741| -33.930| -22.790| -26.979| -30.291|
|std    | -23.094| -17.383| -30.954| -16.298| -27.659| -17.345| -20.035| -23.692|
|normal | -24.316| -19.218| -31.005| -18.616| -27.809| -19.345| -21.593| -24.613|


BIC  




|       |     vmr|     vhr|     pmr|     phr|     mmr|     mhr| vmr_phr| vhr_pmr|
|:------|-------:|-------:|-------:|-------:|-------:|-------:|-------:|-------:|
|sstd   | -25.838| -19.165| -30.970| -21.482| -31.670| -20.530| -24.720| -28.031|
|std    | -21.399| -15.688| -29.259| -14.603| -25.964| -15.650| -18.340| -21.997|
|normal | -23.186| -18.088| -29.876| -17.487| -26.680| -18.215| -20.463| -23.483|

#### Anderson-Darling (tail-weighted goodness-of-fit)

The probability-plot PPCC above and the AIC/BIC just shown are all relatively insensitive to
the *tails* -- the region where fat-tailed returns depart from a Gaussian, and the region
that matters for risk. The Anderson-Darling statistic $A^2$ weights the fit discrepancy by
$1/[F(1-F)]$, concentrating its weight in the tails; a larger $A^2$ is a worse fit. Because
the parameters are estimated from the same sample, the textbook $A^2$ critical values do not
apply, so the p-value is obtained by a parametric bootstrap -- simulate from the fitted model,
refit, recompute $A^2$, 499 replicates -- and a small p rejects the distribution.

$A^2$ statistic (larger = worse tail fit):


|       |  vmr|  vhr|  pmr|  phr|  mmr|  mhr| vmr_phr| vhr_pmr|
|:------|----:|----:|----:|----:|----:|----:|-------:|-------:|
|sstd   | 1.40| 0.89| 0.23| 0.87| 0.61| 0.78|    1.21|    1.17|
|std    | 0.53| 0.33| 0.79| 0.81| 0.69| 0.70|    0.74|    0.52|
|normal | 0.66| 0.43| 0.86| 0.89| 0.86| 0.70|    0.84|    0.68|

Parametric-bootstrap p-value (small = reject the distribution):


|       |   vmr|   vhr|   pmr|   phr|   mmr|   mhr| vmr_phr| vhr_pmr|
|:------|-----:|-----:|-----:|-----:|-----:|-----:|-------:|-------:|
|sstd   | 0.381| 0.687| 0.840| 0.673| 0.830| 0.725|   0.515|   0.539|
|std    | 0.136| 0.429| 0.038| 0.030| 0.070| 0.026|   0.054|   0.144|
|normal | 0.080| 0.305| 0.016| 0.012| 0.016| 0.062|   0.020|   0.070|

Where AIC and BIC only *rank* the three candidates, Anderson-Darling asks whether the chosen
one is actually adequate in the tail: a distribution that AIC prefers can still be rejected
here if it misfits where the weight is. Read it together with the max-sum plots below, which
test the stronger question of whether the relevant moments exist at all.

#### Max-sum plots (moment existence)

The max-sum plot, shown per series in the individual reports, is the most direct
goodness-of-fit check for fat tails -- and it asks the question that *precedes* the
comparisons above. For each moment $p$ it tracks $\max_{i\le n}|X_i|^p \big/
\sum_{i\le n}|X_i|^p$ as the sample grows: if the $p$-th moment is finite the ratio must fall
toward zero, because no single observation can dominate the sum; if a new extreme keeps
overwhelming the running total the ratio refuses to settle, and any statistic that assumes
that moment -- the variance, the kurtosis, the Gaussian-likelihood AIC -- is then estimating
something that is not defined. Where the PPCC and AIC/BIC compare only the *shape* of a
distribution, this asks whether the moments those comparisons lean on exist at all.

#### Kappa

Let $\{X_{g,i}\}$ be Gaussian distributed with mean $\mu$ and scale $\sigma$.

Let $\{X_{\nu,i}\}$ be $t$-distributed, scaled such that $\mathbb{M}^{\nu}(1) = \mathbb{M}^{g}(1) = \sqrt{\frac{2}{\pi}} \sigma$.

Given $n_g$, we want to determine  and $n_{\nu}^{*}$ such that

$$\text{Var}\left[\sum_i^{n_g} X_{g,i}\right] = \text{Var}\left[\sum_i^{n_{\nu}^{*}} X_{\nu,i}\right]$$

For iid. r.v $\{X_i\}$:

$$S_n = X_1 + X_2 + \dots + X_n$$
$$\mathbb{M}(n) = \mathbb{E}(\lvert S_n - \mathbb{E}(S_n)\rvert)$$
Taleb's convergence metric ($\kappa$):

The "rate" of convergence for $n$ summands vs $n_0$, i.e. the improved convergence achieved by $n - n_0$ additional terms, is given by $\kappa(n_0, n)$:

$$\kappa(n_0, n) = 2 - \dfrac{\log(n) - \log(n_0)}{\log\left(\frac{\mathbb{M}(n)}{\mathbb{M}(n_0)}\right)}$$

$\kappa$    


|  vmr|  vhr|  pmr|  phr|  mmr|  mhr| vmr_phr| vhr_pmr|
|----:|----:|----:|----:|----:|----:|-------:|-------:|
| 0.18| 0.21| 0.32| 0.16| 0.22| 0.22|    0.23|    0.18|


$n_{min}$  

What is the minimum value of $n_{\nu}$, the number of observations from a given skewed $t$-distribution, we need to achieve the same degree of convergence as with $n_g=30$ observations from a Gaussian distribution with the same mean and standard deviation?


| vmr| vhr| pmr| phr| mmr| mhr| vmr_phr| vhr_pmr|
|---:|---:|---:|---:|---:|---:|-------:|-------:|
|  61|  74| 157|  56|  78|  75|      84|      60|



#### Fit statistics ranking  


Skewed $t$-distribution (sstd):  


|     m|ranking |     s|ranking |  PPCC|ranking |
|-----:|:-------|-----:|:-------|-----:|:-------|
| 0.078|phr     | 0.090|vhr_pmr | 0.995|vhr_pmr |
| 0.074|mhr     | 0.098|mmr     | 0.993|vmr     |
| 0.070|vmr_phr | 0.101|vmr     | 0.992|mmr     |
| 0.066|vhr_pmr | 0.113|phr     | 0.991|vhr     |
| 0.065|vhr     | 0.119|vmr_phr | 0.991|pmr     |
| 0.060|vmr     | 0.121|pmr     | 0.979|mhr     |
| 0.058|pmr     | 0.139|mhr     | 0.977|vmr_phr |
| 0.052|mmr     | 0.150|vhr     | 0.968|phr     |


Standardized $t$-distribution (std):  


|     m|ranking |     s|ranking |  PPCC|ranking |
|-----:|:-------|-----:|:-------|-----:|:-------|
| 0.123|phr     | 0.099|mhr     | 0.955|vhr     |
| 0.109|vmr_phr | 0.100|vmr     | 0.937|mhr     |
| 0.093|vhr_pmr | 0.101|vhr     | 0.933|vmr     |
| 0.089|vhr     | 0.118|vhr_pmr | 0.923|vhr_pmr |
| 0.088|mmr     | 0.276|phr     | 0.918|pmr     |
| 0.086|vmr     | 0.364|pmr     | 0.908|mmr     |
| 0.085|pmr     | 0.403|mmr     | 0.906|vmr_phr |
| 0.081|mhr     | 0.520|vmr_phr | 0.897|phr     |

Normal distribution:  


|     m|ranking |     s|ranking |  PPCC|ranking |
|-----:|:-------|-----:|:-------|-----:|:-------|
| 0.085|phr     | 0.063|pmr     | 0.954|vhr     |
| 0.081|mhr     | 0.071|mmr     | 0.937|mhr     |
| 0.077|vhr     | 0.081|vhr_pmr | 0.933|vmr     |
| 0.076|vmr_phr | 0.081|vmr     | 0.927|vhr_pmr |
| 0.069|vhr_pmr | 0.090|vmr_phr | 0.924|vmr_phr |
| 0.064|vmr     | 0.099|mhr     | 0.923|phr     |
| 0.063|mmr     | 0.099|vhr     | 0.916|pmr     |
| 0.061|pmr     | 0.101|phr     | 0.911|mmr     |



### Monte Carlo simulations summary

Monte Carlo simulations of portfolio index values (currency values).  
Statistics are given for the final state of all paths.  
Probability of down-and-out is calculated as the share of paths that reach 0 at
some point. All subsequent values for a path are set to 0, if the path reaches
at any point.  
0 is defined as any value below a threshold.    
`dai_pct` (for down-and-in) is the probability of losing money. This is calculated as the 
share of paths finishing below index 100.  

```
## Number of paths: 10000
```


Skewed $t$-distribution (sstd):  




|        |     vmr|     vhr|     pmr|     phr|    mmr|     mhr| vmr_phr| vhr_pmr|
|:-------|-------:|-------:|-------:|-------:|------:|-------:|-------:|-------:|
|mc_m    |  366.93|  435.51|  342.34|  531.52| 302.99|  509.44|  456.01|  401.75|
|mc_s    |  147.50|  239.24|  113.25|  242.29| 110.31|  262.24|  197.01|  144.15|
|mc_min  |    3.00|    3.00|    3.00|    3.00|   3.00|    3.00|    3.00|   14.55|
|mc_max  | 1055.00| 2342.09| 1020.96| 1874.86| 764.72| 1809.29| 1488.44|  993.09|
|dao_pct |    0.01|    0.06|    0.05|    0.01|   0.02|    0.08|    0.03|    0.00|
|dai_pct |    1.38|    3.93|    1.73|    0.75|   2.23|    2.12|    1.73|    0.54|


Standardized $t$-distribution (std):  




|        |       vmr|     vhr|       pmr|          phr|          mmr|     mhr|      vmr_phr|     vhr_pmr|
|:-------|---------:|-------:|---------:|------------:|------------:|-------:|------------:|-----------:|
|mc_m    |    644.62|  656.27|    733.78|     41445.78| 9.161221e+15|  557.93| 4.497626e+12|     8124.88|
|mc_s    |   2610.36|  304.04|   8176.45|   2684713.13| 9.161221e+17|  258.57| 4.497626e+14|   523528.10|
|mc_min  |     10.51|  109.23|      3.00|         3.00| 3.000000e+00|   94.75| 3.000000e+00|        3.00|
|mc_max  | 258703.20| 2860.59| 763414.40| 227347887.30| 9.161221e+19| 3994.77| 4.497626e+16| 40789310.71|
|dao_pct |      0.00|    0.00|      0.04|         0.17| 5.000000e-02|    0.00| 1.500000e-01|        0.02|
|dai_pct |      0.27|    0.00|      0.44|         0.59| 6.300000e-01|    0.02| 6.700000e-01|        0.20|


Normal distribution:  




|        |     vmr|     vhr|     pmr|     phr|     mmr|     mhr| vmr_phr| vhr_pmr|
|:-------|-------:|-------:|-------:|-------:|-------:|-------:|-------:|-------:|
|mc_m    |  386.26|  518.56|  349.99|  609.45|  366.15|  559.60|  491.14|  426.26|
|mc_s    |  146.31|  240.09|  100.16|  288.66|  118.88|  259.28|  205.87|  158.50|
|mc_min  |   83.76|   94.08|  105.27|   78.56|  111.63|  102.89|   94.38|   89.34|
|mc_max  | 1411.76| 2859.23| 1097.62| 3003.95| 1218.20| 2591.09| 2460.90| 1577.51|
|dao_pct |    0.00|    0.00|    0.00|    0.00|    0.00|    0.00|    0.00|    0.00|
|dai_pct |    0.01|    0.04|    0.00|    0.01|    0.00|    0.00|    0.01|    0.01|


#### Ranking  


Skewed $t$-distribution (sstd):  


|   mc_m|ranking |   mc_s|ranking | mc_min|ranking |  mc_max|ranking | dao_pct|ranking | dai_pct|ranking |
|------:|:-------|------:|:-------|------:|:-------|-------:|:-------|-------:|:-------|-------:|:-------|
| 531.52|phr     | 110.31|mmr     |  14.55|vhr_pmr | 2342.09|vhr     |    0.00|vhr_pmr |    0.54|vhr_pmr |
| 509.44|mhr     | 113.25|pmr     |   3.00|vmr     | 1874.86|phr     |    0.01|vmr     |    0.75|phr     |
| 456.01|vmr_phr | 144.15|vhr_pmr |   3.00|vhr     | 1809.29|mhr     |    0.01|phr     |    1.38|vmr     |
| 435.51|vhr     | 147.50|vmr     |   3.00|pmr     | 1488.44|vmr_phr |    0.02|mmr     |    1.73|pmr     |
| 401.75|vhr_pmr | 197.01|vmr_phr |   3.00|phr     | 1055.00|vmr     |    0.03|vmr_phr |    1.73|vmr_phr |
| 366.93|vmr     | 239.24|vhr     |   3.00|mmr     | 1020.96|pmr     |    0.05|pmr     |    2.12|mhr     |
| 342.34|pmr     | 242.29|phr     |   3.00|mhr     |  993.09|vhr_pmr |    0.06|vhr     |    2.23|mmr     |
| 302.99|mmr     | 262.24|mhr     |   3.00|vmr_phr |  764.72|mmr     |    0.08|mhr     |    3.93|vhr     |


Standardized $t$-distribution (std):  


|         mc_m|ranking |         mc_s|ranking | mc_min|ranking |       mc_max|ranking | dao_pct|ranking | dai_pct|ranking |
|------------:|:-------|------------:|:-------|------:|:-------|------------:|:-------|-------:|:-------|-------:|:-------|
| 9.161221e+15|mmr     | 2.585700e+02|mhr     | 109.23|vhr     | 9.161221e+19|mmr     |    0.00|vmr     |    0.00|vhr     |
| 4.497626e+12|vmr_phr | 3.040400e+02|vhr     |  94.75|mhr     | 4.497626e+16|vmr_phr |    0.00|vhr     |    0.02|mhr     |
| 4.144578e+04|phr     | 2.610360e+03|vmr     |  10.51|vmr     | 2.273479e+08|phr     |    0.00|mhr     |    0.20|vhr_pmr |
| 8.124880e+03|vhr_pmr | 8.176450e+03|pmr     |   3.00|pmr     | 4.078931e+07|vhr_pmr |    0.02|vhr_pmr |    0.27|vmr     |
| 7.337800e+02|pmr     | 5.235281e+05|vhr_pmr |   3.00|phr     | 7.634144e+05|pmr     |    0.04|pmr     |    0.44|pmr     |
| 6.562700e+02|vhr     | 2.684713e+06|phr     |   3.00|mmr     | 2.587032e+05|vmr     |    0.05|mmr     |    0.59|phr     |
| 6.446200e+02|vmr     | 4.497626e+14|vmr_phr |   3.00|vmr_phr | 3.994770e+03|mhr     |    0.15|vmr_phr |    0.63|mmr     |
| 5.579300e+02|mhr     | 9.161221e+17|mmr     |   3.00|vhr_pmr | 2.860590e+03|vhr     |    0.17|phr     |    0.67|vmr_phr |


Normal distribution:  


|   mc_m|ranking |   mc_s|ranking | mc_min|ranking |  mc_max|ranking | dao_pct|ranking | dai_pct|ranking |
|------:|:-------|------:|:-------|------:|:-------|-------:|:-------|-------:|:-------|-------:|:-------|
| 609.45|phr     | 100.16|pmr     | 111.63|mmr     | 3003.95|phr     |       0|vmr     |    0.00|pmr     |
| 559.60|mhr     | 118.88|mmr     | 105.27|pmr     | 2859.23|vhr     |       0|vhr     |    0.00|mmr     |
| 518.56|vhr     | 146.31|vmr     | 102.89|mhr     | 2591.09|mhr     |       0|pmr     |    0.00|mhr     |
| 491.14|vmr_phr | 158.50|vhr_pmr |  94.38|vmr_phr | 2460.90|vmr_phr |       0|phr     |    0.01|vmr     |
| 426.26|vhr_pmr | 205.87|vmr_phr |  94.08|vhr     | 1577.51|vhr_pmr |       0|mmr     |    0.01|phr     |
| 386.26|vmr     | 240.09|vhr     |  89.34|vhr_pmr | 1411.76|vmr     |       0|mhr     |    0.01|vmr_phr |
| 366.15|mmr     | 259.28|mhr     |  83.76|vmr     | 1218.20|mmr     |       0|vmr_phr |    0.01|vhr_pmr |
| 349.99|pmr     | 288.66|phr     |  78.56|phr     | 1097.62|pmr     |       0|vhr_pmr |    0.04|vhr     |



# Compare Gaussian and skewed t-distribution fits

## Gaussian vs skewed t



Probability in percent that the smallest and largest (respectively) observed return for each fund was generated by a normal distribution:

|              |    vmr|    vhr|    pmr|    phr|    mmr|    mhr| vmr_phr| vhr_pmr|
|:-------------|------:|------:|------:|------:|------:|------:|-------:|-------:|
|P_norm(X_min) |  0.571|  0.758|  0.511|  1.676|  0.478|  1.047|   0.984|   0.548|
|P_norm(X_max) | 13.230| 11.876| 12.922| 15.359| 15.936| 13.198|  15.397|  15.556|
|P_t(X_min)    |  3.743|  5.457|  3.475|  4.567|  4.100|  5.035|   4.182|   3.022|
|P_t(X_max)    |  0.000|  0.001|  2.818|  0.023|  0.052|  0.004|   0.000|   0.001|

Average number of years between min or max events (respectively):

|                      |          vmr|        vhr|     pmr|      phr|      mmr|       mhr|    vmr_phr|    vhr_pmr|
|:---------------------|------------:|----------:|-------:|--------:|--------:|---------:|----------:|----------:|
|norm: avg yrs btw min | 1.752480e+02|    131.911| 195.568|   59.669|  209.046|    95.548|    101.596|    182.400|
|norm: avg yrs btw max | 7.559000e+00|      8.420|   7.739|    6.511|    6.275|     7.577|      6.495|      6.428|
|t: avg yrs btw min    | 2.671500e+01|     18.324|  28.775|   21.898|   24.387|    19.862|     23.914|     33.089|
|t: avg yrs btw max    | 3.834699e+08| 178349.076|  35.487| 4439.617| 1930.115| 23903.982| 236209.128| 124926.544|


### Lilliefors test  






p-values for Lilliefors test.  
Testing $H_0$, that log-returns are Gaussian.


|        |   vmr|   vhr|   pmr|  phr|   mmr|   mhr| vmr_phr| vhr_pmr|
|:-------|-----:|-----:|-----:|----:|-----:|-----:|-------:|-------:|
|p value | 0.052| 0.343| 0.024| 0.06| 0.041| 0.251|   0.113|   0.183|



### Wittgenstein's Ruler  


For different given probabilities that returns are Gaussian, what is the probability that the distribution is Gaussian rather than skewed t-distributed, given the smallest/largest observed log-returns?

Conditional probabilities for smallest observed log-returns:

![](pension-returns_annual_files/figure-html/unnamed-chunk-183-1.png)<!-- -->


Use $1 - \text{p-value}$ from Lilliefors test as prior probability that the distribution is Gaussian.  
$x_{\text{obs}} = \min(x)$ and $P[\text{Event}\ |\ \text{Gaussian}] = P_{\text{Gauss}}[X \leq x_{\text{min}}]$:




|                      |   vmr|   vhr|   pmr|   phr|   mmr|   mhr| vmr_phr| vhr_pmr|
|:---------------------|-----:|-----:|-----:|-----:|-----:|-----:|-------:|-------:|
|Lillie p-val          | 0.052| 0.343| 0.024| 0.060| 0.041| 0.251|   0.113|   0.183|
|Prior prob            | 0.948| 0.657| 0.976| 0.940| 0.959| 0.749|   0.887|   0.817|
|P[Gauss &#124; Event] | 0.737| 0.210| 0.855| 0.852| 0.730| 0.383|   0.649|   0.448|



Use $1 - \text{p-value}$ from Lilliefors test as prior probability that the distribution is Gaussian.  
$x_{\text{obs}} = \max(x)$ and $P[\text{Event}\ |\ \text{Gaussian}] = P_{\text{Gauss}}[X \geq x_{\text{max}}]$:

![](pension-returns_annual_files/figure-html/unnamed-chunk-186-1.png)<!-- -->




|                      |   vmr|   vhr|   pmr|  phr|   mmr|   mhr| vmr_phr| vhr_pmr|
|:---------------------|-----:|-----:|-----:|----:|-----:|-----:|-------:|-------:|
|Lillie p-val          | 0.052| 0.343| 0.024| 0.06| 0.041| 0.251|   0.113|   0.183|
|Prior prob            | 0.948| 0.657| 0.976| 0.94| 0.959| 0.749|   0.887|   0.817|
|P[Gauss &#124; Event] | 1.000| 1.000| 0.995| 1.00| 1.000| 1.000|   1.000|   1.000|


# Velliv medium risk (vmr), 2011 - 2023




## QQ Plot

Skewed $t$-distribution (sstd):  

![](pension-returns_annual_files/figure-html/unnamed-chunk-273-1.png)<!-- -->



## Data vs fit

Let's plot the fit and the observed returns together.  

![](pension-returns_annual_files/figure-html/unnamed-chunk-274-1.png)<!-- -->



## Estimated distribution

Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pension-returns_annual_files/figure-html/unnamed-chunk-275-1.png)<!-- -->



## Monte Carlo



















Sorted portfolio index values for last period of all runs

![](pension-returns_annual_files/figure-html/unnamed-chunk-280-1.png)<!-- -->


## Convergence

### Max vs sum

Max-vs-sum plots for the first four moments -- a ratio that doesn't fall toward zero flags
that moment as possibly non-existent (see "Max-sum plots" in the comparison report for what
this diagnostic tests). Panels by fitted distribution:

![](pension-returns_annual_files/figure-html/unnamed-chunk-281-1.png)<!-- -->




### MC

![](pension-returns_annual_files/figure-html/unnamed-chunk-282-1.png)<!-- -->


### IS

Skewed $t$-distribution with a normal proposal distribution.

![](pension-returns_annual_files/figure-html/unnamed-chunk-283-1.png)<!-- -->

Parameters

```
## [1] 1.3814456 0.4037569
```

Objective function plots

![](pension-returns_annual_files/figure-html/unnamed-chunk-285-1.png)<!-- -->





# Velliv high risk (vhr), 2011 - 2023




## QQ Plot

Skewed $t$-distribution (sstd):  

![](pension-returns_annual_files/figure-html/unnamed-chunk-302-1.png)<!-- -->



## Data vs fit

Let's plot the fit and the observed returns together.  

![](pension-returns_annual_files/figure-html/unnamed-chunk-303-1.png)<!-- -->



## Estimated distribution

Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pension-returns_annual_files/figure-html/unnamed-chunk-304-1.png)<!-- -->



## Monte Carlo



















Sorted portfolio index values for last period of all runs

![](pension-returns_annual_files/figure-html/unnamed-chunk-309-1.png)<!-- -->


## Convergence

### Max vs sum

Max-vs-sum plots for the first four moments -- a ratio that doesn't fall toward zero flags
that moment as possibly non-existent (see "Max-sum plots" in the comparison report for what
this diagnostic tests). Panels by fitted distribution:

![](pension-returns_annual_files/figure-html/unnamed-chunk-310-1.png)<!-- -->




### MC

![](pension-returns_annual_files/figure-html/unnamed-chunk-311-1.png)<!-- -->


### IS

Skewed $t$-distribution with a normal proposal distribution.

![](pension-returns_annual_files/figure-html/unnamed-chunk-312-1.png)<!-- -->

Parameters

```
## [1] 1.6232606 0.5374871
```

Objective function plots

![](pension-returns_annual_files/figure-html/unnamed-chunk-314-1.png)<!-- -->





# PFA medium risk (pmr), 2011 - 2023




## QQ Plot

Skewed $t$-distribution (sstd):  

![](pension-returns_annual_files/figure-html/unnamed-chunk-331-1.png)<!-- -->



## Data vs fit

Let's plot the fit and the observed returns together.  

![](pension-returns_annual_files/figure-html/unnamed-chunk-332-1.png)<!-- -->



## Estimated distribution

Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pension-returns_annual_files/figure-html/unnamed-chunk-333-1.png)<!-- -->



## Monte Carlo








pmr has the sstd fit with the lowest value of nu. Compare with other distributions:



![](pension-returns_annual_files/figure-html/unnamed-chunk-335-1.png)<!-- -->

![](pension-returns_annual_files/figure-html/unnamed-chunk-336-1.png)<!-- -->

![](pension-returns_annual_files/figure-html/unnamed-chunk-337-1.png)<!-- -->


Sorted portfolio index values for last period of all runs

![](pension-returns_annual_files/figure-html/unnamed-chunk-338-1.png)<!-- -->


## Convergence

### Max vs sum

Max-vs-sum plots for the first four moments -- a ratio that doesn't fall toward zero flags
that moment as possibly non-existent (see "Max-sum plots" in the comparison report for what
this diagnostic tests). Panels by fitted distribution:

![](pension-returns_annual_files/figure-html/unnamed-chunk-339-1.png)<!-- -->




### MC

![](pension-returns_annual_files/figure-html/unnamed-chunk-340-1.png)<!-- -->


### IS

Skewed $t$-distribution with a normal proposal distribution.

![](pension-returns_annual_files/figure-html/unnamed-chunk-341-1.png)<!-- -->

Parameters

```
## [1] 1.2899115 0.3384805
```

Objective function plots

![](pension-returns_annual_files/figure-html/unnamed-chunk-343-1.png)<!-- -->





# PFA high risk (phr), 2011 - 2023




## QQ Plot

Skewed $t$-distribution (sstd):  

![](pension-returns_annual_files/figure-html/unnamed-chunk-360-1.png)<!-- -->



## Data vs fit

Let's plot the fit and the observed returns together.  

![](pension-returns_annual_files/figure-html/unnamed-chunk-361-1.png)<!-- -->



## Estimated distribution

Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pension-returns_annual_files/figure-html/unnamed-chunk-362-1.png)<!-- -->



## Monte Carlo






phr has the sstd fit with the highest sstd fit with thevalue of nu. Compare with other distributions:





![](pension-returns_annual_files/figure-html/unnamed-chunk-364-1.png)<!-- -->

![](pension-returns_annual_files/figure-html/unnamed-chunk-365-1.png)<!-- -->

![](pension-returns_annual_files/figure-html/unnamed-chunk-366-1.png)<!-- -->


Sorted portfolio index values for last period of all runs

![](pension-returns_annual_files/figure-html/unnamed-chunk-367-1.png)<!-- -->


## Convergence

### Max vs sum

Max-vs-sum plots for the first four moments -- a ratio that doesn't fall toward zero flags
that moment as possibly non-existent (see "Max-sum plots" in the comparison report for what
this diagnostic tests). Panels by fitted distribution:

![](pension-returns_annual_files/figure-html/unnamed-chunk-368-1.png)<!-- -->




### MC

![](pension-returns_annual_files/figure-html/unnamed-chunk-369-1.png)<!-- -->


### IS

Skewed $t$-distribution with a normal proposal distribution.

![](pension-returns_annual_files/figure-html/unnamed-chunk-370-1.png)<!-- -->

Parameters

```
## [1] 1.7723168 0.4503299
```

Objective function plots

![](pension-returns_annual_files/figure-html/unnamed-chunk-372-1.png)<!-- -->





# Mix medium risk (mmr), 2011 - 2023




## QQ Plot

Skewed $t$-distribution (sstd):  

![](pension-returns_annual_files/figure-html/unnamed-chunk-389-1.png)<!-- -->



## Data vs fit

Let's plot the fit and the observed returns together.  

![](pension-returns_annual_files/figure-html/unnamed-chunk-390-1.png)<!-- -->



## Estimated distribution

Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pension-returns_annual_files/figure-html/unnamed-chunk-391-1.png)<!-- -->



## Monte Carlo



















Sorted portfolio index values for last period of all runs

![](pension-returns_annual_files/figure-html/unnamed-chunk-396-1.png)<!-- -->


## Convergence

### Max vs sum

Max-vs-sum plots for the first four moments -- a ratio that doesn't fall toward zero flags
that moment as possibly non-existent (see "Max-sum plots" in the comparison report for what
this diagnostic tests). Panels by fitted distribution:

![](pension-returns_annual_files/figure-html/unnamed-chunk-397-1.png)<!-- -->




### MC

![](pension-returns_annual_files/figure-html/unnamed-chunk-398-1.png)<!-- -->


### IS

Skewed $t$-distribution with a normal proposal distribution.

![](pension-returns_annual_files/figure-html/unnamed-chunk-399-1.png)<!-- -->

Parameters

```
## [1] 1.1788862 0.3716428
```

Objective function plots

![](pension-returns_annual_files/figure-html/unnamed-chunk-401-1.png)<!-- -->





# Mix high risk (mhr), 2011 - 2023




## QQ Plot

Skewed $t$-distribution (sstd):  

![](pension-returns_annual_files/figure-html/unnamed-chunk-418-1.png)<!-- -->



## Data vs fit

Let's plot the fit and the observed returns together.  

![](pension-returns_annual_files/figure-html/unnamed-chunk-419-1.png)<!-- -->



## Estimated distribution

Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pension-returns_annual_files/figure-html/unnamed-chunk-420-1.png)<!-- -->



## Monte Carlo



















Sorted portfolio index values for last period of all runs

![](pension-returns_annual_files/figure-html/unnamed-chunk-425-1.png)<!-- -->


## Convergence

### Max vs sum

Max-vs-sum plots for the first four moments -- a ratio that doesn't fall toward zero flags
that moment as possibly non-existent (see "Max-sum plots" in the comparison report for what
this diagnostic tests). Panels by fitted distribution:

![](pension-returns_annual_files/figure-html/unnamed-chunk-426-1.png)<!-- -->




### MC

![](pension-returns_annual_files/figure-html/unnamed-chunk-427-1.png)<!-- -->


### IS

Skewed $t$-distribution with a normal proposal distribution.

![](pension-returns_annual_files/figure-html/unnamed-chunk-428-1.png)<!-- -->

Parameters

```
## [1] 1.7626092 0.5077478
```

Objective function plots

![](pension-returns_annual_files/figure-html/unnamed-chunk-430-1.png)<!-- -->





# Mix vmr+phr (vm_ph), 2011 - 2023




## QQ Plot

Skewed $t$-distribution (sstd):  

![](pension-returns_annual_files/figure-html/unnamed-chunk-447-1.png)<!-- -->



## Data vs fit

Let's plot the fit and the observed returns together.  

![](pension-returns_annual_files/figure-html/unnamed-chunk-448-1.png)<!-- -->



## Estimated distribution

Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pension-returns_annual_files/figure-html/unnamed-chunk-449-1.png)<!-- -->



## Monte Carlo



















Sorted portfolio index values for last period of all runs

![](pension-returns_annual_files/figure-html/unnamed-chunk-454-1.png)<!-- -->


## Convergence

### Max vs sum

Max-vs-sum plots for the first four moments -- a ratio that doesn't fall toward zero flags
that moment as possibly non-existent (see "Max-sum plots" in the comparison report for what
this diagnostic tests). Panels by fitted distribution:

![](pension-returns_annual_files/figure-html/unnamed-chunk-455-1.png)<!-- -->




### MC

![](pension-returns_annual_files/figure-html/unnamed-chunk-456-1.png)<!-- -->


### IS

Skewed $t$-distribution with a normal proposal distribution.

![](pension-returns_annual_files/figure-html/unnamed-chunk-457-1.png)<!-- -->

Parameters

```
## [1] 1.6160234 0.4361716
```

Objective function plots

![](pension-returns_annual_files/figure-html/unnamed-chunk-459-1.png)<!-- -->





# Mix vhr+pmr (mh_pm), 2011 - 2023




## QQ Plot

Skewed $t$-distribution (sstd):  

![](pension-returns_annual_files/figure-html/unnamed-chunk-476-1.png)<!-- -->



## Data vs fit

Let's plot the fit and the observed returns together.  

![](pension-returns_annual_files/figure-html/unnamed-chunk-477-1.png)<!-- -->



## Estimated distribution

Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pension-returns_annual_files/figure-html/unnamed-chunk-478-1.png)<!-- -->



## Monte Carlo



















Sorted portfolio index values for last period of all runs

![](pension-returns_annual_files/figure-html/unnamed-chunk-483-1.png)<!-- -->


## Convergence

### Max vs sum

Max-vs-sum plots for the first four moments -- a ratio that doesn't fall toward zero flags
that moment as possibly non-existent (see "Max-sum plots" in the comparison report for what
this diagnostic tests). Panels by fitted distribution:

![](pension-returns_annual_files/figure-html/unnamed-chunk-484-1.png)<!-- -->




### MC

![](pension-returns_annual_files/figure-html/unnamed-chunk-485-1.png)<!-- -->


### IS

Skewed $t$-distribution with a normal proposal distribution.

![](pension-returns_annual_files/figure-html/unnamed-chunk-486-1.png)<!-- -->

Parameters

```
## [1] 1.4560560 0.3635845
```

Objective function plots

![](pension-returns_annual_files/figure-html/unnamed-chunk-488-1.png)<!-- -->


# Velliv medium risk (vmr), 2011 - 2023




## QQ Plot

Skewed $t$-distribution (sstd):  

![](pension-returns_annual_files/figure-html/unnamed-chunk-506-1.png)<!-- -->



## Data vs fit

Let's plot the fit and the observed returns together.  

![](pension-returns_annual_files/figure-html/unnamed-chunk-507-1.png)<!-- -->



## Estimated distribution

Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pension-returns_annual_files/figure-html/unnamed-chunk-508-1.png)<!-- -->



## Monte Carlo



















Sorted portfolio index values for last period of all runs

![](pension-returns_annual_files/figure-html/unnamed-chunk-513-1.png)<!-- -->


## Convergence

### Max vs sum

Max-vs-sum plots for the first four moments -- a ratio that doesn't fall toward zero flags
that moment as possibly non-existent (see "Max-sum plots" in the comparison report for what
this diagnostic tests). Panels by fitted distribution:

![](pension-returns_annual_files/figure-html/unnamed-chunk-514-1.png)<!-- -->




### MC

![](pension-returns_annual_files/figure-html/unnamed-chunk-515-1.png)<!-- -->


### IS

Skewed $t$-distribution with a normal proposal distribution.

![](pension-returns_annual_files/figure-html/unnamed-chunk-516-1.png)<!-- -->

Parameters

```
## [1] 1.3814456 0.4037569
```

Objective function plots

![](pension-returns_annual_files/figure-html/unnamed-chunk-518-1.png)<!-- -->












# Discussion

With the data frozen we can step back and ask what these numbers and graphs actually tell
us.

## The plans are one portfolio at different leverage

The most consequential finding is structural. The four plans are not four different
stock/bond mixes; they are weighted blends of the same two underlying funds (a low-risk and
a high-risk building block), so the high-risk plan behaves like a *leveraged* version of the
medium-risk plan. Empirically the high-risk series is a near-scalar multiple of the
medium-risk series ($R^2$ of 0.91-0.98 with intercept $\approx 0$), and the first principal
component explains about 96% of the joint variation across all four plans. Practically, the
choice between risk profiles within a provider is a choice of **how much** of one portfolio
to hold, not **which** portfolio -- higher profiles buy a higher expected growth rate at the
price of proportionally larger swings, with essentially no diversification difference between
them.

## What "risk" looks like in the data

Because $\beta>1$ with near-zero intercept, the high-risk plan amplifies the common factor
symmetrically. Over 2011-2023 that meant higher average returns (Velliv 8.5% vs 7.0%, PFA
9.5% vs 6.5%) but deeper drawdowns (worst year $-15.1\%$ vs $-13.2\%$ for Velliv, $-12.2\%$
vs $-9.6\%$ for PFA) and outright underperformance in flat or down years. The much-noted
property that the cumulative high-risk path never dips below the medium-risk path is an
artefact of starting the index in 2012 at a low point before a long bull market -- not
evidence that more risk is free. The monthly report develops this "path-crossing" point in
detail (rebasing the index to a market peak makes the paths cross); the annual sample is too
thin to add to it.

## What the data can and cannot tell us

This is the heart of the case study. The annual fits rest on **13 observations** for up to
four parameters. The skewness parameter `xi` is driven to its boundary in every fit -- a
direct symptom that the shape simply is not identifiable from so few points. Taleb's
$\kappa$ / $n_{min}$ machinery (appendix) quantifies the gap: matching the convergence of 30
Gaussian observations would take far more than 30 observations from a Student-$t$ with
$\nu\approx 3$. So for *point estimates of tail risk*, the honest answer is close to "stay
home."

Two things sharpen this. First, at annual resolution the 2011-2023 window contains **no
crash** -- even 2020 nets to $+9.7\%$ because the COVID drawdown recovered within the year.
The realised maximum gains actually exceed the maximum losses in this sample, although the
fitted distributions are left-skewed: the benign window has not yet delivered the large
drawdown the fit predicts. Second, the long Velliv series (`vmrl`, back to 2007) *does*
contain the 2008 crash, and is the one place in the data where a real left-tail event enters
the estimate. That is the strongest reason to keep it: it is our only empirical anchor for
the very tail the whole study is about.

## The mix and the fat-tail reading

The Monte-Carlo results are now produced as a single "black box" fit to each realised series
rather than by combining independent simulations, which removes a spurious diversification
effect that previously made the Velliv+PFA mixes look artificially safe. What remains -- and
what correlation alone misses -- is a genuine *tail* benefit from mixing two fat-tailed
providers: one provider's idiosyncratic crash is softened because the mix always lies between
the two. Quantifying that benefit against its cost is the subject of a separate analysis. On
the distributional side, the fitted $\nu\approx 3$ implies (near-)infinite variance; the
symmetric-$t$ Monte Carlo for the high-risk PFA profile diverges to absurd values, which is
not a numerical error but the fit telling us its variance does not exist.

## Bottom line

For a fixed, crash-free, 13-point sample we can say a great deal *qualitatively* -- the plans
are leverage on one portfolio, the tails are fat, drawdowns are asymmetric, and apparent
path-dominance is a starting-point artefact -- while being honest that *quantitative* tail
estimates are not trustworthy at this sample size. The next step is to turn the qualitative
structure into the two decisions an investor actually faces: which risk level, and whether to
split across providers.

# Appendix

## Infinite variance

Taleb, Statistical Consequences Of Fat Tails, p. 97:  
"the variance of a finite variance random variable with tail exponent $< 4$ will be infinite".

And p. 363:  
"The hedging errors for an option portfolio (under a daily revision regime) over 3000 days, under a constant volatility Student T with tail exponent $\alpha = 3$. Technically the errors should not converge in finite time as their distribution has infinite variance."


## QQ lines  

Note: QQ lines by design pass through 1st and 3rd quantiles. They are not trendlines in the sense of linear regression.  

## Arithmetic vs geometric mean
Let $m$ be the number of steps in each path and $n$ be the number of paths.
$a$ is the initial capital.
Use arithmetic mean for mean of all paths at time $t$:
$$\dfrac{a (e^{z_1} + e^{z_2} + \dots + e^{z_n})}{n}$$
where
$$z_i := x_{i, 1} + x_{i, 2} + \dots + x_{i, m}$$
Use geometric mean for mean of all steps in a single path $i$:
$$a e^{\frac{x_{i, 1} + x_{i, 2} + \dots + x_{i, m}}{m}} = a \sqrt[m]{e^{x_{i, 1} + x_{i, 2} + \dots + x_{i, m}}}$$

So for **Monte Carlo** of returns after $m$ periods, we 

+ fit a skewed t-distribution to log-returns and use that distribution to simulate $\{x_{i, j}\}_j^m$,
+ for each path $i$, calculate $100\cdot e^{z_i}$,
+ calculate the mean of $\{z_i\}_i^n$:
    + $$\bar{z} = 100\dfrac{e^{z_1} + e^{z_2} + \dots + e^{z_n}}{n}$$

For **Importance Sampling**, we

+ model log-returns on a skewed t-distribution,
+ for each path $i$, calculate $100\cdot e^{z_i}$,
+ fit a skewed t-distribution to $\{z_i\}_i^n$ and use it as our $f$ density function from which we simulate $\{h_i\}_i^n$,
    + In our case $h$ and $z$ are identical, because we have an idea for a distribution to simulate $z$, but in general for IS $h$ could be a function of $z$.
+ calculate $w* = \frac{f}{g^*}$, where $g*$ is our proposal distribution, which minimizes the variance of $h\cdot w$.
+ calculate the arithmetic mean of $\{h_i w_i^{*}\}_i^n$: 
    + $$100 \dfrac{e^{h_1 w_1^{*}} +  e^{h_2 w_2^{*}} + \dots +  e^{h_n w_n^{*}}}{n}$$


## Average of returns vs returns of average

### Math

$$\text{Avg. of returns} := \dfrac{ \left(\dfrac{x_t}{x_{t-1}} + \dfrac{y_t}{y_{t-1}} \right) }{2}$$
$$\text{Returns of avg.} := \left(\dfrac{ x_t + y_t }{2}\right) \Big/ \left(\dfrac{ x_{t-1} + y_{t-1} }{2}\right) \equiv \dfrac{ x_t + y_t }{ x_{t-1} + y_{t-1}}$$

For which $x_1$ and $y_1$ are
$\text{Avg. of returns} = \text{Returns of avg.}$?

$$\dfrac{ \left(\dfrac{x_t}{x_{t-1}} + \dfrac{y_t}{y_{t-1}} \right) }{2} = \dfrac{ x_t + y_t }{ x_{t-1} + y_{t-1}}$$

$$\dfrac{x_t}{x_{t-1}} + \dfrac{y_t}{y_{t-1}} = 2 \dfrac{ x_t + y_t }{ x_{t-1} + y_{t-1}}$$

$$(x_{t-1} + y_{t-1}) x_t y_{t-1} + (x_{t-1} + y_{t-1}) x_{t-1} y_t = 2 (x_{t-1}y_{t-1}x_t + x_{t-1}y_{t-1}y_t)$$

$$(x_{t-1}x_ty_{t-1} + y_{t-1}x_ty_{t-1}) + (x_{t-1}x_{t-1}y_t + x_{t-1}y_{t-1}y_t) = 2(x_{t-1}y_{t-1}x_t + x_{t-1}y_{t-1}y_t)$$
This is not generally true, but true if for instance
$x_{t-1} = y_{t-1}$.

### Example



Definition: `R = 1+r`


```
## Let x_0 be 100.
```

```
## Let y_0 be 200.
```

```
## So the initial value of the pf is 300 .
```

```
## Let R_x be 0.5.
```

```
## Let R_y be 1.5.
```

Then,


```
## x_1 is R_x * x_0 = 50.
```

```
## y_1 is R_y * y_0 = 300.
```

Average of returns:


```
## 0.5 * (R_x + R_y) = 1
```

So here the value of the pf at t=1 should be unchanged from t=0:


```
## (x_0 + y_0) * 0.5 * (R_x + R_y) = 300
```

But this is clearly not the case:


```
## 0.5 * (x_1 + y_1) = 0.5 * (R_x * x_0 + R_y * y_0) = 175
```

Therefore we should take returns of average, not average of returns!

Let's take the average of log returns instead:


```
## 0.5 * (log(R_x) + log(R_y)) = -0.143841
```

We now get:


```
## (x_0 + y_0) * exp(0.5 * (log(Rx) + log(Ry))) = 259.8076
```

So taking the average of log returns doesn't work either.

## Simulation of mix vs mix of simulations

Test if a simulation of a mix (average) of two returns series has the
same distribution as a mix of two simulated returns series.




```
## m(data_x): -0.06102962 
## s(data_x): 0.4340772 
## m(data_y): 9.541337 
## s(data_y): 2.380286 
## 
## m(data_x + data_y): 4.740154 
## s(data_x + data_y): 1.194826
```

m and s of final state of all paths.\
`_a` is mix of simulated returns.\
`_b` is simulated mixed returns.


|    m_a|    m_b|   s_a|   s_b|
|------:|------:|-----:|-----:|
| 94.853| 94.852| 5.340| 5.381|
| 94.645| 94.668| 5.627| 5.213|
| 95.001| 95.069| 5.356| 5.585|
| 94.759| 94.572| 5.452| 5.051|
| 94.743| 94.985| 5.429| 5.509|
| 94.834| 94.998| 5.311| 5.580|
| 95.071| 94.927| 5.473| 5.263|
| 94.427| 94.720| 5.193| 5.286|
| 94.750| 94.874| 5.376| 5.419|
| 94.894| 94.712| 5.451| 5.344|


```
##       m_a             m_b             s_a             s_b       
##  Min.   :94.43   Min.   :94.57   Min.   :5.193   Min.   :5.051  
##  1st Qu.:94.74   1st Qu.:94.71   1st Qu.:5.344   1st Qu.:5.268  
##  Median :94.80   Median :94.86   Median :5.402   Median :5.362  
##  Mean   :94.80   Mean   :94.84   Mean   :5.401   Mean   :5.363  
##  3rd Qu.:94.88   3rd Qu.:94.97   3rd Qu.:5.452   3rd Qu.:5.486  
##  Max.   :95.07   Max.   :95.07   Max.   :5.627   Max.   :5.585
```

`_a` and `_b` are very close to equal.\
We attribute the differences to differences in estimating the
distributions in version a and b.

The final state is independent of the order of the preceding steps:

![](pension-returns_annual_files/figure-html/unnamed-chunk-29-1.png)<!-- -->

So does the order of the steps in the two processes matter, when mixing
simulated returns?

![](pension-returns_annual_files/figure-html/unnamed-chunk-30-1.png)<!-- -->

![](pension-returns_annual_files/figure-html/unnamed-chunk-31-1.png)<!-- -->

The order of steps in the individual paths do not matter, because the
mix of simulated paths is a sum of a sum, so the order of terms doesn't
affect the sum. If there is variation it is because the sets preceding
steps are not the same. For instance, the steps between step 1 and 60 in
the plot above are not the same for the two lines.

Recall,
$$\text{Var}(aX+bY) = a^2 \text{Var}(X) + b^2 \text{Var}(Y) + 2ab \text{Cov}(a, b)$$


``` r
var(0.5 * vhr + 0.5 * phr)
```

```
## [1] 0.01055146
```

``` r
0.5^2 * var(vhr) + 0.5^2 * var(phr) + 2 * 0.5 * 0.5 * cov(vhr, phr)
```

```
## [1] 0.01055146
```

Our distribution estimate is based on 13 observations. Is that enough
for a robust estimate? What if we suddenly hit a year like 2008? How
would that affect our estimate?\
Let's try to include the Velliv data from 2007-2010.\
We do this by sampling 13 observations from `vmrl`.


```
##        m                 s          
##  Min.   :0.06037   Min.   :0.04111  
##  1st Qu.:0.06623   1st Qu.:0.06221  
##  Median :0.06848   Median :0.06818  
##  Mean   :0.07002   Mean   :0.06877  
##  3rd Qu.:0.07372   3rd Qu.:0.07326  
##  Max.   :0.08551   Max.   :0.09233
```

## The meaning of `xi`

The fit for `mhr` has the highest `xi` value of all. This suggests
right-skew:

![](pension-returns_annual_files/figure-html/unnamed-chunk-34-1.png)<!-- -->

## Max vs sum plot

If the Law Of Large Numbers holds true,
$$\dfrac{\max (X_1^p, ..., X^p)}{\sum_{i=1}^n X_i^p} \rightarrow 0$$ for
$n \rightarrow \infty$.

If not, $X$ doesn't have a $p$'th moment.

See Taleb: The Statistical Consequences Of Fat Tails, p. 192


