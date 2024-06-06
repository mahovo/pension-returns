---
title: "Monthly pension returns analysis: \nVelliv June 2012 - April 2024"
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
  run_individual: TRUE ## Include individual reports?
  run_comparison: TRUE ## Include comparison report? Depends on run_individual.
  run_mc_plot: TRUE ## Depends on run_individual.
  run_is_sim: TRUE
  run_is_plot: TRUE
  include_long: TRUE
date: "08:53 05 June 2024"
---































Fit log returns to F-S skew standardized Student-t distribution.  
`m`  is the location parameter.  
`s` is the scale parameter.  
`nu` is the estimated shape parameter (degrees of freedom).  
`xi` is the estimated skewness parameter.  

# Returns data  

The long version of Velliv medium risk data runs from January 2007 to April 2024 (incl).  
For January 2007 to May 2012 no low risk and high risk funds existed. For this period the medium risk data is copied into the other funds.  

The short version runs from June 2012 to April 2024.

Velliv returns are including bonus and "DinKapital.  
PFA returns are including "KundeKapital".  




























![](pension-returns_monthly_files/figure-html/unnamed-chunk-14-1.png)<!-- -->

![](pension-returns_monthly_files/figure-html/unnamed-chunk-15-1.png)<!-- -->




![](pension-returns_monthly_files/figure-html/unnamed-chunk-16-1.png)<!-- -->


![](pension-returns_monthly_files/figure-html/unnamed-chunk-17-1.png)<!-- -->




![](pension-returns_monthly_files/figure-html/unnamed-chunk-18-1.png)<!-- -->

![](pension-returns_monthly_files/figure-html/unnamed-chunk-19-1.png)<!-- -->

![](pension-returns_monthly_files/figure-html/unnamed-chunk-20-1.png)<!-- -->

![](pension-returns_monthly_files/figure-html/unnamed-chunk-21-1.png)<!-- -->
![](pension-returns_monthly_files/figure-html/unnamed-chunk-22-1.png)<!-- -->






























































































## Summary of log-returns

The summary statistics are transformed back to the scale of gross returns by taking $exp()$ of each summary statistic. (Note: Taking arithmetic mean of gross returns directly is no good. Must be geometric mean.)







|         |   vmr|   vhr|  vmrl|   pmr|   phr|   mmr|   mhr| vmr_phr| vhr_pmr|
|:--------|-----:|-----:|-----:|-----:|-----:|-----:|-----:|-------:|-------:|
|Min.   : | 0.901| 0.877| 0.901| 0.924| 0.886| 0.912| 0.882|   0.893|   0.899|
|1st Qu.: | 0.996| 0.994| 0.995| 0.999| 0.994| 0.997| 0.995|   0.996|   0.996|
|Median : | 1.010| 1.012| 1.007| 1.008| 1.012| 1.009| 1.013|   1.011|   1.011|
|Mean   : | 1.006| 1.007| 1.005| 1.005| 1.008| 1.006| 1.008|   1.007|   1.006|
|3rd Qu.: | 1.021| 1.027| 1.020| 1.015| 1.025| 1.018| 1.025|   1.022|   1.021|
|Max.   : | 1.070| 1.088| 1.070| 1.043| 1.079| 1.054| 1.082|   1.073|   1.065|


## Ranking

| Min.   :|ranking | 1st Qu.:|ranking | Median :|ranking | Mean   :|ranking | 3rd Qu.:|ranking | Max.   :|ranking |
|--------:|:-------|--------:|:-------|--------:|:-------|--------:|:-------|--------:|:-------|--------:|:-------|
|    0.924|pmr     |    0.999|pmr     |    1.013|mhr     |    1.008|phr     |    1.027|vhr     |    1.088|vhr     |
|    0.912|mmr     |    0.997|mmr     |    1.012|phr     |    1.008|mhr     |    1.025|phr     |    1.082|mhr     |
|    0.901|vmr     |    0.996|vmr     |    1.012|vhr     |    1.007|vhr     |    1.025|mhr     |    1.079|phr     |
|    0.901|vmrl    |    0.996|vhr_pmr |    1.011|vmr_phr |    1.007|vmr_phr |    1.022|vmr_phr |    1.073|vmr_phr |
|    0.899|vhr_pmr |    0.996|vmr_phr |    1.011|vhr_pmr |    1.006|vhr_pmr |    1.021|vmr     |    1.070|vmr     |
|    0.893|vmr_phr |    0.995|mhr     |    1.010|vmr     |    1.006|vmr     |    1.021|vhr_pmr |    1.070|vmrl    |
|    0.886|phr     |    0.995|vmrl    |    1.009|mmr     |    1.006|mmr     |    1.020|vmrl    |    1.065|vhr_pmr |
|    0.882|mhr     |    0.994|phr     |    1.008|pmr     |    1.005|pmr     |    1.018|mmr     |    1.054|mmr     |
|    0.877|vhr     |    0.994|vhr     |    1.007|vmrl    |    1.005|vmrl    |    1.015|pmr     |    1.043|pmr     |


## Correlations and covariance

Correlations

|    |   vmr|   vhr|   pmr|   phr|
|:---|-----:|-----:|-----:|-----:|
|vmr | 1.000| 0.997| 0.961| 0.964|
|vhr | 0.997| 1.000| 0.951| 0.967|
|pmr | 0.961| 0.951| 1.000| 0.977|
|phr | 0.964| 0.967| 0.977| 1.000|

Covariances

|    |   vmr|   vhr| pmr|   phr|
|:---|-----:|-----:|---:|-----:|
|vmr | 0.001| 0.001|   0| 0.001|
|vhr | 0.001| 0.001|   0| 0.001|
|pmr | 0.000| 0.000|   0| 0.000|
|phr | 0.001| 0.001|   0| 0.001|


# Compare pension plans

## Risk of loss

Risk of loss at least as big as row name in percent for a single period (year).

Skewed $t$-distribution (sstd):  






|   |    vmr|    vhr|    pmr|    phr|    mmr|    mhr| vmr_phr| vhr_pmr|
|:--|------:|------:|------:|------:|------:|------:|-------:|-------:|
|0  | 32.333| 33.000| 30.167| 31.667| 31.167| 32.167|  31.833|  31.667|
|5  |  2.500|  4.167|  0.667|  3.167|  1.500|  3.500|   2.667|   2.500|
|10 |  0.167|  0.500|  0.000|  0.167|  0.000|  0.333|   0.167|   0.167|
|25 |  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|   0.000|   0.000|
|50 |  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|   0.000|   0.000|
|90 |  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|   0.000|   0.000|
|99 |  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|   0.000|   0.000|


Standardized $t$-distribution (std):  




|   |    vmr|    vhr|    pmr|    phr|    mmr|    mhr| vmr_phr| vhr_pmr|
|:--|------:|------:|------:|------:|------:|------:|-------:|-------:|
|0  | 28.833| 29.500| 22.667| 29.333| 25.667| 29.333|      29|  27.333|
|5  |  1.833|  3.167|  0.833|  2.500|  1.167|  2.667|       2|   1.833|
|10 |  0.000|  0.333|  0.000|  0.000|  0.000|  0.167|       0|   0.000|
|25 |  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|       0|   0.000|
|50 |  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|       0|   0.000|
|90 |  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|       0|   0.000|
|99 |  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|       0|   0.000|


Normal distribution:  




|   |    vmr|    vhr|    pmr|    phr|    mmr|    mhr| vmr_phr| vhr_pmr|
|:--|------:|------:|------:|------:|------:|------:|-------:|-------:|
|0  | 40.333| 40.667| 37.833| 38.500| 39.167| 39.500|  39.167|  39.667|
|5  |  0.500|  2.333|  0.000|  1.333|  0.000|  1.667|   0.833|   0.500|
|10 |  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|   0.000|   0.000|
|25 |  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|   0.000|   0.000|
|50 |  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|   0.000|   0.000|
|90 |  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|   0.000|   0.000|
|99 |  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|   0.000|   0.000|


### Worst ranking for loss percentiles

Skewed $t$-distribution (sstd):  


|      0|ranking |     5|ranking |    10|ranking | 25|ranking | 50|ranking | 90|ranking | 99|ranking |
|------:|:-------|-----:|:-------|-----:|:-------|--:|:-------|--:|:-------|--:|:-------|--:|:-------|
| 33.000|vhr     | 4.167|vhr     | 0.500|vhr     |  0|vmr     |  0|vmr     |  0|vmr     |  0|vmr     |
| 32.333|vmr     | 3.500|mhr     | 0.333|mhr     |  0|vhr     |  0|vhr     |  0|vhr     |  0|vhr     |
| 32.167|mhr     | 3.167|phr     | 0.167|vmr     |  0|pmr     |  0|pmr     |  0|pmr     |  0|pmr     |
| 31.833|vmr_phr | 2.667|vmr_phr | 0.167|phr     |  0|phr     |  0|phr     |  0|phr     |  0|phr     |
| 31.667|phr     | 2.500|vmr     | 0.167|vmr_phr |  0|mmr     |  0|mmr     |  0|mmr     |  0|mmr     |
| 31.667|vhr_pmr | 2.500|vhr_pmr | 0.167|vhr_pmr |  0|mhr     |  0|mhr     |  0|mhr     |  0|mhr     |
| 31.167|mmr     | 1.500|mmr     | 0.000|pmr     |  0|vmr_phr |  0|vmr_phr |  0|vmr_phr |  0|vmr_phr |
| 30.167|pmr     | 0.667|pmr     | 0.000|mmr     |  0|vhr_pmr |  0|vhr_pmr |  0|vhr_pmr |  0|vhr_pmr |


Standardized $t$-distribution (std):  


|      0|ranking |     5|ranking |    10|ranking | 25|ranking | 50|ranking | 90|ranking | 99|ranking |
|------:|:-------|-----:|:-------|-----:|:-------|--:|:-------|--:|:-------|--:|:-------|--:|:-------|
| 29.500|vhr     | 3.167|vhr     | 0.333|vhr     |  0|vmr     |  0|vmr     |  0|vmr     |  0|vmr     |
| 29.333|phr     | 2.667|mhr     | 0.167|mhr     |  0|vhr     |  0|vhr     |  0|vhr     |  0|vhr     |
| 29.333|mhr     | 2.500|phr     | 0.000|vmr     |  0|pmr     |  0|pmr     |  0|pmr     |  0|pmr     |
| 29.000|vmr_phr | 2.000|vmr_phr | 0.000|pmr     |  0|phr     |  0|phr     |  0|phr     |  0|phr     |
| 28.833|vmr     | 1.833|vmr     | 0.000|phr     |  0|mmr     |  0|mmr     |  0|mmr     |  0|mmr     |
| 27.333|vhr_pmr | 1.833|vhr_pmr | 0.000|mmr     |  0|mhr     |  0|mhr     |  0|mhr     |  0|mhr     |
| 25.667|mmr     | 1.167|mmr     | 0.000|vmr_phr |  0|vmr_phr |  0|vmr_phr |  0|vmr_phr |  0|vmr_phr |
| 22.667|pmr     | 0.833|pmr     | 0.000|vhr_pmr |  0|vhr_pmr |  0|vhr_pmr |  0|vhr_pmr |  0|vhr_pmr |


Normal distribution:  


|      0|ranking |     5|ranking | 10|ranking | 25|ranking | 50|ranking | 90|ranking | 99|ranking |
|------:|:-------|-----:|:-------|--:|:-------|--:|:-------|--:|:-------|--:|:-------|--:|:-------|
| 40.667|vhr     | 2.333|vhr     |  0|vmr     |  0|vmr     |  0|vmr     |  0|vmr     |  0|vmr     |
| 40.333|vmr     | 1.667|mhr     |  0|vhr     |  0|vhr     |  0|vhr     |  0|vhr     |  0|vhr     |
| 39.667|vhr_pmr | 1.333|phr     |  0|pmr     |  0|pmr     |  0|pmr     |  0|pmr     |  0|pmr     |
| 39.500|mhr     | 0.833|vmr_phr |  0|phr     |  0|phr     |  0|phr     |  0|phr     |  0|phr     |
| 39.167|mmr     | 0.500|vmr     |  0|mmr     |  0|mmr     |  0|mmr     |  0|mmr     |  0|mmr     |
| 39.167|vmr_phr | 0.500|vhr_pmr |  0|mhr     |  0|mhr     |  0|mhr     |  0|mhr     |  0|mhr     |
| 38.500|phr     | 0.000|pmr     |  0|vmr_phr |  0|vmr_phr |  0|vmr_phr |  0|vmr_phr |  0|vmr_phr |
| 37.833|pmr     | 0.000|mmr     |  0|vhr_pmr |  0|vhr_pmr |  0|vhr_pmr |  0|vhr_pmr |  0|vhr_pmr |


## Chance of min gains

Chance of gains of at least `x` percent for a single period (year).  
`x` values are row names.


Skewed $t$-distribution (sstd):  






|    |    vmr|    vhr|    pmr|    phr|    mmr|    mhr| vmr_phr| vhr_pmr|
|:---|------:|------:|------:|------:|------:|------:|-------:|-------:|
|0   | 67.667| 67.000| 69.833| 68.333| 68.833| 67.833|  68.167|  68.333|
|5   |  1.167|  3.833|  0.167|  3.667|  0.500|  3.333|   2.167|   1.333|
|10  |  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|   0.000|   0.000|
|25  |  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|   0.000|   0.000|
|50  |  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|   0.000|   0.000|
|100 |  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|   0.000|   0.000|


Standardized $t$-distribution (std):  




|    |    vmr|    vhr|    pmr|    phr|    mmr|    mhr| vmr_phr| vhr_pmr|
|:---|------:|------:|------:|------:|------:|------:|-------:|-------:|
|0   | 71.167| 70.500| 77.333| 70.667| 74.333| 70.667|  71.000|  72.667|
|5   |  7.833| 13.500|  3.667| 11.500|  5.500| 12.500|   9.667|   8.167|
|10  |  0.667|  1.833|  0.167|  1.167|  0.333|  1.333|   0.833|   0.833|
|25  |  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|   0.000|   0.000|
|50  |  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|   0.000|   0.000|
|100 |  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|   0.000|   0.000|


Normal distribution:  




|    |    vmr|    vhr|    pmr|    phr|    mmr|  mhr| vmr_phr| vhr_pmr|
|:---|------:|------:|------:|------:|------:|----:|-------:|-------:|
|0   | 59.667| 59.333| 62.167| 61.500| 60.833| 60.5|  60.833|  60.333|
|5   |  3.333|  8.333|  0.167|  7.167|  1.333|  7.5|   5.167|   3.500|
|10  |  0.000|  0.000|  0.000|  0.000|  0.000|  0.0|   0.000|   0.000|
|25  |  0.000|  0.000|  0.000|  0.000|  0.000|  0.0|   0.000|   0.000|
|50  |  0.000|  0.000|  0.000|  0.000|  0.000|  0.0|   0.000|   0.000|
|100 |  0.000|  0.000|  0.000|  0.000|  0.000|  0.0|   0.000|   0.000|



### Best ranking for gains percentiles


Skewed $t$-distribution (sstd):  


|      0|ranking |     5|ranking | 10|ranking | 25|ranking | 50|ranking | 100|ranking |
|------:|:-------|-----:|:-------|--:|:-------|--:|:-------|--:|:-------|---:|:-------|
| 69.833|pmr     | 3.833|vhr     |  0|vmr     |  0|vmr     |  0|vmr     |   0|vmr     |
| 68.833|mmr     | 3.667|phr     |  0|vhr     |  0|vhr     |  0|vhr     |   0|vhr     |
| 68.333|phr     | 3.333|mhr     |  0|pmr     |  0|pmr     |  0|pmr     |   0|pmr     |
| 68.333|vhr_pmr | 2.167|vmr_phr |  0|phr     |  0|phr     |  0|phr     |   0|phr     |
| 68.167|vmr_phr | 1.333|vhr_pmr |  0|mmr     |  0|mmr     |  0|mmr     |   0|mmr     |
| 67.833|mhr     | 1.167|vmr     |  0|mhr     |  0|mhr     |  0|mhr     |   0|mhr     |
| 67.667|vmr     | 0.500|mmr     |  0|vmr_phr |  0|vmr_phr |  0|vmr_phr |   0|vmr_phr |
| 67.000|vhr     | 0.167|pmr     |  0|vhr_pmr |  0|vhr_pmr |  0|vhr_pmr |   0|vhr_pmr |


Standardized $t$-distribution (std):  


|      0|ranking |      5|ranking |    10|ranking | 25|ranking | 50|ranking | 100|ranking |
|------:|:-------|------:|:-------|-----:|:-------|--:|:-------|--:|:-------|---:|:-------|
| 77.333|pmr     | 13.500|vhr     | 1.833|vhr     |  0|vmr     |  0|vmr     |   0|vmr     |
| 74.333|mmr     | 12.500|mhr     | 1.333|mhr     |  0|vhr     |  0|vhr     |   0|vhr     |
| 72.667|vhr_pmr | 11.500|phr     | 1.167|phr     |  0|pmr     |  0|pmr     |   0|pmr     |
| 71.167|vmr     |  9.667|vmr_phr | 0.833|vmr_phr |  0|phr     |  0|phr     |   0|phr     |
| 71.000|vmr_phr |  8.167|vhr_pmr | 0.833|vhr_pmr |  0|mmr     |  0|mmr     |   0|mmr     |
| 70.667|phr     |  7.833|vmr     | 0.667|vmr     |  0|mhr     |  0|mhr     |   0|mhr     |
| 70.667|mhr     |  5.500|mmr     | 0.333|mmr     |  0|vmr_phr |  0|vmr_phr |   0|vmr_phr |
| 70.500|vhr     |  3.667|pmr     | 0.167|pmr     |  0|vhr_pmr |  0|vhr_pmr |   0|vhr_pmr |


Normal distribution:  


|      0|ranking |     5|ranking | 10|ranking | 25|ranking | 50|ranking | 100|ranking |
|------:|:-------|-----:|:-------|--:|:-------|--:|:-------|--:|:-------|---:|:-------|
| 62.167|pmr     | 8.333|vhr     |  0|vmr     |  0|vmr     |  0|vmr     |   0|vmr     |
| 61.500|phr     | 7.500|mhr     |  0|vhr     |  0|vhr     |  0|vhr     |   0|vhr     |
| 60.833|mmr     | 7.167|phr     |  0|pmr     |  0|pmr     |  0|pmr     |   0|pmr     |
| 60.833|vmr_phr | 5.167|vmr_phr |  0|phr     |  0|phr     |  0|phr     |   0|phr     |
| 60.500|mhr     | 3.500|vhr_pmr |  0|mmr     |  0|mmr     |  0|mmr     |   0|mmr     |
| 60.333|vhr_pmr | 3.333|vmr     |  0|mhr     |  0|mhr     |  0|mhr     |   0|mhr     |
| 59.667|vmr     | 1.333|mmr     |  0|vmr_phr |  0|vmr_phr |  0|vmr_phr |   0|vmr_phr |
| 59.333|vhr     | 0.167|pmr     |  0|vhr_pmr |  0|vhr_pmr |  0|vhr_pmr |   0|vhr_pmr |


## MC risk percentiles

Risk of loss at least as big as row name in percent from first to last period.  




Skewed $t$-distribution (sstd):  




|   |   vmr|   vhr|   pmr|   phr|  mmr|  mhr| vmr_phr| vhr_pmr|
|:--|-----:|-----:|-----:|-----:|----:|----:|-------:|-------:|
|0  | 17.71| 18.08| 10.00| 11.89| 7.65| 7.23|    7.11|    8.27|
|5  |  9.25| 11.04|  3.51|  6.44| 2.25| 2.58|    2.60|    2.78|
|10 |  4.54|  6.57|  1.19|  3.42| 0.62| 0.90|    0.75|    0.85|
|25 |  0.47|  0.88|  0.09|  0.35| 0.02| 0.02|    0.04|    0.03|
|50 |  0.02|  0.03|  0.01|  0.00| 0.00| 0.00|    0.00|    0.00|
|90 |  0.00|  0.00|  0.00|  0.00| 0.00| 0.00|    0.00|    0.00|
|99 |  0.00|  0.00|  0.00|  0.00| 0.00| 0.00|    0.00|    0.00|




Standardized $t$-distribution (std):  




|   |  vmr|  vhr|  pmr|  phr|  mmr|  mhr| vmr_phr| vhr_pmr|
|:--|----:|----:|----:|----:|----:|----:|-------:|-------:|
|0  | 4.21| 4.55| 2.33| 3.44| 0.64| 0.58|    0.60|    0.62|
|5  | 2.12| 2.64| 1.13| 1.67| 0.30| 0.18|    0.18|    0.23|
|10 | 1.08| 1.32| 0.57| 0.73| 0.11| 0.11|    0.08|    0.06|
|25 | 0.10| 0.21| 0.15| 0.06| 0.02| 0.01|    0.00|    0.01|
|50 | 0.00| 0.00| 0.04| 0.00| 0.00| 0.00|    0.00|    0.00|
|90 | 0.00| 0.00| 0.01| 0.00| 0.00| 0.00|    0.00|    0.00|
|99 | 0.00| 0.00| 0.00| 0.00| 0.00| 0.00|    0.00|    0.00|


Normal distribution:  




|   |   vmr|   vhr|  pmr|  phr|  mmr|  mhr| vmr_phr| vhr_pmr|
|:--|-----:|-----:|----:|----:|----:|----:|-------:|-------:|
|0  | 14.05| 15.07| 9.03| 9.83| 4.83| 4.39|    4.46|    5.75|
|5  |  6.01|  8.08| 2.22| 4.34| 0.64| 1.03|    1.01|    1.15|
|10 |  1.97|  3.53| 0.29| 1.66| 0.02| 0.23|    0.14|    0.12|
|25 |  0.00|  0.07| 0.00| 0.02| 0.00| 0.00|    0.00|    0.00|
|50 |  0.00|  0.00| 0.00| 0.00| 0.00| 0.00|    0.00|    0.00|
|90 |  0.00|  0.00| 0.00| 0.00| 0.00| 0.00|    0.00|    0.00|
|99 |  0.00|  0.00| 0.00| 0.00| 0.00| 0.00|    0.00|    0.00|


### Worst ranking for MC loss percentiles

Skewed $t$-distribution (sstd):  


|     0|ranking |     5|ranking |   10|ranking |   25|ranking |   50|ranking | 90|ranking | 99|ranking |
|-----:|:-------|-----:|:-------|----:|:-------|----:|:-------|----:|:-------|--:|:-------|--:|:-------|
| 18.08|vhr     | 11.04|vhr     | 6.57|vhr     | 0.88|vhr     | 0.03|vhr     |  0|vmr     |  0|vmr     |
| 17.71|vmr     |  9.25|vmr     | 4.54|vmr     | 0.47|vmr     | 0.02|vmr     |  0|vhr     |  0|vhr     |
| 11.89|phr     |  6.44|phr     | 3.42|phr     | 0.35|phr     | 0.01|pmr     |  0|pmr     |  0|pmr     |
| 10.00|pmr     |  3.51|pmr     | 1.19|pmr     | 0.09|pmr     | 0.00|phr     |  0|phr     |  0|phr     |
|  8.27|vhr_pmr |  2.78|vhr_pmr | 0.90|mhr     | 0.04|vmr_phr | 0.00|mmr     |  0|mmr     |  0|mmr     |
|  7.65|mmr     |  2.60|vmr_phr | 0.85|vhr_pmr | 0.03|vhr_pmr | 0.00|mhr     |  0|mhr     |  0|mhr     |
|  7.23|mhr     |  2.58|mhr     | 0.75|vmr_phr | 0.02|mmr     | 0.00|vmr_phr |  0|vmr_phr |  0|vmr_phr |
|  7.11|vmr_phr |  2.25|mmr     | 0.62|mmr     | 0.02|mhr     | 0.00|vhr_pmr |  0|vhr_pmr |  0|vhr_pmr |


Standardized $t$-distribution (std):  


|    0|ranking |    5|ranking |   10|ranking |   25|ranking |   50|ranking |   90|ranking | 99|ranking |
|----:|:-------|----:|:-------|----:|:-------|----:|:-------|----:|:-------|----:|:-------|--:|:-------|
| 4.55|vhr     | 2.64|vhr     | 1.32|vhr     | 0.21|vhr     | 0.04|pmr     | 0.01|pmr     |  0|vmr     |
| 4.21|vmr     | 2.12|vmr     | 1.08|vmr     | 0.15|pmr     | 0.00|vmr     | 0.00|vmr     |  0|vhr     |
| 3.44|phr     | 1.67|phr     | 0.73|phr     | 0.10|vmr     | 0.00|vhr     | 0.00|vhr     |  0|pmr     |
| 2.33|pmr     | 1.13|pmr     | 0.57|pmr     | 0.06|phr     | 0.00|phr     | 0.00|phr     |  0|phr     |
| 0.64|mmr     | 0.30|mmr     | 0.11|mmr     | 0.02|mmr     | 0.00|mmr     | 0.00|mmr     |  0|mmr     |
| 0.62|vhr_pmr | 0.23|vhr_pmr | 0.11|mhr     | 0.01|mhr     | 0.00|mhr     | 0.00|mhr     |  0|mhr     |
| 0.60|vmr_phr | 0.18|mhr     | 0.08|vmr_phr | 0.01|vhr_pmr | 0.00|vmr_phr | 0.00|vmr_phr |  0|vmr_phr |
| 0.58|mhr     | 0.18|vmr_phr | 0.06|vhr_pmr | 0.00|vmr_phr | 0.00|vhr_pmr | 0.00|vhr_pmr |  0|vhr_pmr |


Normal distribution:  


|     0|ranking |    5|ranking |   10|ranking |   25|ranking | 50|ranking | 90|ranking | 99|ranking |
|-----:|:-------|----:|:-------|----:|:-------|----:|:-------|--:|:-------|--:|:-------|--:|:-------|
| 15.07|vhr     | 8.08|vhr     | 3.53|vhr     | 0.07|vhr     |  0|vmr     |  0|vmr     |  0|vmr     |
| 14.05|vmr     | 6.01|vmr     | 1.97|vmr     | 0.02|phr     |  0|vhr     |  0|vhr     |  0|vhr     |
|  9.83|phr     | 4.34|phr     | 1.66|phr     | 0.00|vmr     |  0|pmr     |  0|pmr     |  0|pmr     |
|  9.03|pmr     | 2.22|pmr     | 0.29|pmr     | 0.00|pmr     |  0|phr     |  0|phr     |  0|phr     |
|  5.75|vhr_pmr | 1.15|vhr_pmr | 0.23|mhr     | 0.00|mmr     |  0|mmr     |  0|mmr     |  0|mmr     |
|  4.83|mmr     | 1.03|mhr     | 0.14|vmr_phr | 0.00|mhr     |  0|mhr     |  0|mhr     |  0|mhr     |
|  4.46|vmr_phr | 1.01|vmr_phr | 0.12|vhr_pmr | 0.00|vmr_phr |  0|vmr_phr |  0|vmr_phr |  0|vmr_phr |
|  4.39|mhr     | 0.64|mmr     | 0.02|mmr     | 0.00|vhr_pmr |  0|vhr_pmr |  0|vhr_pmr |  0|vhr_pmr |


## MC gains percentiles




Skewed $t$-distribution (sstd):  




|     |   vmr|   vhr|   pmr|   phr|   mmr|   mhr| vmr_phr| vhr_pmr|
|:----|-----:|-----:|-----:|-----:|-----:|-----:|-------:|-------:|
|0    | 82.29| 81.92| 90.00| 88.11| 92.35| 92.77|   92.89|   91.73|
|5    | 70.65| 72.69| 75.97| 79.76| 78.86| 84.34|   82.99|   80.04|
|10   | 55.47| 61.27| 55.27| 68.75| 55.72| 70.44|   66.97|   61.66|
|25   | 13.20| 24.67|  4.82| 29.65|  3.28| 20.10|   13.41|    9.13|
|50   |  0.14|  1.52|  0.02|  1.64|  0.00|  0.21|    0.02|    0.05|
|100  |  0.00|  0.04|  0.01|  0.01|  0.00|  0.00|    0.00|    0.00|
|200  |  0.00|  0.01|  0.00|  0.01|  0.00|  0.00|    0.00|    0.00|
|300  |  0.00|  0.01|  0.00|  0.00|  0.00|  0.00|    0.00|    0.00|
|400  |  0.00|  0.01|  0.00|  0.00|  0.00|  0.00|    0.00|    0.00|
|500  |  0.00|  0.01|  0.00|  0.00|  0.00|  0.00|    0.00|    0.00|
|1000 |  0.00|  0.01|  0.00|  0.00|  0.00|  0.00|    0.00|    0.00|




Standardized $t$-distribution (std):  




|     |   vmr|   vhr|   pmr|   phr|   mmr|   mhr| vmr_phr| vhr_pmr|
|:----|-----:|-----:|-----:|-----:|-----:|-----:|-------:|-------:|
|0    | 95.79| 95.45| 97.67| 96.56| 99.36| 99.42|   99.40|   99.38|
|5    | 92.09| 92.35| 94.81| 93.66| 98.00| 98.15|   98.21|   98.12|
|10   | 86.07| 87.80| 89.06| 88.99| 94.76| 95.63|   94.87|   95.25|
|25   | 54.92| 65.59| 49.09| 64.12| 54.65| 72.05|   64.24|   65.03|
|50   | 10.26| 24.55|  4.50| 18.98|  2.96| 14.88|    7.98|    8.18|
|100  |  0.28|  1.31|  0.17|  0.50|  0.05|  0.12|    0.04|    0.11|
|200  |  0.03|  0.04|  0.02|  0.00|  0.01|  0.00|    0.00|    0.01|
|300  |  0.02|  0.02|  0.02|  0.00|  0.00|  0.00|    0.00|    0.00|
|400  |  0.00|  0.00|  0.01|  0.00|  0.00|  0.00|    0.00|    0.00|
|500  |  0.00|  0.00|  0.01|  0.00|  0.00|  0.00|    0.00|    0.00|
|1000 |  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|    0.00|    0.00|


Normal distribution:  




|     |   vmr|   vhr|   pmr|   phr|   mmr|   mhr| vmr_phr| vhr_pmr|
|:----|-----:|-----:|-----:|-----:|-----:|-----:|-------:|-------:|
|0    | 85.95| 84.93| 90.97| 90.17| 95.17| 95.61|   95.54|   94.25|
|5    | 72.53| 74.85| 75.33| 81.58| 82.78| 87.77|   85.46|   82.92|
|10   | 56.07| 62.19| 52.17| 69.19| 58.26| 74.22|   69.32|   62.77|
|25   | 13.98| 25.16|  4.79| 29.60|  4.08| 21.63|   13.74|    9.72|
|50   |  0.40|  2.19|  0.00|  2.08|  0.00|  0.21|    0.05|    0.01|
|100  |  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|    0.00|    0.00|
|200  |  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|    0.00|    0.00|
|300  |  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|    0.00|    0.00|
|400  |  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|    0.00|    0.00|
|500  |  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|    0.00|    0.00|
|1000 |  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|    0.00|    0.00|



### Best ranking for MC gains percentiles

Skewed $t$-distribution (sstd):  


|     0|ranking |     5|ranking |    10|ranking |    25|ranking |   50|ranking |  100|ranking |
|-----:|:-------|-----:|:-------|-----:|:-------|-----:|:-------|----:|:-------|----:|:-------|
| 92.89|vmr_phr | 84.34|mhr     | 70.44|mhr     | 29.65|phr     | 1.64|phr     | 0.04|vhr     |
| 92.77|mhr     | 82.99|vmr_phr | 68.75|phr     | 24.67|vhr     | 1.52|vhr     | 0.01|pmr     |
| 92.35|mmr     | 80.04|vhr_pmr | 66.97|vmr_phr | 20.10|mhr     | 0.21|mhr     | 0.01|phr     |
| 91.73|vhr_pmr | 79.76|phr     | 61.66|vhr_pmr | 13.41|vmr_phr | 0.14|vmr     | 0.00|vmr     |
| 90.00|pmr     | 78.86|mmr     | 61.27|vhr     | 13.20|vmr     | 0.05|vhr_pmr | 0.00|mmr     |
| 88.11|phr     | 75.97|pmr     | 55.72|mmr     |  9.13|vhr_pmr | 0.02|pmr     | 0.00|mhr     |
| 82.29|vmr     | 72.69|vhr     | 55.47|vmr     |  4.82|pmr     | 0.02|vmr_phr | 0.00|vmr_phr |
| 81.92|vhr     | 70.65|vmr     | 55.27|pmr     |  3.28|mmr     | 0.00|mmr     | 0.00|vhr_pmr |


|  200|ranking |  300|ranking |  400|ranking |  500|ranking | 1000|ranking |
|----:|:-------|----:|:-------|----:|:-------|----:|:-------|----:|:-------|
| 0.01|vhr     | 0.01|vhr     | 0.01|vhr     | 0.01|vhr     | 0.01|vhr     |
| 0.01|phr     | 0.00|vmr     | 0.00|vmr     | 0.00|vmr     | 0.00|vmr     |
| 0.00|vmr     | 0.00|pmr     | 0.00|pmr     | 0.00|pmr     | 0.00|pmr     |
| 0.00|pmr     | 0.00|phr     | 0.00|phr     | 0.00|phr     | 0.00|phr     |
| 0.00|mmr     | 0.00|mmr     | 0.00|mmr     | 0.00|mmr     | 0.00|mmr     |
| 0.00|mhr     | 0.00|mhr     | 0.00|mhr     | 0.00|mhr     | 0.00|mhr     |
| 0.00|vmr_phr | 0.00|vmr_phr | 0.00|vmr_phr | 0.00|vmr_phr | 0.00|vmr_phr |
| 0.00|vhr_pmr | 0.00|vhr_pmr | 0.00|vhr_pmr | 0.00|vhr_pmr | 0.00|vhr_pmr |


Standardized $t$-distribution (std):  


|     0|ranking |     5|ranking |    10|ranking |    25|ranking |    50|ranking |  100|ranking |
|-----:|:-------|-----:|:-------|-----:|:-------|-----:|:-------|-----:|:-------|----:|:-------|
| 99.42|mhr     | 98.21|vmr_phr | 95.63|mhr     | 72.05|mhr     | 24.55|vhr     | 1.31|vhr     |
| 99.40|vmr_phr | 98.15|mhr     | 95.25|vhr_pmr | 65.59|vhr     | 18.98|phr     | 0.50|phr     |
| 99.38|vhr_pmr | 98.12|vhr_pmr | 94.87|vmr_phr | 65.03|vhr_pmr | 14.88|mhr     | 0.28|vmr     |
| 99.36|mmr     | 98.00|mmr     | 94.76|mmr     | 64.24|vmr_phr | 10.26|vmr     | 0.17|pmr     |
| 97.67|pmr     | 94.81|pmr     | 89.06|pmr     | 64.12|phr     |  8.18|vhr_pmr | 0.12|mhr     |
| 96.56|phr     | 93.66|phr     | 88.99|phr     | 54.92|vmr     |  7.98|vmr_phr | 0.11|vhr_pmr |
| 95.79|vmr     | 92.35|vhr     | 87.80|vhr     | 54.65|mmr     |  4.50|pmr     | 0.05|mmr     |
| 95.45|vhr     | 92.09|vmr     | 86.07|vmr     | 49.09|pmr     |  2.96|mmr     | 0.04|vmr_phr |


|  200|ranking |  300|ranking |  400|ranking |  500|ranking | 1000|ranking |
|----:|:-------|----:|:-------|----:|:-------|----:|:-------|----:|:-------|
| 0.04|vhr     | 0.02|vmr     | 0.01|pmr     | 0.01|pmr     |    0|vmr     |
| 0.03|vmr     | 0.02|vhr     | 0.00|vmr     | 0.00|vmr     |    0|vhr     |
| 0.02|pmr     | 0.02|pmr     | 0.00|vhr     | 0.00|vhr     |    0|pmr     |
| 0.01|mmr     | 0.00|phr     | 0.00|phr     | 0.00|phr     |    0|phr     |
| 0.01|vhr_pmr | 0.00|mmr     | 0.00|mmr     | 0.00|mmr     |    0|mmr     |
| 0.00|phr     | 0.00|mhr     | 0.00|mhr     | 0.00|mhr     |    0|mhr     |
| 0.00|mhr     | 0.00|vmr_phr | 0.00|vmr_phr | 0.00|vmr_phr |    0|vmr_phr |
| 0.00|vmr_phr | 0.00|vhr_pmr | 0.00|vhr_pmr | 0.00|vhr_pmr |    0|vhr_pmr |


Normal distribution:  


|     0|ranking |     5|ranking |    10|ranking |    25|ranking |   50|ranking | 100|ranking |
|-----:|:-------|-----:|:-------|-----:|:-------|-----:|:-------|----:|:-------|---:|:-------|
| 95.61|mhr     | 87.77|mhr     | 74.22|mhr     | 29.60|phr     | 2.19|vhr     |   0|vmr     |
| 95.54|vmr_phr | 85.46|vmr_phr | 69.32|vmr_phr | 25.16|vhr     | 2.08|phr     |   0|vhr     |
| 95.17|mmr     | 82.92|vhr_pmr | 69.19|phr     | 21.63|mhr     | 0.40|vmr     |   0|pmr     |
| 94.25|vhr_pmr | 82.78|mmr     | 62.77|vhr_pmr | 13.98|vmr     | 0.21|mhr     |   0|phr     |
| 90.97|pmr     | 81.58|phr     | 62.19|vhr     | 13.74|vmr_phr | 0.05|vmr_phr |   0|mmr     |
| 90.17|phr     | 75.33|pmr     | 58.26|mmr     |  9.72|vhr_pmr | 0.01|vhr_pmr |   0|mhr     |
| 85.95|vmr     | 74.85|vhr     | 56.07|vmr     |  4.79|pmr     | 0.00|pmr     |   0|vmr_phr |
| 84.93|vhr     | 72.53|vmr     | 52.17|pmr     |  4.08|mmr     | 0.00|mmr     |   0|vhr_pmr |


| 200|ranking | 300|ranking | 400|ranking | 500|ranking | 1000|ranking |
|---:|:-------|---:|:-------|---:|:-------|---:|:-------|----:|:-------|
|   0|vmr     |   0|vmr     |   0|vmr     |   0|vmr     |    0|vmr     |
|   0|vhr     |   0|vhr     |   0|vhr     |   0|vhr     |    0|vhr     |
|   0|pmr     |   0|pmr     |   0|pmr     |   0|pmr     |    0|pmr     |
|   0|phr     |   0|phr     |   0|phr     |   0|phr     |    0|phr     |
|   0|mmr     |   0|mmr     |   0|mmr     |   0|mmr     |    0|mmr     |
|   0|mhr     |   0|mhr     |   0|mhr     |   0|mhr     |    0|mhr     |
|   0|vmr_phr |   0|vmr_phr |   0|vmr_phr |   0|vmr_phr |    0|vmr_phr |
|   0|vhr_pmr |   0|vhr_pmr |   0|vhr_pmr |   0|vhr_pmr |    0|vhr_pmr |






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
|m   | 0.005| 0.007| 0.005| 0.008| 0.005| 0.007|   0.007|   0.006|
|s   | 0.027| 0.034| 0.019| 0.030| 0.023| 0.031|   0.028|   0.027|
|nu  | 3.384| 3.488| 3.474| 3.959| 3.344| 3.702|   3.726|   3.369|
|xi  | 0.699| 0.708| 0.770| 0.737| 0.716| 0.714|   0.715|   0.709|
|R^2 | 0.993| 0.992| 0.994| 0.996| 0.993| 0.993|   0.994|   0.993|


Standardized $t$-distribution (std):  


|    |   vmr|   vhr|   pmr|   phr|   mmr|   mhr| vmr_phr| vhr_pmr|
|:---|-----:|-----:|-----:|-----:|-----:|-----:|-------:|-------:|
|m   | 0.013| 0.015| 0.012| 0.014| 0.012| 0.015|   0.014|   0.013|
|s   | 0.032| 0.040| 0.027| 0.035| 0.029| 0.037|   0.033|   0.033|
|nu  | 3.446| 3.510| 2.629| 4.002| 3.035| 3.780|   3.760|   3.260|
|R^2 | 0.978| 0.978| 0.962| 0.981| 0.971| 0.977|   0.978|   0.974|


Normal distribution:  


|    |   vmr|   vhr|   pmr|   phr|   mmr|   mhr| vmr_phr| vhr_pmr|
|:---|-----:|-----:|-----:|-----:|-----:|-----:|-------:|-------:|
|m   | 0.006| 0.007| 0.005| 0.008| 0.006| 0.008|   0.007|   0.006|
|s   | 0.024| 0.031| 0.017| 0.028| 0.021| 0.029|   0.026|   0.024|
|R^2 | 0.968| 0.969| 0.962| 0.973| 0.965| 0.969|   0.969|   0.966|


#### AIC and BIC  


AIC





|       |      vmr|      vhr|      pmr|      phr|      mmr|      mhr|  vmr_phr|  vhr_pmr|
|:------|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|
|sstd   | -671.412| -603.343| -768.368| -622.474| -718.914| -617.207| -647.901| -672.555|
|std    | -628.069| -561.055| -728.782| -585.156| -674.537| -574.620| -605.443| -628.239|
|normal | -646.514| -579.369| -743.179| -603.088| -692.459| -593.830| -624.670| -646.870|


BIC  




|       |      vmr|      vhr|      pmr|      phr|      mmr|      mhr|  vmr_phr|  vhr_pmr|
|:------|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|
|sstd   | -659.588| -591.520| -756.545| -610.651| -707.091| -605.384| -636.077| -660.732|
|std    | -616.246| -549.232| -716.959| -573.333| -662.714| -562.796| -593.620| -616.416|
|normal | -634.691| -567.546| -731.356| -591.265| -680.636| -582.006| -612.847| -635.046|

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
| 0.16| 0.16| 0.16| 0.13| 0.15| 0.14|    0.13|    0.17|


$n_{min}$  

What is the minimum value of $n_{\nu}$, the number of observations from a given skewed $t$-distribution, we need to achieve the same degree of convergence as with $n_g=30$ observations from a Gaussian distribution with the same mean and standard deviation?


| vmr| vhr| pmr| phr| mmr| mhr| vmr_phr| vhr_pmr|
|---:|---:|---:|---:|---:|---:|-------:|-------:|
|  58|  55|  55|  48|  58|  51|      50|      57|



#### Fit statistics ranking  


Skewed $t$-distribution (sstd):  


|     m|ranking |     s|ranking |   R^2|ranking |
|-----:|:-------|-----:|:-------|-----:|:-------|
| 0.008|phr     | 0.019|pmr     | 0.996|phr     |
| 0.007|mhr     | 0.023|mmr     | 0.994|vmr_phr |
| 0.007|vmr_phr | 0.027|vhr_pmr | 0.994|pmr     |
| 0.007|vhr     | 0.027|vmr     | 0.993|mmr     |
| 0.006|vhr_pmr | 0.028|vmr_phr | 0.993|mhr     |
| 0.005|vmr     | 0.030|phr     | 0.993|vmr     |
| 0.005|pmr     | 0.031|mhr     | 0.993|vhr_pmr |
| 0.005|mmr     | 0.034|vhr     | 0.992|vhr     |


Standardized $t$-distribution (std):  


|     m|ranking |     s|ranking |   R^2|ranking |
|-----:|:-------|-----:|:-------|-----:|:-------|
| 0.015|vhr     | 0.027|pmr     | 0.981|phr     |
| 0.015|mhr     | 0.029|mmr     | 0.978|vmr     |
| 0.014|phr     | 0.032|vmr     | 0.978|vhr     |
| 0.014|vmr_phr | 0.033|vhr_pmr | 0.978|vmr_phr |
| 0.013|vhr_pmr | 0.033|vmr_phr | 0.977|mhr     |
| 0.013|vmr     | 0.035|phr     | 0.974|vhr_pmr |
| 0.012|mmr     | 0.037|mhr     | 0.971|mmr     |
| 0.012|pmr     | 0.040|vhr     | 0.962|pmr     |

Normal distribution:  


|     m|ranking |     s|ranking |   R^2|ranking |
|-----:|:-------|-----:|:-------|-----:|:-------|
| 0.008|phr     | 0.017|pmr     | 0.973|phr     |
| 0.008|mhr     | 0.021|mmr     | 0.969|vmr_phr |
| 0.007|vhr     | 0.024|vhr_pmr | 0.969|vhr     |
| 0.007|vmr_phr | 0.024|vmr     | 0.969|mhr     |
| 0.006|vhr_pmr | 0.026|vmr_phr | 0.968|vmr     |
| 0.006|vmr     | 0.028|phr     | 0.966|vhr_pmr |
| 0.006|mmr     | 0.029|mhr     | 0.965|mmr     |
| 0.005|pmr     | 0.031|vhr     | 0.962|pmr     |



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
|mc_m    |  390.56|  546.54| 368.99|  744.90| 379.50|  649.19|  569.75|  458.13|
|mc_s    |  162.67|  310.60| 106.60|  358.90|  98.41|  230.77|  195.66|  154.95|
|mc_min  |    9.95|   47.50|  41.88|   67.17| 120.88|  157.64|  134.70|  146.99|
|mc_max  | 1962.47| 9418.03| 964.46| 3790.71| 969.20| 2350.77| 2262.60| 1819.14|
|dao_pct |    0.00|    0.00|   0.00|    0.00|   0.00|    0.00|    0.00|    0.00|
|dai_pct |    0.32|    0.32|   0.03|    0.03|   0.00|    0.00|    0.00|    0.00|


Standardized $t$-distribution (std):  




|        |      vmr|      vhr|      pmr|      phr|        mmr|       mhr|  vmr_phr|  vhr_pmr|
|:-------|--------:|--------:|--------:|--------:|----------:|---------:|--------:|--------:|
|mc_m    |  2281.79|  4769.87|  1795.80|  3664.55|    2345.79|   4253.11|  2979.65|  3285.27|
|mc_s    |  1214.65|  3240.61|  1239.38|  2099.78|   31176.36|   3565.88|  1263.15|  1921.35|
|mc_min  |   221.36|   374.70|    41.43|   193.68|     557.15|    783.35|   689.69|   499.82|
|mc_max  | 16109.79| 45965.08| 94908.01| 28483.53| 3118787.05| 295755.16| 30086.97| 59511.22|
|dao_pct |     0.00|     0.00|     0.00|     0.00|       0.00|      0.00|     0.00|     0.00|
|dai_pct |     0.00|     0.00|     0.01|     0.00|       0.00|      0.00|     0.00|     0.00|


Normal distribution:  




|        |     vmr|     vhr|     pmr|     phr|     mmr|     mhr| vmr_phr| vhr_pmr|
|:-------|-------:|-------:|-------:|-------:|-------:|-------:|-------:|-------:|
|mc_m    |  441.92|  627.78|  365.42|  789.64|  403.75|  711.18|  614.07|  498.41|
|mc_s    |  169.65|  319.17|   98.48|  362.10|   98.81|  244.56|  197.97|  164.59|
|mc_min  |   90.51|   80.75|  123.03|  120.90|  165.90|  188.76|  136.86|  160.53|
|mc_max  | 1791.46| 3370.41| 1109.65| 3404.35| 1102.37| 2538.96| 1961.78| 1606.02|
|dao_pct |    0.00|    0.00|    0.00|    0.00|    0.00|    0.00|    0.00|    0.00|
|dai_pct |    0.01|    0.01|    0.00|    0.00|    0.00|    0.00|    0.00|    0.00|


#### Ranking  


Skewed $t$-distribution (sstd):  


|   mc_m|ranking |   mc_s|ranking | mc_min|ranking |  mc_max|ranking | dao_pct|ranking | dai_pct|ranking |
|------:|:-------|------:|:-------|------:|:-------|-------:|:-------|-------:|:-------|-------:|:-------|
| 744.90|phr     |  98.41|mmr     | 157.64|mhr     | 9418.03|vhr     |       0|vmr     |    0.00|mmr     |
| 649.19|mhr     | 106.60|pmr     | 146.99|vhr_pmr | 3790.71|phr     |       0|vhr     |    0.00|mhr     |
| 569.75|vmr_phr | 154.95|vhr_pmr | 134.70|vmr_phr | 2350.77|mhr     |       0|pmr     |    0.00|vmr_phr |
| 546.54|vhr     | 162.67|vmr     | 120.88|mmr     | 2262.60|vmr_phr |       0|phr     |    0.00|vhr_pmr |
| 458.13|vhr_pmr | 195.66|vmr_phr |  67.17|phr     | 1962.47|vmr     |       0|mmr     |    0.03|pmr     |
| 390.56|vmr     | 230.77|mhr     |  47.50|vhr     | 1819.14|vhr_pmr |       0|mhr     |    0.03|phr     |
| 379.50|mmr     | 310.60|vhr     |  41.88|pmr     |  969.20|mmr     |       0|vmr_phr |    0.32|vmr     |
| 368.99|pmr     | 358.90|phr     |   9.95|vmr     |  964.46|pmr     |       0|vhr_pmr |    0.32|vhr     |


Standardized $t$-distribution (std):  


|    mc_m|ranking |     mc_s|ranking | mc_min|ranking |     mc_max|ranking | dao_pct|ranking | dai_pct|ranking |
|-------:|:-------|--------:|:-------|------:|:-------|----------:|:-------|-------:|:-------|-------:|:-------|
| 4769.87|vhr     |  1214.65|vmr     | 783.35|mhr     | 3118787.05|mmr     |       0|vmr     |    0.00|vmr     |
| 4253.11|mhr     |  1239.38|pmr     | 689.69|vmr_phr |  295755.16|mhr     |       0|vhr     |    0.00|vhr     |
| 3664.55|phr     |  1263.15|vmr_phr | 557.15|mmr     |   94908.01|pmr     |       0|pmr     |    0.00|phr     |
| 3285.27|vhr_pmr |  1921.35|vhr_pmr | 499.82|vhr_pmr |   59511.22|vhr_pmr |       0|phr     |    0.00|mmr     |
| 2979.65|vmr_phr |  2099.78|phr     | 374.70|vhr     |   45965.08|vhr     |       0|mmr     |    0.00|mhr     |
| 2345.79|mmr     |  3240.61|vhr     | 221.36|vmr     |   30086.97|vmr_phr |       0|mhr     |    0.00|vmr_phr |
| 2281.79|vmr     |  3565.88|mhr     | 193.68|phr     |   28483.53|phr     |       0|vmr_phr |    0.00|vhr_pmr |
| 1795.80|pmr     | 31176.36|mmr     |  41.43|pmr     |   16109.79|vmr     |       0|vhr_pmr |    0.01|pmr     |


Normal distribution:  


|   mc_m|ranking |   mc_s|ranking | mc_min|ranking |  mc_max|ranking | dao_pct|ranking | dai_pct|ranking |
|------:|:-------|------:|:-------|------:|:-------|-------:|:-------|-------:|:-------|-------:|:-------|
| 789.64|phr     |  98.48|pmr     | 188.76|mhr     | 3404.35|phr     |       0|vmr     |    0.00|pmr     |
| 711.18|mhr     |  98.81|mmr     | 165.90|mmr     | 3370.41|vhr     |       0|vhr     |    0.00|phr     |
| 627.78|vhr     | 164.59|vhr_pmr | 160.53|vhr_pmr | 2538.96|mhr     |       0|pmr     |    0.00|mmr     |
| 614.07|vmr_phr | 169.65|vmr     | 136.86|vmr_phr | 1961.78|vmr_phr |       0|phr     |    0.00|mhr     |
| 498.41|vhr_pmr | 197.97|vmr_phr | 123.03|pmr     | 1791.46|vmr     |       0|mmr     |    0.00|vmr_phr |
| 441.92|vmr     | 244.56|mhr     | 120.90|phr     | 1606.02|vhr_pmr |       0|mhr     |    0.00|vhr_pmr |
| 403.75|mmr     | 319.17|vhr     |  90.51|vmr     | 1109.65|pmr     |       0|vmr_phr |    0.01|vmr     |
| 365.42|pmr     | 362.10|phr     |  80.75|vhr     | 1102.37|mmr     |       0|vhr_pmr |    0.01|vhr     |



# Compare Gaussian and skewed t-distribution fits

## Gaussian fits







### Gaussian QQ plots



### Gaussian vs skewed t



Probability in percent that the smallest and largest (respectively) observed return for each fund was generated by a normal distribution:

|              |   vmr|   vhr|   pmr|   phr|   mmr|   mhr| vmr_phr| vhr_pmr|
|:-------------|-----:|-----:|-----:|-----:|-----:|-----:|-------:|-------:|
|P_norm(X_min) | 0.000| 0.000| 0.000| 0.000| 0.000| 0.000|   0.000|   0.000|
|P_norm(X_max) | 0.546| 0.580| 1.599| 0.796| 1.161| 0.746|   0.793|   0.903|
|P_t(X_min)    | 0.556| 0.523| 0.342| 0.387| 0.476| 0.443|   0.433|   0.499|
|P_t(X_max)    | 0.448| 0.469| 1.135| 0.614| 0.739| 0.518|   0.543|   0.613|

Average number of years between min or max events (respectively):

|                      |          vmr|          vhr|          pmr|          phr|          mmr|          mhr|      vmr_phr|      vhr_pmr|
|:---------------------|------------:|------------:|------------:|------------:|------------:|------------:|------------:|------------:|
|norm: avg yrs btw min | 1.157446e+77| 3.872665e+82| 3.449915e+57| 4.076881e+55| 2.913573e+67| 1.048138e+67| 2.446247e+63| 4.894371e+71|
|norm: avg yrs btw max | 1.830960e+02| 1.724260e+02| 6.252800e+01| 1.256870e+02| 8.614100e+01| 1.341240e+02| 1.261390e+02| 1.107200e+02|
|t: avg yrs btw min    | 1.798360e+02| 1.912300e+02| 2.924120e+02| 2.584920e+02| 2.099400e+02| 2.257430e+02| 2.309140e+02| 2.002190e+02|
|t: avg yrs btw max    | 2.233340e+02| 2.130540e+02| 8.811500e+01| 1.628680e+02| 1.352750e+02| 1.928930e+02| 1.843230e+02| 1.630560e+02|


#### Lilliefors test  






p-values for Lilliefors test.  
Testing $H_0$, that log-returns are Gaussian.


|        | vmr| vhr| pmr| phr| mmr|   mhr| vmr_phr| vhr_pmr|
|:-------|---:|---:|---:|---:|---:|-----:|-------:|-------:|
|p value |   0|   0|   0|   0|   0| 0.001|   0.001|       0|



#### Wittgenstein's Ruler  


For different given probabilities that returns are Gaussian, what is the probability that the distribution is Gaussian rather than skewed t-distributed, given the smallest/largest observed log-returns?

Conditional probabilities for smallest observed log-returns:

![](pension-returns_monthly_files/figure-html/unnamed-chunk-198-1.png)<!-- -->


Use $1 - \text{p-value}$ from Lilliefors test as prior probability that the distribution is Gaussian.  
$x_{\text{obs}} = \min(x)$ and $P[\text{Event}\ |\ \text{Gaussian}] = P_{\text{Gauss}}[X \leq x_{\text{min}}]$:




|                      |   vmr|  vhr|   pmr|  phr|   mmr|   mhr| vmr_phr| vhr_pmr|
|:---------------------|-----:|----:|-----:|----:|-----:|-----:|-------:|-------:|
|Lillie p-val          | 0.000| 0.00| 0.000| 0.00| 0.000| 0.001|   0.001|   0.000|
|Prior prob            | 1.000| 1.00| 1.000| 1.00| 1.000| 0.999|   0.999|   1.000|
|P[Gauss &#124; Event] | 0.838| 0.82| 0.768| 0.69| 0.815| 0.486|   0.418|   0.965|



Use $1 - \text{p-value}$ from Lilliefors test as prior probability that the distribution is Gaussian.  
$x_{\text{obs}} = \max(x)$ and $P[\text{Event}\ |\ \text{Gaussian}] = P_{\text{Gauss}}[X \geq x_{\text{max}}]$:

![](pension-returns_monthly_files/figure-html/unnamed-chunk-201-1.png)<!-- -->




|                      | vmr| vhr| pmr| phr| mmr|   mhr| vmr_phr| vhr_pmr|
|:---------------------|---:|---:|---:|---:|---:|-----:|-------:|-------:|
|Lillie p-val          |   0|   0|   0|   0|   0| 0.001|   0.001|       0|
|Prior prob            |   1|   1|   1|   1|   1| 0.999|   0.999|       1|
|P[Gauss &#124; Event] |   1|   1|   1|   1|   1| 1.000|   1.000|       1|


# Velliv medium risk (vmr), June 2012 - April 2024




## QQ Plot

Skewed $t$-distribution (sstd):  

![](pension-returns_monthly_files/figure-html/unnamed-chunk-287-1.png)<!-- -->



## Data vs fit

Let's plot the fit and the observed returns together.  

![](pension-returns_monthly_files/figure-html/unnamed-chunk-288-1.png)<!-- -->



## Estimated distribution

Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pension-returns_monthly_files/figure-html/unnamed-chunk-289-1.png)<!-- -->



## Monte Carlo



















Sorted portfolio index values for last period of all runs

![](pension-returns_monthly_files/figure-html/unnamed-chunk-294-1.png)<!-- -->


## Convergence

### Max vs sum

Max vs sum plots for the first four moments:

![](pension-returns_monthly_files/figure-html/unnamed-chunk-295-1.png)<!-- -->




### MC

![](pension-returns_monthly_files/figure-html/unnamed-chunk-296-1.png)<!-- -->


### IS

Skewed $t$-distribution with a normal proposal distribution.

![](pension-returns_monthly_files/figure-html/unnamed-chunk-297-1.png)<!-- -->

Parameters

```
## [1] 1.4145605 0.3807834
```

Objective function plots

![](pension-returns_monthly_files/figure-html/unnamed-chunk-299-1.png)<!-- -->





# Velliv high risk (vhr), June 2012 - April 2024




## QQ Plot

Skewed $t$-distribution (sstd):  

![](pension-returns_monthly_files/figure-html/unnamed-chunk-316-1.png)<!-- -->



## Data vs fit

Let's plot the fit and the observed returns together.  

![](pension-returns_monthly_files/figure-html/unnamed-chunk-317-1.png)<!-- -->



## Estimated distribution

Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pension-returns_monthly_files/figure-html/unnamed-chunk-318-1.png)<!-- -->



## Monte Carlo



















Sorted portfolio index values for last period of all runs

![](pension-returns_monthly_files/figure-html/unnamed-chunk-323-1.png)<!-- -->


## Convergence

### Max vs sum

Max vs sum plots for the first four moments:

![](pension-returns_monthly_files/figure-html/unnamed-chunk-324-1.png)<!-- -->




### MC

![](pension-returns_monthly_files/figure-html/unnamed-chunk-325-1.png)<!-- -->


### IS

Skewed $t$-distribution with a normal proposal distribution.

![](pension-returns_monthly_files/figure-html/unnamed-chunk-326-1.png)<!-- -->

Parameters

```
## [1] 1.7391222 0.4858909
```

Objective function plots

![](pension-returns_monthly_files/figure-html/unnamed-chunk-328-1.png)<!-- -->





# PFA medium risk (pmr), June 2012 - April 2024




## QQ Plot

Skewed $t$-distribution (sstd):  

![](pension-returns_monthly_files/figure-html/unnamed-chunk-345-1.png)<!-- -->



## Data vs fit

Let's plot the fit and the observed returns together.  

![](pension-returns_monthly_files/figure-html/unnamed-chunk-346-1.png)<!-- -->



## Estimated distribution

Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pension-returns_monthly_files/figure-html/unnamed-chunk-347-1.png)<!-- -->



## Monte Carlo



















Sorted portfolio index values for last period of all runs

![](pension-returns_monthly_files/figure-html/unnamed-chunk-352-1.png)<!-- -->


## Convergence

### Max vs sum

Max vs sum plots for the first four moments:

![](pension-returns_monthly_files/figure-html/unnamed-chunk-353-1.png)<!-- -->




### MC

![](pension-returns_monthly_files/figure-html/unnamed-chunk-354-1.png)<!-- -->


### IS

Skewed $t$-distribution with a normal proposal distribution.

![](pension-returns_monthly_files/figure-html/unnamed-chunk-355-1.png)<!-- -->

Parameters

```
## [1] 1.3304634 0.2764028
```

Objective function plots

![](pension-returns_monthly_files/figure-html/unnamed-chunk-357-1.png)<!-- -->





# PFA high risk (phr), June 2012 - April 2024




## QQ Plot

Skewed $t$-distribution (sstd):  

![](pension-returns_monthly_files/figure-html/unnamed-chunk-374-1.png)<!-- -->



## Data vs fit

Let's plot the fit and the observed returns together.  

![](pension-returns_monthly_files/figure-html/unnamed-chunk-375-1.png)<!-- -->



## Estimated distribution

Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pension-returns_monthly_files/figure-html/unnamed-chunk-376-1.png)<!-- -->



## Monte Carlo






phr has the sstd fit with the highest sstd fit with thevalue of nu. Compare with other distributions:





![](pension-returns_monthly_files/figure-html/unnamed-chunk-378-1.png)<!-- -->

![](pension-returns_monthly_files/figure-html/unnamed-chunk-379-1.png)<!-- -->

![](pension-returns_monthly_files/figure-html/unnamed-chunk-380-1.png)<!-- -->


Sorted portfolio index values for last period of all runs

![](pension-returns_monthly_files/figure-html/unnamed-chunk-381-1.png)<!-- -->


## Convergence

### Max vs sum

Max vs sum plots for the first four moments:

![](pension-returns_monthly_files/figure-html/unnamed-chunk-382-1.png)<!-- -->




### MC

![](pension-returns_monthly_files/figure-html/unnamed-chunk-383-1.png)<!-- -->


### IS

Skewed $t$-distribution with a normal proposal distribution.

![](pension-returns_monthly_files/figure-html/unnamed-chunk-384-1.png)<!-- -->

Parameters

```
## [1] 2.0162301 0.4463226
```

Objective function plots

![](pension-returns_monthly_files/figure-html/unnamed-chunk-386-1.png)<!-- -->





# Mix medium risk (mmr), June 2012 - April 2024




## QQ Plot

Skewed $t$-distribution (sstd):  

![](pension-returns_monthly_files/figure-html/unnamed-chunk-403-1.png)<!-- -->



## Data vs fit

Let's plot the fit and the observed returns together.  

![](pension-returns_monthly_files/figure-html/unnamed-chunk-404-1.png)<!-- -->



## Estimated distribution

Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pension-returns_monthly_files/figure-html/unnamed-chunk-405-1.png)<!-- -->



## Monte Carlo








mmr has the sstd fit with the lowest value of nu. Compare with other distributions:



![](pension-returns_monthly_files/figure-html/unnamed-chunk-407-1.png)<!-- -->

![](pension-returns_monthly_files/figure-html/unnamed-chunk-408-1.png)<!-- -->

![](pension-returns_monthly_files/figure-html/unnamed-chunk-409-1.png)<!-- -->


Sorted portfolio index values for last period of all runs

![](pension-returns_monthly_files/figure-html/unnamed-chunk-410-1.png)<!-- -->


## Convergence

### Max vs sum

Max vs sum plots for the first four moments:

![](pension-returns_monthly_files/figure-html/unnamed-chunk-411-1.png)<!-- -->




### MC

![](pension-returns_monthly_files/figure-html/unnamed-chunk-412-1.png)<!-- -->


### IS

Skewed $t$-distribution with a normal proposal distribution.

![](pension-returns_monthly_files/figure-html/unnamed-chunk-413-1.png)<!-- -->

Parameters

```
## [1] 1.3516393 0.2503782
```

Objective function plots

![](pension-returns_monthly_files/figure-html/unnamed-chunk-415-1.png)<!-- -->





# Mix high risk (mhr), June 2012 - April 2024




## QQ Plot

Skewed $t$-distribution (sstd):  

![](pension-returns_monthly_files/figure-html/unnamed-chunk-432-1.png)<!-- -->



## Data vs fit

Let's plot the fit and the observed returns together.  

![](pension-returns_monthly_files/figure-html/unnamed-chunk-433-1.png)<!-- -->



## Estimated distribution

Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pension-returns_monthly_files/figure-html/unnamed-chunk-434-1.png)<!-- -->



## Monte Carlo



















Sorted portfolio index values for last period of all runs

![](pension-returns_monthly_files/figure-html/unnamed-chunk-439-1.png)<!-- -->


## Convergence

### Max vs sum

Max vs sum plots for the first four moments:

![](pension-returns_monthly_files/figure-html/unnamed-chunk-440-1.png)<!-- -->




### MC

![](pension-returns_monthly_files/figure-html/unnamed-chunk-441-1.png)<!-- -->


### IS

Skewed $t$-distribution with a normal proposal distribution.

![](pension-returns_monthly_files/figure-html/unnamed-chunk-442-1.png)<!-- -->

Parameters

```
## [1] 1.8775189 0.3400818
```

Objective function plots

![](pension-returns_monthly_files/figure-html/unnamed-chunk-444-1.png)<!-- -->





# Mix vmr+phr (vm_ph), June 2012 - April 2024




## QQ Plot

Skewed $t$-distribution (sstd):  

![](pension-returns_monthly_files/figure-html/unnamed-chunk-461-1.png)<!-- -->



## Data vs fit

Let's plot the fit and the observed returns together.  

![](pension-returns_monthly_files/figure-html/unnamed-chunk-462-1.png)<!-- -->



## Estimated distribution

Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pension-returns_monthly_files/figure-html/unnamed-chunk-463-1.png)<!-- -->



## Monte Carlo



















Sorted portfolio index values for last period of all runs

![](pension-returns_monthly_files/figure-html/unnamed-chunk-468-1.png)<!-- -->


## Convergence

### Max vs sum

Max vs sum plots for the first four moments:

![](pension-returns_monthly_files/figure-html/unnamed-chunk-469-1.png)<!-- -->




### MC

![](pension-returns_monthly_files/figure-html/unnamed-chunk-470-1.png)<!-- -->


### IS

Skewed $t$-distribution with a normal proposal distribution.

![](pension-returns_monthly_files/figure-html/unnamed-chunk-471-1.png)<!-- -->

Parameters

```
## [1] 1.7507161 0.3263777
```

Objective function plots

![](pension-returns_monthly_files/figure-html/unnamed-chunk-473-1.png)<!-- -->





# Mix vhr+pmr (mh_pm), June 2012 - April 2024




## QQ Plot

Skewed $t$-distribution (sstd):  

![](pension-returns_monthly_files/figure-html/unnamed-chunk-490-1.png)<!-- -->



## Data vs fit

Let's plot the fit and the observed returns together.  

![](pension-returns_monthly_files/figure-html/unnamed-chunk-491-1.png)<!-- -->



## Estimated distribution

Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pension-returns_monthly_files/figure-html/unnamed-chunk-492-1.png)<!-- -->



## Monte Carlo



















Sorted portfolio index values for last period of all runs

![](pension-returns_monthly_files/figure-html/unnamed-chunk-497-1.png)<!-- -->


## Convergence

### Max vs sum

Max vs sum plots for the first four moments:

![](pension-returns_monthly_files/figure-html/unnamed-chunk-498-1.png)<!-- -->




### MC

![](pension-returns_monthly_files/figure-html/unnamed-chunk-499-1.png)<!-- -->


### IS

Skewed $t$-distribution with a normal proposal distribution.

![](pension-returns_monthly_files/figure-html/unnamed-chunk-500-1.png)<!-- -->

Parameters

```
## [1] 1.540135 0.320090
```

Objective function plots

![](pension-returns_monthly_files/figure-html/unnamed-chunk-502-1.png)<!-- -->


# Velliv medium risk (vmr), June 2012 - April 2024




## QQ Plot

Skewed $t$-distribution (sstd):  

![](pension-returns_monthly_files/figure-html/unnamed-chunk-520-1.png)<!-- -->



## Data vs fit

Let's plot the fit and the observed returns together.  

![](pension-returns_monthly_files/figure-html/unnamed-chunk-521-1.png)<!-- -->



## Estimated distribution

Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pension-returns_monthly_files/figure-html/unnamed-chunk-522-1.png)<!-- -->



## Monte Carlo



















Sorted portfolio index values for last period of all runs

![](pension-returns_monthly_files/figure-html/unnamed-chunk-527-1.png)<!-- -->


## Convergence

### Max vs sum

Max vs sum plots for the first four moments:

![](pension-returns_monthly_files/figure-html/unnamed-chunk-528-1.png)<!-- -->




### MC

![](pension-returns_monthly_files/figure-html/unnamed-chunk-529-1.png)<!-- -->


### IS

Skewed $t$-distribution with a normal proposal distribution.

![](pension-returns_monthly_files/figure-html/unnamed-chunk-530-1.png)<!-- -->

Parameters

```
## [1] 1.4145605 0.3807834
```

Objective function plots

![](pension-returns_monthly_files/figure-html/unnamed-chunk-532-1.png)<!-- -->





