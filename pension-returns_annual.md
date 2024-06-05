---
title: "Annual pension returns analysis"
author: Martin Hoshi Vognsen
header-includes:
   - \usepackage[default]{sourcesanspro}
   - \usepackage[T1]{fontenc}
   - \usepackage[fontsize=8pt]{scrextend}
mainfont: SourceSansPro
output: 
  html_document:
    toc: true
    toc_depth: 3
    keep_md: yes
  pdf_document:
    toc: true
    toc_depth: 3
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
date: "09:35 05 June 2024"
---
































Fit log returns to F-S skew standardized Student-t distribution.  
`m`  is the location parameter.  
`s` is the scale parameter.  
`nu` is the estimated shape parameter (degrees of freedom).  
`xi` is the estimated skewness parameter.  

# Returns data 2011-2023.  

For 2011, medium risk data is used in the high risk data set, as no high risk fund data is available prior to 2012.  
`vmrl` is a long version of Velliv medium risk data, from 2007 to 2023. For 2007 to 2011 (both included) no high risk data is available.

PFA medium risk is risk profile B.  
PFA high risk is risk profile D.  








![](pension-returns_annual_files/figure-html/unnamed-chunk-17-1.png)<!-- -->














































































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




|   |    vmr|    vhr|   pmr|    phr|   mmr|    mhr| vmr_phr| vhr_pmr|
|:--|------:|------:|-----:|------:|-----:|------:|-------:|-------:|
|0  | 17.333| 20.333| 8.833| 26.667| 7.167| 26.500|  26.667|   8.833|
|5  |  7.667| 10.333| 4.333| 14.500| 3.667| 14.167|  13.333|   5.000|
|10 |  3.000|  4.667| 2.333|  6.333| 2.000|  6.000|   5.167|   2.833|
|25 |  0.000|  0.000| 0.333|  0.000| 0.333|  0.000|   0.000|   0.667|
|50 |  0.000|  0.000| 0.000|  0.000| 0.000|  0.000|   0.000|   0.000|
|90 |  0.000|  0.000| 0.000|  0.000| 0.000|  0.000|   0.000|   0.000|
|99 |  0.000|  0.000| 0.000|  0.000| 0.000|  0.000|   0.000|   0.000|


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


|      0|ranking |      5|ranking |    10|ranking |    25|ranking | 50|ranking | 90|ranking | 99|ranking |
|------:|:-------|------:|:-------|-----:|:-------|-----:|:-------|--:|:-------|--:|:-------|--:|:-------|
| 26.667|phr     | 14.500|phr     | 6.333|phr     | 0.667|vhr_pmr |  0|vmr     |  0|vmr     |  0|vmr     |
| 26.667|vmr_phr | 14.167|mhr     | 6.000|mhr     | 0.333|pmr     |  0|vhr     |  0|vhr     |  0|vhr     |
| 26.500|mhr     | 13.333|vmr_phr | 5.167|vmr_phr | 0.333|mmr     |  0|pmr     |  0|pmr     |  0|pmr     |
| 20.333|vhr     | 10.333|vhr     | 4.667|vhr     | 0.000|vmr     |  0|phr     |  0|phr     |  0|phr     |
| 17.333|vmr     |  7.667|vmr     | 3.000|vmr     | 0.000|vhr     |  0|mmr     |  0|mmr     |  0|mmr     |
|  8.833|pmr     |  5.000|vhr_pmr | 2.833|vhr_pmr | 0.000|phr     |  0|mhr     |  0|mhr     |  0|mhr     |
|  8.833|vhr_pmr |  4.333|pmr     | 2.333|pmr     | 0.000|mhr     |  0|vmr_phr |  0|vmr_phr |  0|vmr_phr |
|  7.167|mmr     |  3.667|mmr     | 2.000|mmr     | 0.000|vmr_phr |  0|vhr_pmr |  0|vhr_pmr |  0|vhr_pmr |


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
|0   | 82.667| 79.667| 91.167| 73.333| 92.833| 73.500|  73.333|  91.167|
|5   | 65.833| 65.000| 80.000| 58.167| 84.000| 58.000|  56.667|  82.667|
|10  | 44.500| 48.000| 54.833| 42.500| 62.333| 42.167|  39.500|  65.500|
|25  |  7.000| 11.667|  6.667| 10.000|  7.500|  9.500|   7.000|  12.167|
|50  |  0.167|  0.500|  0.833|  0.000|  1.000|  0.000|   0.000|   1.833|
|100 |  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|   0.000|   0.167|


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


|      0|ranking |      5|ranking |     10|ranking |     25|ranking |    50|ranking |   100|ranking |
|------:|:-------|------:|:-------|------:|:-------|------:|:-------|-----:|:-------|-----:|:-------|
| 92.833|mmr     | 84.000|mmr     | 65.500|vhr_pmr | 12.167|vhr_pmr | 1.833|vhr_pmr | 0.167|vhr_pmr |
| 91.167|pmr     | 82.667|vhr_pmr | 62.333|mmr     | 11.667|vhr     | 1.000|mmr     | 0.000|vmr     |
| 91.167|vhr_pmr | 80.000|pmr     | 54.833|pmr     | 10.000|phr     | 0.833|pmr     | 0.000|vhr     |
| 82.667|vmr     | 65.833|vmr     | 48.000|vhr     |  9.500|mhr     | 0.500|vhr     | 0.000|pmr     |
| 79.667|vhr     | 65.000|vhr     | 44.500|vmr     |  7.500|mmr     | 0.167|vmr     | 0.000|phr     |
| 73.500|mhr     | 58.167|phr     | 42.500|phr     |  7.000|vmr     | 0.000|phr     | 0.000|mmr     |
| 73.333|phr     | 58.000|mhr     | 42.167|mhr     |  7.000|vmr_phr | 0.000|mhr     | 0.000|mhr     |
| 73.333|vmr_phr | 56.667|vmr_phr | 39.500|vmr_phr |  6.667|pmr     | 0.000|vmr_phr | 0.000|vmr_phr |


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
|0  | 1.46| 4.12| 1.91| 0.82| 0.10| 0.15|    0.05|    0.28|
|5  | 1.22| 3.69| 1.71| 0.71| 0.08| 0.12|    0.02|    0.24|
|10 | 1.01| 3.27| 1.56| 0.63| 0.08| 0.08|    0.02|    0.22|
|25 | 0.67| 2.32| 1.13| 0.35| 0.02| 0.03|    0.00|    0.11|
|50 | 0.18| 1.10| 0.62| 0.10| 0.00| 0.01|    0.00|    0.02|
|90 | 0.02| 0.11| 0.16| 0.01| 0.00| 0.00|    0.00|    0.00|
|99 | 0.00| 0.00| 0.00| 0.00| 0.00| 0.00|    0.00|    0.00|




Standardized $t$-distribution (std):  




|   |  vmr|  vhr|  pmr|  phr| mmr| mhr| vmr_phr| vhr_pmr|
|:--|----:|----:|----:|----:|---:|---:|-------:|-------:|
|0  | 0.08| 0.07| 0.71| 0.43|   0|   0|       0|    0.02|
|5  | 0.07| 0.05| 0.65| 0.34|   0|   0|       0|    0.01|
|10 | 0.06| 0.03| 0.60| 0.22|   0|   0|       0|    0.01|
|25 | 0.03| 0.00| 0.50| 0.07|   0|   0|       0|    0.00|
|50 | 0.00| 0.00| 0.32| 0.00|   0|   0|       0|    0.00|
|90 | 0.00| 0.00| 0.11| 0.00|   0|   0|       0|    0.00|
|99 | 0.00| 0.00| 0.00| 0.00|   0|   0|       0|    0.00|


Normal distribution:  




|   |  vmr|  vhr|  pmr| phr| mmr| mhr| vmr_phr| vhr_pmr|
|:--|----:|----:|----:|---:|---:|---:|-------:|-------:|
|0  | 0.02| 0.03| 0.01|   0|   0|   0|       0|       0|
|5  | 0.01| 0.02| 0.00|   0|   0|   0|       0|       0|
|10 | 0.00| 0.02| 0.00|   0|   0|   0|       0|       0|
|25 | 0.00| 0.01| 0.00|   0|   0|   0|       0|       0|
|50 | 0.00| 0.00| 0.00|   0|   0|   0|       0|       0|
|90 | 0.00| 0.00| 0.00|   0|   0|   0|       0|       0|
|99 | 0.00| 0.00| 0.00|   0|   0|   0|       0|       0|


### Worst ranking for MC loss percentiles

Skewed $t$-distribution (sstd):  


|    0|ranking |    5|ranking |   10|ranking |   25|ranking |   50|ranking |   90|ranking | 99|ranking |
|----:|:-------|----:|:-------|----:|:-------|----:|:-------|----:|:-------|----:|:-------|--:|:-------|
| 4.12|vhr     | 3.69|vhr     | 3.27|vhr     | 2.32|vhr     | 1.10|vhr     | 0.16|pmr     |  0|vmr     |
| 1.91|pmr     | 1.71|pmr     | 1.56|pmr     | 1.13|pmr     | 0.62|pmr     | 0.11|vhr     |  0|vhr     |
| 1.46|vmr     | 1.22|vmr     | 1.01|vmr     | 0.67|vmr     | 0.18|vmr     | 0.02|vmr     |  0|pmr     |
| 0.82|phr     | 0.71|phr     | 0.63|phr     | 0.35|phr     | 0.10|phr     | 0.01|phr     |  0|phr     |
| 0.28|vhr_pmr | 0.24|vhr_pmr | 0.22|vhr_pmr | 0.11|vhr_pmr | 0.02|vhr_pmr | 0.00|mmr     |  0|mmr     |
| 0.15|mhr     | 0.12|mhr     | 0.08|mmr     | 0.03|mhr     | 0.01|mhr     | 0.00|mhr     |  0|mhr     |
| 0.10|mmr     | 0.08|mmr     | 0.08|mhr     | 0.02|mmr     | 0.00|mmr     | 0.00|vmr_phr |  0|vmr_phr |
| 0.05|vmr_phr | 0.02|vmr_phr | 0.02|vmr_phr | 0.00|vmr_phr | 0.00|vmr_phr | 0.00|vhr_pmr |  0|vhr_pmr |


Standardized $t$-distribution (std):  


|    0|ranking |    5|ranking |   10|ranking |   25|ranking |   50|ranking |   90|ranking | 99|ranking |
|----:|:-------|----:|:-------|----:|:-------|----:|:-------|----:|:-------|----:|:-------|--:|:-------|
| 0.71|pmr     | 0.65|pmr     | 0.60|pmr     | 0.50|pmr     | 0.32|pmr     | 0.11|pmr     |  0|vmr     |
| 0.43|phr     | 0.34|phr     | 0.22|phr     | 0.07|phr     | 0.00|vmr     | 0.00|vmr     |  0|vhr     |
| 0.08|vmr     | 0.07|vmr     | 0.06|vmr     | 0.03|vmr     | 0.00|vhr     | 0.00|vhr     |  0|pmr     |
| 0.07|vhr     | 0.05|vhr     | 0.03|vhr     | 0.00|vhr     | 0.00|phr     | 0.00|phr     |  0|phr     |
| 0.02|vhr_pmr | 0.01|vhr_pmr | 0.01|vhr_pmr | 0.00|mmr     | 0.00|mmr     | 0.00|mmr     |  0|mmr     |
| 0.00|mmr     | 0.00|mmr     | 0.00|mmr     | 0.00|mhr     | 0.00|mhr     | 0.00|mhr     |  0|mhr     |
| 0.00|mhr     | 0.00|mhr     | 0.00|mhr     | 0.00|vmr_phr | 0.00|vmr_phr | 0.00|vmr_phr |  0|vmr_phr |
| 0.00|vmr_phr | 0.00|vmr_phr | 0.00|vmr_phr | 0.00|vhr_pmr | 0.00|vhr_pmr | 0.00|vhr_pmr |  0|vhr_pmr |


Normal distribution:  


|    0|ranking |    5|ranking |   10|ranking |   25|ranking | 50|ranking | 90|ranking | 99|ranking |
|----:|:-------|----:|:-------|----:|:-------|----:|:-------|--:|:-------|--:|:-------|--:|:-------|
| 0.03|vhr     | 0.02|vhr     | 0.02|vhr     | 0.01|vhr     |  0|vmr     |  0|vmr     |  0|vmr     |
| 0.02|vmr     | 0.01|vmr     | 0.00|vmr     | 0.00|vmr     |  0|vhr     |  0|vhr     |  0|vhr     |
| 0.01|pmr     | 0.00|pmr     | 0.00|pmr     | 0.00|pmr     |  0|pmr     |  0|pmr     |  0|pmr     |
| 0.00|phr     | 0.00|phr     | 0.00|phr     | 0.00|phr     |  0|phr     |  0|phr     |  0|phr     |
| 0.00|mmr     | 0.00|mmr     | 0.00|mmr     | 0.00|mmr     |  0|mmr     |  0|mmr     |  0|mmr     |
| 0.00|mhr     | 0.00|mhr     | 0.00|mhr     | 0.00|mhr     |  0|mhr     |  0|mhr     |  0|mhr     |
| 0.00|vmr_phr | 0.00|vmr_phr | 0.00|vmr_phr | 0.00|vmr_phr |  0|vmr_phr |  0|vmr_phr |  0|vmr_phr |
| 0.00|vhr_pmr | 0.00|vhr_pmr | 0.00|vhr_pmr | 0.00|vhr_pmr |  0|vhr_pmr |  0|vhr_pmr |  0|vhr_pmr |


## MC gains percentiles




Skewed $t$-distribution (sstd):  




|     |   vmr|   vhr|   pmr|   phr|   mmr|   mhr| vmr_phr| vhr_pmr|
|:----|-----:|-----:|-----:|-----:|-----:|-----:|-------:|-------:|
|0    | 98.54| 95.88| 98.09| 99.18| 99.90| 99.85|   99.95|   99.72|
|5    | 98.24| 95.55| 97.81| 99.06| 99.87| 99.79|   99.94|   99.64|
|10   | 97.91| 95.06| 97.60| 98.89| 99.82| 99.78|   99.92|   99.57|
|25   | 96.96| 93.67| 96.73| 98.42| 99.60| 99.68|   99.82|   99.26|
|50   | 94.42| 90.66| 94.89| 97.19| 98.89| 99.11|   99.53|   98.35|
|100  | 86.53| 84.01| 88.48| 93.76| 94.62| 96.52|   97.40|   93.64|
|200  | 59.55| 64.45| 58.53| 80.88| 63.21| 83.14|   81.81|   67.25|
|300  | 30.57| 45.25| 22.12| 62.83| 20.52| 57.69|   51.89|   34.04|
|400  | 12.38| 29.22|  4.27| 43.97|  2.68| 32.80|   24.25|   13.33|
|500  |  4.05| 17.64|  0.42| 28.05|  0.14| 15.30|    8.30|    3.96|
|1000 |  0.00|  0.69|  0.00|  0.90|  0.00|  0.08|    0.01|    0.00|




Standardized $t$-distribution (std):  




|     |   vmr|   vhr|   pmr|   phr|    mmr|    mhr| vmr_phr| vhr_pmr|
|:----|-----:|-----:|-----:|-----:|------:|------:|-------:|-------:|
|0    | 99.92| 99.93| 99.29| 99.57| 100.00| 100.00|  100.00|   99.98|
|5    | 99.91| 99.89| 99.26| 99.48| 100.00| 100.00|  100.00|   99.97|
|10   | 99.90| 99.86| 99.16| 99.36| 100.00| 100.00|  100.00|   99.97|
|25   | 99.79| 99.77| 99.07| 98.68|  99.97|  99.99|   99.98|   99.95|
|50   | 99.44| 99.43| 98.71| 97.08|  99.93|  99.86|   99.89|   99.91|
|100  | 97.24| 97.56| 97.82| 91.37|  99.72|  99.15|   99.27|   99.76|
|200  | 85.25| 87.19| 94.22| 71.23|  97.47|  92.05|   90.13|   97.86|
|300  | 66.73| 73.08| 87.24| 50.68|  89.35|  73.72|   67.15|   91.22|
|400  | 47.04| 57.48| 75.62| 34.36|  73.25|  52.35|   43.09|   77.78|
|500  | 32.45| 44.15| 62.30| 22.57|  52.86|  33.00|   24.39|   60.20|
|1000 |  4.20|  9.59| 16.84|  2.48|   6.20|   2.30|    0.98|    9.95|


Normal distribution:  




|     |   vmr|   vhr|   pmr|    phr|    mmr|    mhr| vmr_phr| vhr_pmr|
|:----|-----:|-----:|-----:|------:|------:|------:|-------:|-------:|
|0    | 99.98| 99.97| 99.99| 100.00| 100.00| 100.00|  100.00|  100.00|
|5    | 99.97| 99.94| 99.99| 100.00| 100.00| 100.00|  100.00|  100.00|
|10   | 99.94| 99.91| 99.98|  99.98| 100.00| 100.00|  100.00|  100.00|
|25   | 99.82| 99.81| 99.95|  99.95| 100.00| 100.00|  100.00|  100.00|
|50   | 98.97| 99.26| 99.66|  99.76|  99.97|  99.99|  100.00|  100.00|
|100  | 93.16| 96.31| 95.60|  98.23|  98.98|  99.78|   99.68|   99.44|
|200  | 63.54| 78.98| 58.13|  88.14|  69.29|  93.87|   89.96|   81.07|
|300  | 32.36| 56.15| 20.52|  70.34|  22.63|  73.77|   62.19|   42.63|
|400  | 13.97| 36.76|  4.82|  50.71|   4.22|  47.44|   33.40|   16.63|
|500  |  5.63| 22.34|  0.89|  34.42|   0.87|  26.11|   15.81|    5.72|
|1000 |  0.07|  1.64|  0.00|   4.11|   0.00|   0.51|    0.23|    0.07|



### Best ranking for MC gains percentiles

Skewed $t$-distribution (sstd):  


|     0|ranking |     5|ranking |    10|ranking |    25|ranking |    50|ranking |   100|ranking |
|-----:|:-------|-----:|:-------|-----:|:-------|-----:|:-------|-----:|:-------|-----:|:-------|
| 99.95|vmr_phr | 99.94|vmr_phr | 99.92|vmr_phr | 99.82|vmr_phr | 99.53|vmr_phr | 97.40|vmr_phr |
| 99.90|mmr     | 99.87|mmr     | 99.82|mmr     | 99.68|mhr     | 99.11|mhr     | 96.52|mhr     |
| 99.85|mhr     | 99.79|mhr     | 99.78|mhr     | 99.60|mmr     | 98.89|mmr     | 94.62|mmr     |
| 99.72|vhr_pmr | 99.64|vhr_pmr | 99.57|vhr_pmr | 99.26|vhr_pmr | 98.35|vhr_pmr | 93.76|phr     |
| 99.18|phr     | 99.06|phr     | 98.89|phr     | 98.42|phr     | 97.19|phr     | 93.64|vhr_pmr |
| 98.54|vmr     | 98.24|vmr     | 97.91|vmr     | 96.96|vmr     | 94.89|pmr     | 88.48|pmr     |
| 98.09|pmr     | 97.81|pmr     | 97.60|pmr     | 96.73|pmr     | 94.42|vmr     | 86.53|vmr     |
| 95.88|vhr     | 95.55|vhr     | 95.06|vhr     | 93.67|vhr     | 90.66|vhr     | 84.01|vhr     |


|   200|ranking |   300|ranking |   400|ranking |   500|ranking | 1000|ranking |
|-----:|:-------|-----:|:-------|-----:|:-------|-----:|:-------|----:|:-------|
| 83.14|mhr     | 62.83|phr     | 43.97|phr     | 28.05|phr     | 0.90|phr     |
| 81.81|vmr_phr | 57.69|mhr     | 32.80|mhr     | 17.64|vhr     | 0.69|vhr     |
| 80.88|phr     | 51.89|vmr_phr | 29.22|vhr     | 15.30|mhr     | 0.08|mhr     |
| 67.25|vhr_pmr | 45.25|vhr     | 24.25|vmr_phr |  8.30|vmr_phr | 0.01|vmr_phr |
| 64.45|vhr     | 34.04|vhr_pmr | 13.33|vhr_pmr |  4.05|vmr     | 0.00|vmr     |
| 63.21|mmr     | 30.57|vmr     | 12.38|vmr     |  3.96|vhr_pmr | 0.00|pmr     |
| 59.55|vmr     | 22.12|pmr     |  4.27|pmr     |  0.42|pmr     | 0.00|mmr     |
| 58.53|pmr     | 20.52|mmr     |  2.68|mmr     |  0.14|mmr     | 0.00|vhr_pmr |


Standardized $t$-distribution (std):  


|      0|ranking |      5|ranking |     10|ranking |    25|ranking |    50|ranking |   100|ranking |
|------:|:-------|------:|:-------|------:|:-------|-----:|:-------|-----:|:-------|-----:|:-------|
| 100.00|mmr     | 100.00|mmr     | 100.00|mmr     | 99.99|mhr     | 99.93|mmr     | 99.76|vhr_pmr |
| 100.00|mhr     | 100.00|mhr     | 100.00|mhr     | 99.98|vmr_phr | 99.91|vhr_pmr | 99.72|mmr     |
| 100.00|vmr_phr | 100.00|vmr_phr | 100.00|vmr_phr | 99.97|mmr     | 99.89|vmr_phr | 99.27|vmr_phr |
|  99.98|vhr_pmr |  99.97|vhr_pmr |  99.97|vhr_pmr | 99.95|vhr_pmr | 99.86|mhr     | 99.15|mhr     |
|  99.93|vhr     |  99.91|vmr     |  99.90|vmr     | 99.79|vmr     | 99.44|vmr     | 97.82|pmr     |
|  99.92|vmr     |  99.89|vhr     |  99.86|vhr     | 99.77|vhr     | 99.43|vhr     | 97.56|vhr     |
|  99.57|phr     |  99.48|phr     |  99.36|phr     | 99.07|pmr     | 98.71|pmr     | 97.24|vmr     |
|  99.29|pmr     |  99.26|pmr     |  99.16|pmr     | 98.68|phr     | 97.08|phr     | 91.37|phr     |


|   200|ranking |   300|ranking |   400|ranking |   500|ranking |  1000|ranking |
|-----:|:-------|-----:|:-------|-----:|:-------|-----:|:-------|-----:|:-------|
| 97.86|vhr_pmr | 91.22|vhr_pmr | 77.78|vhr_pmr | 62.30|pmr     | 16.84|pmr     |
| 97.47|mmr     | 89.35|mmr     | 75.62|pmr     | 60.20|vhr_pmr |  9.95|vhr_pmr |
| 94.22|pmr     | 87.24|pmr     | 73.25|mmr     | 52.86|mmr     |  9.59|vhr     |
| 92.05|mhr     | 73.72|mhr     | 57.48|vhr     | 44.15|vhr     |  6.20|mmr     |
| 90.13|vmr_phr | 73.08|vhr     | 52.35|mhr     | 33.00|mhr     |  4.20|vmr     |
| 87.19|vhr     | 67.15|vmr_phr | 47.04|vmr     | 32.45|vmr     |  2.48|phr     |
| 85.25|vmr     | 66.73|vmr     | 43.09|vmr_phr | 24.39|vmr_phr |  2.30|mhr     |
| 71.23|phr     | 50.68|phr     | 34.36|phr     | 22.57|phr     |  0.98|vmr_phr |


Normal distribution:  


|      0|ranking |      5|ranking |     10|ranking |     25|ranking |     50|ranking |   100|ranking |
|------:|:-------|------:|:-------|------:|:-------|------:|:-------|------:|:-------|-----:|:-------|
| 100.00|phr     | 100.00|phr     | 100.00|mmr     | 100.00|mmr     | 100.00|vmr_phr | 99.78|mhr     |
| 100.00|mmr     | 100.00|mmr     | 100.00|mhr     | 100.00|mhr     | 100.00|vhr_pmr | 99.68|vmr_phr |
| 100.00|mhr     | 100.00|mhr     | 100.00|vmr_phr | 100.00|vmr_phr |  99.99|mhr     | 99.44|vhr_pmr |
| 100.00|vmr_phr | 100.00|vmr_phr | 100.00|vhr_pmr | 100.00|vhr_pmr |  99.97|mmr     | 98.98|mmr     |
| 100.00|vhr_pmr | 100.00|vhr_pmr |  99.98|pmr     |  99.95|pmr     |  99.76|phr     | 98.23|phr     |
|  99.99|pmr     |  99.99|pmr     |  99.98|phr     |  99.95|phr     |  99.66|pmr     | 96.31|vhr     |
|  99.98|vmr     |  99.97|vmr     |  99.94|vmr     |  99.82|vmr     |  99.26|vhr     | 95.60|pmr     |
|  99.97|vhr     |  99.94|vhr     |  99.91|vhr     |  99.81|vhr     |  98.97|vmr     | 93.16|vmr     |


|   200|ranking |   300|ranking |   400|ranking |   500|ranking | 1000|ranking |
|-----:|:-------|-----:|:-------|-----:|:-------|-----:|:-------|----:|:-------|
| 93.87|mhr     | 73.77|mhr     | 50.71|phr     | 34.42|phr     | 4.11|phr     |
| 89.96|vmr_phr | 70.34|phr     | 47.44|mhr     | 26.11|mhr     | 1.64|vhr     |
| 88.14|phr     | 62.19|vmr_phr | 36.76|vhr     | 22.34|vhr     | 0.51|mhr     |
| 81.07|vhr_pmr | 56.15|vhr     | 33.40|vmr_phr | 15.81|vmr_phr | 0.23|vmr_phr |
| 78.98|vhr     | 42.63|vhr_pmr | 16.63|vhr_pmr |  5.72|vhr_pmr | 0.07|vmr     |
| 69.29|mmr     | 32.36|vmr     | 13.97|vmr     |  5.63|vmr     | 0.07|vhr_pmr |
| 63.54|vmr     | 22.63|mmr     |  4.82|pmr     |  0.89|pmr     | 0.00|pmr     |
| 58.13|pmr     | 20.52|pmr     |  4.22|mmr     |  0.87|mmr     | 0.00|mmr     |






## Summary statistics  

### Fit summary

Summary for fit of log returns to an F-S skew standardized Student-t distribution.  
`m`  is the location parameter.  
`s` is the scale parameter.  
`nu` is the estimated degrees of freedom, or shape parameter.  
`xi` is the estimated skewness parameter.  


Skewed $t$-distribution (sstd):  


|    |   vmr|   vhr|   pmr|   phr|   mmr|   mhr| vmr_phr| vhr_pmr|
|:---|-----:|-----:|-----:|-----:|-----:|-----:|-------:|-------:|
|m   | 0.060| 0.065| 0.058| 0.078| 0.052| 0.074|   0.070|   0.066|
|s   | 0.101| 0.150| 0.121| 0.113| 0.098| 0.139|   0.119|   0.090|
|nu  | 3.574| 3.144| 2.275| 3.856| 3.032| 3.095|   2.965|   3.569|
|xi  | 0.000| 0.002| 0.477| 0.015| 0.023| 0.006|   0.002|   0.003|
|R^2 | 0.993| 0.991| 0.991| 0.968| 0.992| 0.979|   0.977|   0.995|


Standardized $t$-distribution (std):  


|    |   vmr|   vhr|   pmr|         phr|   mmr|         mhr|     vmr_phr| vhr_pmr|
|:---|-----:|-----:|-----:|-----------:|-----:|-----------:|-----------:|-------:|
|m   | 0.084| 0.090| 0.102|       0.073| 0.113|       0.072|       0.067|   0.124|
|s   | 0.106| 0.122| 0.345|       0.119| 0.895|       0.117|       0.108|   0.793|
|nu  | 4.844| 7.368| 2.045| 5682540.710| 2.006| 8971817.739| 9916906.918|   2.012|
|R^2 | 0.935| 0.955| 0.918|       0.923| 0.908|       0.937|       0.924|   0.919|


Normal distribution:  


|    |   vmr|   vhr|   pmr|   phr|   mmr|   mhr| vmr_phr| vhr_pmr|
|:---|-----:|-----:|-----:|-----:|-----:|-----:|-------:|-------:|
|m   | 0.064| 0.077| 0.061| 0.085| 0.063| 0.081|   0.076|   0.069|
|s   | 0.081| 0.099| 0.063| 0.101| 0.071| 0.099|   0.090|   0.081|
|R^2 | 0.933| 0.954| 0.916| 0.923| 0.911| 0.937|   0.924|   0.927|


#### AIC and BIC  


AIC





|       |     vmr|     vhr|     pmr|     phr|     mmr|     mhr| vmr_phr| vhr_pmr|
|:------|-------:|-------:|-------:|-------:|-------:|-------:|-------:|-------:|
|sstd   | -28.098| -21.425| -33.230| -23.741| -33.930| -22.790| -26.979| -30.291|
|std    | -16.385| -11.623| -22.924| -11.324| -20.406| -11.817| -13.869| -16.796|
|normal | -20.316| -15.218| -27.005| -14.616| -23.809| -15.345| -17.593| -20.613|


BIC  




|       |     vmr|     vhr|     pmr|     phr|     mmr|     mhr| vmr_phr| vhr_pmr|
|:------|-------:|-------:|-------:|-------:|-------:|-------:|-------:|-------:|
|sstd   | -25.838| -19.165| -30.970| -21.482| -31.670| -20.530| -24.720| -28.031|
|std    | -14.125|  -9.363| -20.664|  -9.064| -18.146|  -9.558| -11.609| -14.536|
|normal | -18.056| -12.958| -24.746| -12.357| -21.550| -13.085| -15.333| -18.353|

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
| 0.17| 0.21| 0.33| 0.15| 0.22| 0.22|    0.23|    0.17|


$n_{min}$  

What is the minimum value of $n_{\nu}$, the number of observations from a given skewed $t$-distribution, we need to achieve the same degree of convergence as with $n_g=30$ observations from a Gaussian distribution with the same mean and standard deviation?


| vmr| vhr| pmr| phr| mmr| mhr| vmr_phr| vhr_pmr|
|---:|---:|---:|---:|---:|---:|-------:|-------:|
|  62|  78| 164|  57|  78|  78|      81|      62|



#### Fit statistics ranking  


Skewed $t$-distribution (sstd):  


|     m|ranking |     s|ranking |   R^2|ranking |
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


|     m|ranking |     s|ranking |   R^2|ranking |
|-----:|:-------|-----:|:-------|-----:|:-------|
| 0.124|vhr_pmr | 0.106|vmr     | 0.955|vhr     |
| 0.113|mmr     | 0.108|vmr_phr | 0.937|mhr     |
| 0.102|pmr     | 0.117|mhr     | 0.935|vmr     |
| 0.090|vhr     | 0.119|phr     | 0.924|vmr_phr |
| 0.084|vmr     | 0.122|vhr     | 0.923|phr     |
| 0.073|phr     | 0.345|pmr     | 0.919|vhr_pmr |
| 0.072|mhr     | 0.793|vhr_pmr | 0.918|pmr     |
| 0.067|vmr_phr | 0.895|mmr     | 0.908|mmr     |

Normal distribution:  


|     m|ranking |     s|ranking |   R^2|ranking |
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




|        |     vmr|     vhr|    pmr|     phr|    mmr|     mhr| vmr_phr| vhr_pmr|
|:-------|-------:|-------:|------:|-------:|------:|-------:|-------:|-------:|
|mc_m    |  365.22|  438.43| 342.27|  534.24| 352.73|  480.78|  449.93|  389.07|
|mc_s    |  144.99|  242.02| 113.87|  240.41|  92.05|  171.16|  141.79|  134.00|
|mc_min  |    3.00|    3.00|   0.04|    9.81|  76.71|   57.75|   78.93|    9.02|
|mc_max  | 1061.35| 1733.76| 933.98| 1791.85| 932.38| 1698.31| 1317.63| 1447.45|
|dao_pct |    0.02|    0.06|   0.12|    0.00|   0.00|    0.00|    0.00|    0.00|
|dai_pct |    1.36|    3.89|   1.83|    0.66|   0.09|    0.09|    0.03|    0.30|


Standardized $t$-distribution (std):  




|        |     vmr|     vhr|          pmr|     phr|        mmr|     mhr| vmr_phr|      vhr_pmr|
|:-------|-------:|-------:|------------:|-------:|----------:|-------:|-------:|------------:|
|mc_m    |  594.24|  701.71| 1.293393e+20|  498.88|    1439.39|  601.20|  546.42| 4.300181e+05|
|mc_s    |  312.33|  413.32| 1.293393e+22|  283.05|   54541.36|  248.89|  211.17| 4.192550e+07|
|mc_min  |   65.73|   78.35| 3.000000e-02|   57.83|     122.67|  122.23|  127.60| 9.973000e+01|
|mc_max  | 5603.32| 5079.93| 1.293393e+24| 3108.62| 5410256.83| 2395.18| 2186.83| 4.191411e+09|
|dao_pct |    0.00|    0.00| 9.000000e-02|    0.00|       0.00|    0.00|    0.00| 0.000000e+00|
|dai_pct |    0.08|    0.09| 6.900000e-01|    0.40|       0.00|    0.00|    0.00| 1.000000e-02|


Normal distribution:  




|        |     vmr|     vhr|    pmr|     phr|    mmr|     mhr| vmr_phr| vhr_pmr|
|:-------|-------:|-------:|------:|-------:|------:|-------:|-------:|-------:|
|mc_m    |  387.42|  513.18| 351.29|  610.65| 369.91|  561.39|  501.78|  428.70|
|mc_s    |  147.82|  243.69| 100.63|  294.23|  89.78|  187.95|  164.02|  130.13|
|mc_min  |   92.96|   82.74| 102.84|   99.94| 131.02|  163.84|  160.98|  158.70|
|mc_max  | 1434.40| 3114.30| 892.69| 3527.40| 944.67| 1814.66| 1700.44| 2093.70|
|dao_pct |    0.00|    0.00|   0.00|    0.00|   0.00|    0.00|    0.00|    0.00|
|dai_pct |    0.01|    0.02|   0.00|    0.01|   0.00|    0.00|    0.00|    0.00|


#### Ranking  


Skewed $t$-distribution (sstd):  


|   mc_m|ranking |   mc_s|ranking | mc_min|ranking |  mc_max|ranking | dao_pct|ranking | dai_pct|ranking |
|------:|:-------|------:|:-------|------:|:-------|-------:|:-------|-------:|:-------|-------:|:-------|
| 534.24|phr     |  92.05|mmr     |  78.93|vmr_phr | 1791.85|phr     |    0.00|phr     |    0.03|vmr_phr |
| 480.78|mhr     | 113.87|pmr     |  76.71|mmr     | 1733.76|vhr     |    0.00|mmr     |    0.09|mmr     |
| 449.93|vmr_phr | 134.00|vhr_pmr |  57.75|mhr     | 1698.31|mhr     |    0.00|mhr     |    0.09|mhr     |
| 438.43|vhr     | 141.79|vmr_phr |   9.81|phr     | 1447.45|vhr_pmr |    0.00|vmr_phr |    0.30|vhr_pmr |
| 389.07|vhr_pmr | 144.99|vmr     |   9.02|vhr_pmr | 1317.63|vmr_phr |    0.00|vhr_pmr |    0.66|phr     |
| 365.22|vmr     | 171.16|mhr     |   3.00|vmr     | 1061.35|vmr     |    0.02|vmr     |    1.36|vmr     |
| 352.73|mmr     | 240.41|phr     |   3.00|vhr     |  933.98|pmr     |    0.06|vhr     |    1.83|pmr     |
| 342.27|pmr     | 242.02|vhr     |   0.04|pmr     |  932.38|mmr     |    0.12|pmr     |    3.89|vhr     |


Standardized $t$-distribution (std):  


|         mc_m|ranking |         mc_s|ranking | mc_min|ranking |       mc_max|ranking | dao_pct|ranking | dai_pct|ranking |
|------------:|:-------|------------:|:-------|------:|:-------|------------:|:-------|-------:|:-------|-------:|:-------|
| 1.293393e+20|pmr     | 2.111700e+02|vmr_phr | 127.60|vmr_phr | 1.293393e+24|pmr     |    0.00|vmr     |    0.00|mmr     |
| 4.300181e+05|vhr_pmr | 2.488900e+02|mhr     | 122.67|mmr     | 4.191411e+09|vhr_pmr |    0.00|vhr     |    0.00|mhr     |
| 1.439390e+03|mmr     | 2.830500e+02|phr     | 122.23|mhr     | 5.410257e+06|mmr     |    0.00|phr     |    0.00|vmr_phr |
| 7.017100e+02|vhr     | 3.123300e+02|vmr     |  99.73|vhr_pmr | 5.603320e+03|vmr     |    0.00|mmr     |    0.01|vhr_pmr |
| 6.012000e+02|mhr     | 4.133200e+02|vhr     |  78.35|vhr     | 5.079930e+03|vhr     |    0.00|mhr     |    0.08|vmr     |
| 5.942400e+02|vmr     | 5.454136e+04|mmr     |  65.73|vmr     | 3.108620e+03|phr     |    0.00|vmr_phr |    0.09|vhr     |
| 5.464200e+02|vmr_phr | 4.192550e+07|vhr_pmr |  57.83|phr     | 2.395180e+03|mhr     |    0.00|vhr_pmr |    0.40|phr     |
| 4.988800e+02|phr     | 1.293393e+22|pmr     |   0.03|pmr     | 2.186830e+03|vmr_phr |    0.09|pmr     |    0.69|pmr     |


Normal distribution:  


|   mc_m|ranking |   mc_s|ranking | mc_min|ranking |  mc_max|ranking | dao_pct|ranking | dai_pct|ranking |
|------:|:-------|------:|:-------|------:|:-------|-------:|:-------|-------:|:-------|-------:|:-------|
| 610.65|phr     |  89.78|mmr     | 163.84|mhr     | 3527.40|phr     |       0|vmr     |    0.00|pmr     |
| 561.39|mhr     | 100.63|pmr     | 160.98|vmr_phr | 3114.30|vhr     |       0|vhr     |    0.00|mmr     |
| 513.18|vhr     | 130.13|vhr_pmr | 158.70|vhr_pmr | 2093.70|vhr_pmr |       0|pmr     |    0.00|mhr     |
| 501.78|vmr_phr | 147.82|vmr     | 131.02|mmr     | 1814.66|mhr     |       0|phr     |    0.00|vmr_phr |
| 428.70|vhr_pmr | 164.02|vmr_phr | 102.84|pmr     | 1700.44|vmr_phr |       0|mmr     |    0.00|vhr_pmr |
| 387.42|vmr     | 187.95|mhr     |  99.94|phr     | 1434.40|vmr     |       0|mhr     |    0.01|vmr     |
| 369.91|mmr     | 243.69|vhr     |  92.96|vmr     |  944.67|mmr     |       0|vmr_phr |    0.01|phr     |
| 351.29|pmr     | 294.23|phr     |  82.74|vhr     |  892.69|pmr     |       0|vhr_pmr |    0.02|vhr     |



# Compare Gaussian and skewed t-distribution fits

## Gaussian fits







### Gaussian QQ plots



### Gaussian vs skewed t



Probability in percent that the smallest and largest (respectively) observed return for each fund was generated by a normal distribution:

|              |    vmr|    vhr|    pmr|    phr|    mmr|    mhr| vmr_phr| vhr_pmr|
|:-------------|------:|------:|------:|------:|------:|------:|-------:|-------:|
|P_norm(X_min) |  0.070|  0.088|  0.389|  0.582|  0.161|  0.255|   0.265|   0.155|
|P_norm(X_max) | 13.230| 11.876| 12.922| 15.359| 15.936| 13.198|  15.397|  15.556|
|P_t(X_min)    |  3.743|  5.457|  3.475|  4.567|  4.100|  5.035|   4.182|   3.022|
|P_t(X_max)    |  0.000|  0.001|  2.818|  0.023|  0.052|  0.004|   0.000|   0.001|

Average number of years between min or max events (respectively):

|                      |          vmr|        vhr|     pmr|      phr|      mmr|       mhr|    vmr_phr|    vhr_pmr|
|:---------------------|------------:|----------:|-------:|--------:|--------:|---------:|----------:|----------:|
|norm: avg yrs btw min | 1.438131e+03|   1139.205| 256.817|  171.880|  620.586|   392.517|    376.706|    644.455|
|norm: avg yrs btw max | 7.559000e+00|      8.420|   7.739|    6.511|    6.275|     7.577|      6.495|      6.428|
|t: avg yrs btw min    | 2.671500e+01|     18.324|  28.775|   21.898|   24.387|    19.862|     23.914|     33.089|
|t: avg yrs btw max    | 3.834699e+08| 178349.076|  35.487| 4439.617| 1930.115| 23903.982| 236209.123| 124926.545|


#### Lilliefors test  






p-values for Lilliefors test.  
Testing $H_0$, that log-returns are Gaussian.


|        |   vmr|   vhr|   pmr|  phr|   mmr|   mhr| vmr_phr| vhr_pmr|
|:-------|-----:|-----:|-----:|----:|-----:|-----:|-------:|-------:|
|p value | 0.052| 0.343| 0.024| 0.06| 0.041| 0.251|   0.113|   0.183|



#### Wittgenstein's Ruler  


For different given probabilities that returns are Gaussian, what is the probability that the distribution is Gaussian rather than skewed t-distributed, given the smallest/largest observed log-returns?

Conditional probabilities for smallest observed log-returns:

![](pension-returns_annual_files/figure-html/unnamed-chunk-189-1.png)<!-- -->


Use $1 - \text{p-value}$ from Lilliefors test as prior probability that the distribution is Gaussian.  
$x_{\text{obs}} = \min(x)$ and $P[\text{Event}\ |\ \text{Gaussian}] = P_{\text{Gauss}}[X \leq x_{\text{min}}]$:




|                      |   vmr|   vhr|   pmr|   phr|   mmr|   mhr| vmr_phr| vhr_pmr|
|:---------------------|-----:|-----:|-----:|-----:|-----:|-----:|-------:|-------:|
|Lillie p-val          | 0.052| 0.343| 0.024| 0.060| 0.041| 0.251|   0.113|   0.183|
|Prior prob            | 0.948| 0.657| 0.976| 0.940| 0.959| 0.749|   0.887|   0.817|
|P[Gauss &#124; Event] | 0.737| 0.210| 0.855| 0.852| 0.730| 0.383|   0.649|   0.448|



Use $1 - \text{p-value}$ from Lilliefors test as prior probability that the distribution is Gaussian.  
$x_{\text{obs}} = \max(x)$ and $P[\text{Event}\ |\ \text{Gaussian}] = P_{\text{Gauss}}[X \geq x_{\text{max}}]$:

![](pension-returns_annual_files/figure-html/unnamed-chunk-192-1.png)<!-- -->




|                      |   vmr|   vhr|   pmr|  phr|   mmr|   mhr| vmr_phr| vhr_pmr|
|:---------------------|-----:|-----:|-----:|----:|-----:|-----:|-------:|-------:|
|Lillie p-val          | 0.052| 0.343| 0.024| 0.06| 0.041| 0.251|   0.113|   0.183|
|Prior prob            | 0.948| 0.657| 0.976| 0.94| 0.959| 0.749|   0.887|   0.817|
|P[Gauss &#124; Event] | 1.000| 1.000| 0.995| 1.00| 1.000| 1.000|   1.000|   1.000|


# Velliv medium risk (vmr), 2011 - 2023




## QQ Plot

Skewed $t$-distribution (sstd):  

![](pension-returns_annual_files/figure-html/unnamed-chunk-278-1.png)<!-- -->



## Data vs fit

Let's plot the fit and the observed returns together.  

![](pension-returns_annual_files/figure-html/unnamed-chunk-279-1.png)<!-- -->



## Estimated distribution

Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pension-returns_annual_files/figure-html/unnamed-chunk-280-1.png)<!-- -->



## Monte Carlo



















Sorted portfolio index values for last period of all runs

![](pension-returns_annual_files/figure-html/unnamed-chunk-285-1.png)<!-- -->


## Convergence

### Max vs sum

Max vs sum plots for the first four moments:

![](pension-returns_annual_files/figure-html/unnamed-chunk-286-1.png)<!-- -->




### MC

![](pension-returns_annual_files/figure-html/unnamed-chunk-287-1.png)<!-- -->


### IS

Skewed $t$-distribution with a normal proposal distribution.

![](pension-returns_annual_files/figure-html/unnamed-chunk-288-1.png)<!-- -->

Parameters

```
## [1] 1.4145605 0.3807834
```

Objective function plots

![](pension-returns_annual_files/figure-html/unnamed-chunk-290-1.png)<!-- -->





# Velliv high risk (vhr), 2011 - 2023




## QQ Plot

Skewed $t$-distribution (sstd):  

![](pension-returns_annual_files/figure-html/unnamed-chunk-307-1.png)<!-- -->



## Data vs fit

Let's plot the fit and the observed returns together.  

![](pension-returns_annual_files/figure-html/unnamed-chunk-308-1.png)<!-- -->



## Estimated distribution

Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pension-returns_annual_files/figure-html/unnamed-chunk-309-1.png)<!-- -->



## Monte Carlo



















Sorted portfolio index values for last period of all runs

![](pension-returns_annual_files/figure-html/unnamed-chunk-314-1.png)<!-- -->


## Convergence

### Max vs sum

Max vs sum plots for the first four moments:

![](pension-returns_annual_files/figure-html/unnamed-chunk-315-1.png)<!-- -->




### MC

![](pension-returns_annual_files/figure-html/unnamed-chunk-316-1.png)<!-- -->


### IS

Skewed $t$-distribution with a normal proposal distribution.

![](pension-returns_annual_files/figure-html/unnamed-chunk-317-1.png)<!-- -->

Parameters

```
## [1] 1.7391222 0.4858909
```

Objective function plots

![](pension-returns_annual_files/figure-html/unnamed-chunk-319-1.png)<!-- -->





# PFA medium risk (pmr), 2011 - 2023




## QQ Plot

Skewed $t$-distribution (sstd):  

![](pension-returns_annual_files/figure-html/unnamed-chunk-336-1.png)<!-- -->



## Data vs fit

Let's plot the fit and the observed returns together.  

![](pension-returns_annual_files/figure-html/unnamed-chunk-337-1.png)<!-- -->



## Estimated distribution

Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pension-returns_annual_files/figure-html/unnamed-chunk-338-1.png)<!-- -->



## Monte Carlo








pmr has the sstd fit with the lowest value of nu. Compare with other distributions:



![](pension-returns_annual_files/figure-html/unnamed-chunk-340-1.png)<!-- -->

![](pension-returns_annual_files/figure-html/unnamed-chunk-341-1.png)<!-- -->

![](pension-returns_annual_files/figure-html/unnamed-chunk-342-1.png)<!-- -->


Sorted portfolio index values for last period of all runs

![](pension-returns_annual_files/figure-html/unnamed-chunk-343-1.png)<!-- -->


## Convergence

### Max vs sum

Max vs sum plots for the first four moments:

![](pension-returns_annual_files/figure-html/unnamed-chunk-344-1.png)<!-- -->




### MC

![](pension-returns_annual_files/figure-html/unnamed-chunk-345-1.png)<!-- -->


### IS

Skewed $t$-distribution with a normal proposal distribution.

![](pension-returns_annual_files/figure-html/unnamed-chunk-346-1.png)<!-- -->

Parameters

```
## [1] 1.3304634 0.2764028
```

Objective function plots

![](pension-returns_annual_files/figure-html/unnamed-chunk-348-1.png)<!-- -->





# PFA high risk (phr), 2011 - 2023




## QQ Plot

Skewed $t$-distribution (sstd):  

![](pension-returns_annual_files/figure-html/unnamed-chunk-365-1.png)<!-- -->



## Data vs fit

Let's plot the fit and the observed returns together.  

![](pension-returns_annual_files/figure-html/unnamed-chunk-366-1.png)<!-- -->



## Estimated distribution

Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pension-returns_annual_files/figure-html/unnamed-chunk-367-1.png)<!-- -->



## Monte Carlo






phr has the sstd fit with the highest sstd fit with thevalue of nu. Compare with other distributions:





![](pension-returns_annual_files/figure-html/unnamed-chunk-369-1.png)<!-- -->

![](pension-returns_annual_files/figure-html/unnamed-chunk-370-1.png)<!-- -->

![](pension-returns_annual_files/figure-html/unnamed-chunk-371-1.png)<!-- -->


Sorted portfolio index values for last period of all runs

![](pension-returns_annual_files/figure-html/unnamed-chunk-372-1.png)<!-- -->


## Convergence

### Max vs sum

Max vs sum plots for the first four moments:

![](pension-returns_annual_files/figure-html/unnamed-chunk-373-1.png)<!-- -->




### MC

![](pension-returns_annual_files/figure-html/unnamed-chunk-374-1.png)<!-- -->


### IS

Skewed $t$-distribution with a normal proposal distribution.

![](pension-returns_annual_files/figure-html/unnamed-chunk-375-1.png)<!-- -->

Parameters

```
## [1] 2.0162301 0.4463226
```

Objective function plots

![](pension-returns_annual_files/figure-html/unnamed-chunk-377-1.png)<!-- -->





# Mix medium risk (mmr), 2011 - 2023




## QQ Plot

Skewed $t$-distribution (sstd):  

![](pension-returns_annual_files/figure-html/unnamed-chunk-394-1.png)<!-- -->



## Data vs fit

Let's plot the fit and the observed returns together.  

![](pension-returns_annual_files/figure-html/unnamed-chunk-395-1.png)<!-- -->



## Estimated distribution

Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pension-returns_annual_files/figure-html/unnamed-chunk-396-1.png)<!-- -->



## Monte Carlo



















Sorted portfolio index values for last period of all runs

![](pension-returns_annual_files/figure-html/unnamed-chunk-401-1.png)<!-- -->


## Convergence

### Max vs sum

Max vs sum plots for the first four moments:

![](pension-returns_annual_files/figure-html/unnamed-chunk-402-1.png)<!-- -->




### MC

![](pension-returns_annual_files/figure-html/unnamed-chunk-403-1.png)<!-- -->


### IS

Skewed $t$-distribution with a normal proposal distribution.

![](pension-returns_annual_files/figure-html/unnamed-chunk-404-1.png)<!-- -->

Parameters

```
## [1] 1.3516393 0.2503782
```

Objective function plots

![](pension-returns_annual_files/figure-html/unnamed-chunk-406-1.png)<!-- -->





# Mix high risk (mhr), 2011 - 2023




## QQ Plot

Skewed $t$-distribution (sstd):  

![](pension-returns_annual_files/figure-html/unnamed-chunk-423-1.png)<!-- -->



## Data vs fit

Let's plot the fit and the observed returns together.  

![](pension-returns_annual_files/figure-html/unnamed-chunk-424-1.png)<!-- -->



## Estimated distribution

Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pension-returns_annual_files/figure-html/unnamed-chunk-425-1.png)<!-- -->



## Monte Carlo



















Sorted portfolio index values for last period of all runs

![](pension-returns_annual_files/figure-html/unnamed-chunk-430-1.png)<!-- -->


## Convergence

### Max vs sum

Max vs sum plots for the first four moments:

![](pension-returns_annual_files/figure-html/unnamed-chunk-431-1.png)<!-- -->




### MC

![](pension-returns_annual_files/figure-html/unnamed-chunk-432-1.png)<!-- -->


### IS

Skewed $t$-distribution with a normal proposal distribution.

![](pension-returns_annual_files/figure-html/unnamed-chunk-433-1.png)<!-- -->

Parameters

```
## [1] 1.8775189 0.3400818
```

Objective function plots

![](pension-returns_annual_files/figure-html/unnamed-chunk-435-1.png)<!-- -->





# Mix vmr+phr (vm_ph), 2011 - 2023




## QQ Plot

Skewed $t$-distribution (sstd):  

![](pension-returns_annual_files/figure-html/unnamed-chunk-452-1.png)<!-- -->



## Data vs fit

Let's plot the fit and the observed returns together.  

![](pension-returns_annual_files/figure-html/unnamed-chunk-453-1.png)<!-- -->



## Estimated distribution

Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pension-returns_annual_files/figure-html/unnamed-chunk-454-1.png)<!-- -->



## Monte Carlo



















Sorted portfolio index values for last period of all runs

![](pension-returns_annual_files/figure-html/unnamed-chunk-459-1.png)<!-- -->


## Convergence

### Max vs sum

Max vs sum plots for the first four moments:

![](pension-returns_annual_files/figure-html/unnamed-chunk-460-1.png)<!-- -->




### MC

![](pension-returns_annual_files/figure-html/unnamed-chunk-461-1.png)<!-- -->


### IS

Skewed $t$-distribution with a normal proposal distribution.

![](pension-returns_annual_files/figure-html/unnamed-chunk-462-1.png)<!-- -->

Parameters

```
## [1] 1.7507161 0.3263777
```

Objective function plots

![](pension-returns_annual_files/figure-html/unnamed-chunk-464-1.png)<!-- -->





# Mix vhr+pmr (mh_pm), 2011 - 2023




## QQ Plot

Skewed $t$-distribution (sstd):  

![](pension-returns_annual_files/figure-html/unnamed-chunk-481-1.png)<!-- -->



## Data vs fit

Let's plot the fit and the observed returns together.  

![](pension-returns_annual_files/figure-html/unnamed-chunk-482-1.png)<!-- -->



## Estimated distribution

Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pension-returns_annual_files/figure-html/unnamed-chunk-483-1.png)<!-- -->



## Monte Carlo



















Sorted portfolio index values for last period of all runs

![](pension-returns_annual_files/figure-html/unnamed-chunk-488-1.png)<!-- -->


## Convergence

### Max vs sum

Max vs sum plots for the first four moments:

![](pension-returns_annual_files/figure-html/unnamed-chunk-489-1.png)<!-- -->




### MC

![](pension-returns_annual_files/figure-html/unnamed-chunk-490-1.png)<!-- -->


### IS

Skewed $t$-distribution with a normal proposal distribution.

![](pension-returns_annual_files/figure-html/unnamed-chunk-491-1.png)<!-- -->

Parameters

```
## [1] 1.540135 0.320090
```

Objective function plots

![](pension-returns_annual_files/figure-html/unnamed-chunk-493-1.png)<!-- -->


# Velliv medium risk (vmr), 2011 - 2023




## QQ Plot

Skewed $t$-distribution (sstd):  

![](pension-returns_annual_files/figure-html/unnamed-chunk-511-1.png)<!-- -->



## Data vs fit

Let's plot the fit and the observed returns together.  

![](pension-returns_annual_files/figure-html/unnamed-chunk-512-1.png)<!-- -->



## Estimated distribution

Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pension-returns_annual_files/figure-html/unnamed-chunk-513-1.png)<!-- -->



## Monte Carlo



















Sorted portfolio index values for last period of all runs

![](pension-returns_annual_files/figure-html/unnamed-chunk-518-1.png)<!-- -->


## Convergence

### Max vs sum

Max vs sum plots for the first four moments:

![](pension-returns_annual_files/figure-html/unnamed-chunk-519-1.png)<!-- -->




### MC

![](pension-returns_annual_files/figure-html/unnamed-chunk-520-1.png)<!-- -->


### IS

Skewed $t$-distribution with a normal proposal distribution.

![](pension-returns_annual_files/figure-html/unnamed-chunk-521-1.png)<!-- -->

Parameters

```
## [1] 1.4145605 0.3807834
```

Objective function plots

![](pension-returns_annual_files/figure-html/unnamed-chunk-523-1.png)<!-- -->












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
## m(data_x): -0.0009009278 
## s(data_x): 0.341505 
## m(data_y): 9.986828 
## s(data_y): 3.86378 
## 
## m(data_x + data_y): 4.992964 
## s(data_x + data_y): 1.964015
```

m and s of final state of all paths.\
`_a` is mix of simulated returns.\
`_b` is simulated mixed returns.


|     m_a|     m_b|   s_a|   s_b|
|-------:|-------:|-----:|-----:|
|  99.758| 100.039| 8.818| 9.082|
|  99.733|  99.617| 8.435| 9.034|
|  99.949|  99.981| 8.728| 8.749|
| 100.126|  99.525| 8.654| 8.931|
|  99.998|  99.590| 8.969| 9.095|
|  99.612|  99.483| 8.891| 8.925|
|  99.790|  99.733| 8.949| 8.758|
|  99.847| 100.170| 8.217| 8.806|
|  99.512| 100.107| 8.719| 8.905|
|  99.420|  99.888| 8.670| 8.907|


```
##       m_a              m_b              s_a             s_b       
##  Min.   : 99.42   Min.   : 99.48   Min.   :8.217   Min.   :8.749  
##  1st Qu.: 99.64   1st Qu.: 99.60   1st Qu.:8.658   1st Qu.:8.830  
##  Median : 99.77   Median : 99.81   Median :8.724   Median :8.916  
##  Mean   : 99.77   Mean   : 99.81   Mean   :8.705   Mean   :8.919  
##  3rd Qu.: 99.92   3rd Qu.:100.02   3rd Qu.:8.873   3rd Qu.:9.008  
##  Max.   :100.13   Max.   :100.17   Max.   :8.969   Max.   :9.095
```

`_a` and `_b` are very close to equal.\
We attribute the differences to differences in estimating the
distributions in version a and b.

The final state is independent of the order of the preceding steps:

![](pension-returns_annual_files/figure-html/unnamed-chunk-43-1.png)<!-- -->

So does the order of the steps in the two processes matter, when mixing
simulated returns?

![](pension-returns_annual_files/figure-html/unnamed-chunk-44-1.png)<!-- -->

![](pension-returns_annual_files/figure-html/unnamed-chunk-45-1.png)<!-- -->

The order of steps in the individual paths do not matter, because the
mix of simulated paths is a sum of a sum, so the order of terms doesn't
affect the sum. If there is variation it is because the sets preceding
steps are not the same. For instance, the steps between step 1 and 60 in
the plot above are not the same for the two lines.

Recall,
$$\text{Var}(aX+bY) = a^2 \text{Var}(X) + b^2 \text{Var}(Y) + 2ab \text{Cov}(a, b)$$


```r
var(0.5 * vhr + 0.5 * phr)
```

```
## [1] 0.01055146
```

```r
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
##  Min.   :0.05912   Min.   :0.05196  
##  1st Qu.:0.06574   1st Qu.:0.06081  
##  Median :0.06785   Median :0.06831  
##  Mean   :0.06880   Mean   :0.06911  
##  3rd Qu.:0.07076   3rd Qu.:0.07634  
##  Max.   :0.08354   Max.   :0.09154
```

## The meaning of `xi`

The fit for `mhr` has the highest `xi` value of all. This suggests
right-skew:

![](pension-returns_annual_files/figure-html/unnamed-chunk-48-1.png)<!-- -->

## Max vs sum plot

If the Law Of Large Numbers holds true,
$$\dfrac{\max (X_1^p, ..., X^p)}{\sum_{i=1}^n X_i^p} \rightarrow 0$$ for
$n \rightarrow \infty$.

If not, $X$ doesn't have a $p$'th moment.

See Taleb: The Statistical Consequences Of Fat Tails, p. 192


