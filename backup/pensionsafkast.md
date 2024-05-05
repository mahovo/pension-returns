---
title: "Pension returns analysis"
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
  # pdf_document:
  #   toc: true
  #   toc_depth: 3
#fontsize: 10pt # for pdf. Limited to 10pt, 11pt and 12pt. Else use scrextend.
params:
  run_sim: TRUE ## TRUE: Run simulations and write output. FALSE: Read saved
                ## simulations output from disk instead of running the simulations.
date: "21:38 29 April 2024"
---

















Fit log returns to F-S skew standardized Student-t distribution.  
`m`  is the location parameter.  
`s` is the scale parameter.  
`nu` is the estimated shape parameter (degrees of freedom).  
`xi` is the estimated skewness parameter.  

# Log returns data 2011-2023.  
For 2011, medium risk data is used in the high risk data set, as no high risk fund data is available prior to 2012.  
`vmrl` is a long version of Velliv medium risk data, from 2007 to 2023. For 2007 to 2011 (both included) no high risk data is available.







![](pensionsafkast_files/figure-html/unnamed-chunk-6-1.png)<!-- -->


## Summary of gross returns


```
##       vmr             vhr             pmr             phr       
##  Min.   :0.868   Min.   :0.849   Min.   :0.904   Min.   :0.878  
##  1st Qu.:1.044   1st Qu.:1.039   1st Qu.:1.042   1st Qu.:1.068  
##  Median :1.097   Median :1.099   Median :1.084   Median :1.128  
##  Mean   :1.070   Mean   :1.085   Mean   :1.065   Mean   :1.095  
##  3rd Qu.:1.136   3rd Qu.:1.160   3rd Qu.:1.107   3rd Qu.:1.182  
##  Max.   :1.168   Max.   :1.214   Max.   :1.141   Max.   :1.208  
##       mmr             mhr           vm_ph_r          vh_pm_r      
##  Min.   :0.988   Min.   :0.977   Min.   :0.9791   Min.   :0.9666  
##  1st Qu.:1.013   1st Qu.:1.013   1st Qu.:1.0213   1st Qu.:1.0115  
##  Median :1.085   Median :1.113   Median :1.1024   Median :1.0938  
##  Mean   :1.066   Mean   :1.087   Mean   :1.0807   Mean   :1.0736  
##  3rd Qu.:1.101   3rd Qu.:1.128   3rd Qu.:1.1211   3rd Qu.:1.1065  
##  Max.   :1.133   Max.   :1.207   Max.   :1.1778   Max.   :1.1630
```



```
##       vmrl      
##  Min.   :0.801  
##  1st Qu.:1.013  
##  Median :1.085  
##  Mean   :1.061  
##  3rd Qu.:1.128  
##  Max.   :1.193
```


```
##            vmr   vhr   pmr   phr   mmr   mhr vm_ph_r vh_pm_r
## Min.   : 0.868 0.849 0.904 0.878 0.988 0.977  0.9791  0.9666
## 1st Qu.: 1.044 1.039 1.042 1.068 1.013 1.013  1.0213  1.0115
## Median : 1.097 1.099 1.084 1.128 1.085 1.113  1.1024  1.0938
## Mean   : 1.070 1.085 1.065 1.095 1.066 1.087  1.0807  1.0736
## 3rd Qu.: 1.136 1.160 1.107 1.182 1.101 1.128  1.1211  1.1065
## Max.   : 1.168 1.214 1.141 1.208 1.133 1.207  1.1778  1.1630
```

## Ranking

| Min.   :|ranking | 1st Qu.:|ranking | Median :|ranking | Mean   :|ranking | 3rd Qu.:|ranking | Max.   :|ranking |
|--------:|:-------|--------:|:-------|--------:|:-------|--------:|:-------|--------:|:-------|--------:|:-------|
|    0.988|mmr     |    1.068|phr     |    1.128|phr     |    1.095|phr     |    1.182|phr     |    1.214|vhr     |
|    0.979|vm_ph_r |    1.044|vmr     |    1.113|mhr     |    1.087|mhr     |    1.160|vhr     |    1.208|phr     |
|    0.977|mhr     |    1.042|pmr     |    1.102|vm_ph_r |    1.085|vhr     |    1.136|vmr     |    1.207|mhr     |
|    0.967|vh_pm_r |    1.039|vhr     |    1.099|vhr     |    1.081|vm_ph_r |    1.128|mhr     |    1.178|vm_ph_r |
|    0.904|pmr     |    1.021|vm_ph_r |    1.097|vmr     |    1.074|vh_pm_r |    1.121|vm_ph_r |    1.168|vmr     |
|    0.878|phr     |    1.013|mmr     |    1.094|vh_pm_r |    1.070|vmr     |    1.107|pmr     |    1.163|vh_pm_r |
|    0.868|vmr     |    1.013|mhr     |    1.085|mmr     |    1.066|mmr     |    1.106|vh_pm_r |    1.141|pmr     |
|    0.849|vhr     |    1.012|vh_pm_r |    1.084|pmr     |    1.065|pmr     |    1.101|mmr     |    1.133|mmr     |

## Covariance and correlations


Covariances

```
##         vmr     vhr     pmr     phr
## vmr  0.0072  0.0087 -0.0011 -0.0008
## vhr  0.0087  0.0106 -0.0008 -0.0002
## pmr -0.0011 -0.0008  0.0043  0.0066
## phr -0.0008 -0.0002  0.0066  0.0111
```

Correlations

```
##         vmr     vhr     pmr     phr
## vmr  1.0000  0.9926 -0.1971 -0.0949
## vhr  0.9926  1.0000 -0.1186 -0.0159
## pmr -0.1971 -0.1186  1.0000  0.9569
## phr -0.0949 -0.0159  0.9569  1.0000
```
`vhr` and `phr` are clearly the least correlated.




# Velliv medium risk, 2011 - 2023

```
## 
## AIC: -27.8497 
## BIC: -25.58991 
## m: 0.0480931 
## s: 0.1198426 
## nu (df): 3.303595 
## xi: 0.03361192 
## R^2: 0.993 
## 
## An R^2 of 0.993 suggests that the fit is extremely good.
## 
## What is the risk of losing max 10 %? =< 0 percent
## What is the risk of losing max 25 %? =< 0 percent
## What is the risk of losing max 50 %? =< 0 percent
## What is the risk of losing max 90 %? =< 0 percent
## What is the risk of losing max 99 %? =< 0 percent
## 
## What is the chance of gaining min 10 %? >= 63.16667 percent
## What is the chance of gaining min 25 %? >= 49.33333 percent
## What is the chance of gaining min 50 %? >= 40.16667 percent
## What is the chance of gaining min 90 %? >= 32.66667 percent
## What is the chance of gaining min 99 %? >= 31.5 percent
```

## QQ Plot
![](pensionsafkast_files/figure-html/unnamed-chunk-14-1.png)<!-- -->

The qq plot looks great. Log returns for Velliv medium risk seems to be consistent with a skewed t-distribution.  


## Data vs fit
Let's plot the fit and the observed returns together.  

![](pensionsafkast_files/figure-html/unnamed-chunk-15-1.png)<!-- -->

## Estimated distribution
Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pensionsafkast_files/figure-html/unnamed-chunk-16-1.png)<!-- -->


![](pensionsafkast_files/figure-html/unnamed-chunk-17-1.png)<!-- -->

We see that for a few observations out of a 1000, the losses are disastrous, while the upside is very dampened.


![](pensionsafkast_files/figure-html/unnamed-chunk-18-1.png)<!-- -->


## Monte Carlo


```
## Down-and-out simulation:
## Probability of down-and-out: 0 percent
## 
## Mean portfolio index value after 20 years: 293.425 kr.
## SD of portfolio index value after 20 years: 132.773 kr.
## Min total portfolio index value after 20 years: 0.252 kr.
## Max total portfolio index value after 20 years: 894.856 kr.
## 
## Share of paths finishing below 100: 4.62 percent
```




![](pensionsafkast_files/figure-html/unnamed-chunk-21-1.png)<!-- -->


![](pensionsafkast_files/figure-html/unnamed-chunk-22-1.png)<!-- -->




## Convergence

### Max vs sum
Max vs sum plots for the first four moments:



![](pensionsafkast_files/figure-html/unnamed-chunk-24-1.png)<!-- -->




### MC

![](pensionsafkast_files/figure-html/unnamed-chunk-25-1.png)<!-- -->

### IS







Parameters

```
## [1] 1.2193865 0.3313137
```

Objective function plots

![](pensionsafkast_files/figure-html/unnamed-chunk-29-1.png)<!-- -->

![](pensionsafkast_files/figure-html/unnamed-chunk-30-1.png)<!-- -->











![](pensionsafkast_files/figure-html/unnamed-chunk-33-1.png)<!-- -->


# Velliv medium risk, 2007 - 2023

## Fit to skew t distribution

```
## 
## AIC: -34.35752 
## BIC: -31.02467 
## m: 0.05171176 
## s: 0.1149408 
## nu (df): 2.706099 
## xi: 0.5049945 
## R^2: 0.978 
## 
## An R^2 of 0.978 suggests that the fit is very good.
## 
## What is the risk of losing max 10 %? =< 0 percent
## What is the risk of losing max 25 %? =< 0 percent
## What is the risk of losing max 50 %? =< 0 percent
## What is the risk of losing max 90 %? =< 0 percent
## What is the risk of losing max 99 %? =< 0 percent
## 
## What is the chance of gaining min 10 %? >= 58.66667 percent
## What is the chance of gaining min 25 %? >= 47.5 percent
## What is the chance of gaining min 50 %? >= 40.16667 percent
## What is the chance of gaining min 90 %? >= 34 percent
## What is the chance of gaining min 99 %? >= 33 percent
```


## QQ Plot

![](pensionsafkast_files/figure-html/unnamed-chunk-35-1.png)<!-- -->

The qq plot looks good. Log returns for Velliv high risk seems to be consistent with a skewed t-distribution.  


## Data vs fit
Let's plot the fit and the observed returns together.  

![](pensionsafkast_files/figure-html/unnamed-chunk-36-1.png)<!-- -->


## Estimated distribution
Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pensionsafkast_files/figure-html/unnamed-chunk-37-1.png)<!-- -->

![](pensionsafkast_files/figure-html/unnamed-chunk-38-1.png)<!-- -->

We see that for a few observations out of a 1000, the losses are disastrous, while the upside is very dampened. But because the disastrous loss in 2008 was followed by a large profit the following year, we see some increased upside for the top percentiles. Beware: A 1.2 return following a 0.8 return doesn't take us back where we were before the loss. Path dependency! So if returns more or less average out, but high returns have a tendency to follow high losses, that's bad!


![](pensionsafkast_files/figure-html/unnamed-chunk-39-1.png)<!-- -->


## Monte Carlo


```
## Down-and-out simulation:
## Probability of down-and-out: 0 percent
## 
## Mean portfolio index value after 20 years: 310.724 kr.
## SD of portfolio index value after 20 years: 127.38 kr.
## Min total portfolio index value after 20 years: 0.109 kr.
## Max total portfolio index value after 20 years: 1524.063 kr.
## 
## Share of paths finishing below 100: 2.64 percent
```





![](pensionsafkast_files/figure-html/unnamed-chunk-42-1.png)<!-- -->



![](pensionsafkast_files/figure-html/unnamed-chunk-43-1.png)<!-- -->


## Convergence

### Max vs sum
Max vs sum plots for the first four moments:




![](pensionsafkast_files/figure-html/unnamed-chunk-45-1.png)<!-- -->


### MC
![](pensionsafkast_files/figure-html/unnamed-chunk-46-1.png)<!-- -->

### IS






Parameters

```
## [1] 1.2367098 0.3352537
```

Objective function plots

![](pensionsafkast_files/figure-html/unnamed-chunk-50-1.png)<!-- -->

![](pensionsafkast_files/figure-html/unnamed-chunk-51-1.png)<!-- -->











![](pensionsafkast_files/figure-html/unnamed-chunk-54-1.png)<!-- -->



# Velliv high risk, 2011 - 2023

## Fit to skew t distribution

```
## 
## AIC: -21.42488 
## BIC: -19.16508 
## m: 0.06471454 
## s: 0.1499924 
## nu (df): 3.144355 
## xi: 0.002367034 
## R^2: 0.991 
## 
## An R^2 of 0.991 suggests that the fit is extremely good.
## 
## What is the risk of losing max 10 %? =< 0 percent
## What is the risk of losing max 25 %? =< 0 percent
## What is the risk of losing max 50 %? =< 0 percent
## What is the risk of losing max 90 %? =< 0 percent
## What is the risk of losing max 99 %? =< 0 percent
## 
## What is the chance of gaining min 10 %? >= 64.66667 percent
## What is the chance of gaining min 25 %? >= 47.83333 percent
## What is the chance of gaining min 50 %? >= 36.83333 percent
## What is the chance of gaining min 90 %? >= 28 percent
## What is the chance of gaining min 99 %? >= 26.5 percent
```


## QQ Plot
![](pensionsafkast_files/figure-html/unnamed-chunk-56-1.png)<!-- -->

The qq plot looks great. Returns for Velliv medium risk seems to be consistent with a skewed t-distribution.  

## Data vs fit
Let's plot the fit and the observed returns together.  

![](pensionsafkast_files/figure-html/unnamed-chunk-57-1.png)<!-- -->

## Estimated distribution
Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pensionsafkast_files/figure-html/unnamed-chunk-58-1.png)<!-- -->

![](pensionsafkast_files/figure-html/unnamed-chunk-59-1.png)<!-- -->

We see that for a few observations out of a 1000, the losses are disastrous, while the upside is very dampened.


![](pensionsafkast_files/figure-html/unnamed-chunk-60-1.png)<!-- -->


## Monte Carlo


```
## Down-and-out simulation:
## Probability of down-and-out: 0.02 percent
## 
## Mean portfolio index value after 20 years: 436.492 kr.
## SD of portfolio index value after 20 years: 238.769 kr.
## Min total portfolio index value after 20 years: 0.01 kr.
## Max total portfolio index value after 20 years: 1662.793 kr.
## 
## Share of paths finishing below 100: 3.99 percent
```





![](pensionsafkast_files/figure-html/unnamed-chunk-63-1.png)<!-- -->



![](pensionsafkast_files/figure-html/unnamed-chunk-64-1.png)<!-- -->


## Convergence

### Max vs sum
Max vs sum plots for the first four moments:




![](pensionsafkast_files/figure-html/unnamed-chunk-66-1.png)<!-- -->


### MC

![](pensionsafkast_files/figure-html/unnamed-chunk-67-1.png)<!-- -->

### IS






Parameters

```
## [1] 1.595924 0.432716
```

Objective function plots

![](pensionsafkast_files/figure-html/unnamed-chunk-71-1.png)<!-- -->

![](pensionsafkast_files/figure-html/unnamed-chunk-72-1.png)<!-- -->











![](pensionsafkast_files/figure-html/unnamed-chunk-75-1.png)<!-- -->


# PFA medium risk, 2011 - 2023

## Fit to skew t distribution

```
## 
## AIC: -33.22998 
## BIC: -30.97018 
## m: 0.05789224 
## s: 0.1234592 
## nu (df): 2.265273 
## xi: 0.477324 
## R^2: 0.991 
## 
## An R^2 of 0.991 suggests that the fit is extremely good.
## 
## What is the risk of losing max 10 %? =< 0 percent
## What is the risk of losing max 25 %? =< 0 percent
## What is the risk of losing max 50 %? =< 0 percent
## What is the risk of losing max 90 %? =< 0 percent
## What is the risk of losing max 99 %? =< 0 percent
## 
## What is the chance of gaining min 10 %? >= 52.83333 percent
## What is the chance of gaining min 25 %? >= 44 percent
## What is the chance of gaining min 50 %? >= 38.83333 percent
## What is the chance of gaining min 90 %? >= 34.66667 percent
## What is the chance of gaining min 99 %? >= 34 percent
```


## QQ Plot
![](pensionsafkast_files/figure-html/unnamed-chunk-77-1.png)<!-- -->

The qq plot looks great. Log returns for PFA medium risk seems to be consistent with a skewed t-distribution.  



```
##  [1] -0.091256521 -0.003731241  0.027312079  0.045808232  0.059068633
##  [6]  0.069575113  0.078454727  0.086316936  0.093536451  0.100370932
## [11]  0.107018607  0.114081432  0.127604387
```


## Data vs fit
Let's plot the fit and the observed returns together.  

![](pensionsafkast_files/figure-html/unnamed-chunk-79-1.png)<!-- -->

## Estimated distribution
Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pensionsafkast_files/figure-html/unnamed-chunk-80-1.png)<!-- -->

![](pensionsafkast_files/figure-html/unnamed-chunk-81-1.png)<!-- -->

We see that for a few observations out of a 1000, the losses are disastrous. While there is some uptick at the top percentiles, the curve basically flattens out.


![](pensionsafkast_files/figure-html/unnamed-chunk-82-1.png)<!-- -->


## Monte Carlo


```
## Down-and-out simulation:
## Probability of down-and-out: 0.01 percent
## 
## Mean portfolio index value after 20 years: 559.196 kr.
## SD of portfolio index value after 20 years: 21464.17 kr.
## Min total portfolio index value after 20 years: 0.01 kr.
## Max total portfolio index value after 20 years: 2146730 kr.
## 
## Share of paths finishing below 100: 1.91 percent
```





![](pensionsafkast_files/figure-html/unnamed-chunk-85-1.png)<!-- -->



![](pensionsafkast_files/figure-html/unnamed-chunk-86-1.png)<!-- -->


## Convergence

### Max vs sum

Max vs sum plots for the first four moments:




![](pensionsafkast_files/figure-html/unnamed-chunk-88-1.png)<!-- -->


### MC

![](pensionsafkast_files/figure-html/unnamed-chunk-89-1.png)<!-- -->

### IS






Parameters

```
## [1] 1.2963050 0.3073762
```

Objective function plots

![](pensionsafkast_files/figure-html/unnamed-chunk-93-1.png)<!-- -->

![](pensionsafkast_files/figure-html/unnamed-chunk-94-1.png)<!-- -->











![](pensionsafkast_files/figure-html/unnamed-chunk-97-1.png)<!-- -->



# PFA high risk, 2011 - 2023

## Fit to skew t distribution

```
## 
## AIC: -23.72565 
## BIC: -21.46585 
## m: 0.08386034 
## s: 0.1210107 
## nu (df): 3.184569 
## xi: 0.01790306 
## R^2: 0.964 
## 
## An R^2 of 0.964 suggests that the fit is very good.
## 
## What is the risk of losing max 10 %? =< 0 percent
## What is the risk of losing max 25 %? =< 0 percent
## What is the risk of losing max 50 %? =< 0 percent
## What is the risk of losing max 90 %? =< 0 percent
## What is the risk of losing max 99 %? =< 0 percent
## 
## What is the chance of gaining min 10 %? >= 56.83333 percent
## What is the chance of gaining min 25 %? >= 43.16667 percent
## What is the chance of gaining min 50 %? >= 34.16667 percent
## What is the chance of gaining min 90 %? >= 26.83333 percent
## What is the chance of gaining min 99 %? >= 25.66667 percent
```


## QQ Plot
![](pensionsafkast_files/figure-html/unnamed-chunk-99-1.png)<!-- -->

The qq plot looks ok. Returns for PFA high risk seems to be consistent with a skewed t-distribution.  

## Data vs fit
Let's plot the fit and the observed returns together.  

![](pensionsafkast_files/figure-html/unnamed-chunk-100-1.png)<!-- -->

## Estimated distribution
Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pensionsafkast_files/figure-html/unnamed-chunk-101-1.png)<!-- -->

![](pensionsafkast_files/figure-html/unnamed-chunk-102-1.png)<!-- -->

We see that for a few observations out of a 1000, the losses are disastrous, while the upside is very dampened.


![](pensionsafkast_files/figure-html/unnamed-chunk-103-1.png)<!-- -->



## Monte Carlo


```
## Down-and-out simulation:
## Probability of down-and-out: 0 percent
## 
## Mean portfolio index value after 20 years: 604.475 kr.
## SD of portfolio index value after 20 years: 272.576 kr.
## Min total portfolio index value after 20 years: 0.723 kr.
## Max total portfolio index value after 20 years: 2041.095 kr.
## 
## Share of paths finishing below 100: 0.73 percent
```





![](pensionsafkast_files/figure-html/unnamed-chunk-106-1.png)<!-- -->



![](pensionsafkast_files/figure-html/unnamed-chunk-107-1.png)<!-- -->


## Convergence

### Max vs sum

Max vs sum plots for the first four moments:




![](pensionsafkast_files/figure-html/unnamed-chunk-109-1.png)<!-- -->


### MC

![](pensionsafkast_files/figure-html/unnamed-chunk-110-1.png)<!-- -->


### IS






Parameters

```
## [1] 1.8378581 0.4367791
```

Objective function plots

![](pensionsafkast_files/figure-html/unnamed-chunk-114-1.png)<!-- -->

![](pensionsafkast_files/figure-html/unnamed-chunk-115-1.png)<!-- -->










![](pensionsafkast_files/figure-html/unnamed-chunk-118-1.png)<!-- -->



# Mix medium risk, 2011 - 2023

## Fit to skew t distribution

```
## 
## AIC: -36.9603 
## BIC: -34.7005 
## m: 0.05902873 
## s: 0.08757749 
## nu (df): 2.772621 
## xi: 0.02904471 
## R^2: 0.89 
## 
## An R^2 of 0.89 suggests that the fit is not completely random.
## 
## What is the risk of losing max 10 %? =< 0 percent
## What is the risk of losing max 25 %? =< 0 percent
## What is the risk of losing max 50 %? =< 0 percent
## What is the risk of losing max 90 %? =< 0 percent
## What is the risk of losing max 99 %? =< 0 percent
## 
## What is the chance of gaining min 10 %? >= 53.16667 percent
## What is the chance of gaining min 25 %? >= 44.16667 percent
## What is the chance of gaining min 50 %? >= 38.66667 percent
## What is the chance of gaining min 90 %? >= 34.16667 percent
## What is the chance of gaining min 99 %? >= 33.5 percent
```


## QQ Plot
![](pensionsafkast_files/figure-html/unnamed-chunk-120-1.png)<!-- -->

The fit suggests big losses for the lowest percentiles, which are not present in the data.  
So the fit is actually a very cautious estimate.


## Data vs fit
Let's plot the fit and the observed returns together.  

![](pensionsafkast_files/figure-html/unnamed-chunk-121-1.png)<!-- -->

Interestingly, the fit predicts a much bigger "biggest loss" than the actual data. This is the main reason that R^2 is 0.90 and not higher.


## Estimated distribution
Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pensionsafkast_files/figure-html/unnamed-chunk-122-1.png)<!-- -->

![](pensionsafkast_files/figure-html/unnamed-chunk-123-1.png)<!-- -->

We see that for a few observations out of a 1000, the losses are disastrous, while the upside is very dampened.

![](pensionsafkast_files/figure-html/unnamed-chunk-124-1.png)<!-- -->



## Monte Carlo

### Version a: Simulation from estimated distribution of returns of mix.  

```
## Down-and-out simulation:
## Probability of down-and-out: 0 percent
## 
## Mean portfolio index value after 20 years: 345.465 kr.
## SD of portfolio index value after 20 years: 107.65 kr.
## Min total portfolio index value after 20 years: 2.259 kr.
## Max total portfolio index value after 20 years: 768.499 kr.
## 
## Share of paths finishing below 100: 1.04 percent
```





![](pensionsafkast_files/figure-html/unnamed-chunk-127-1.png)<!-- -->



![](pensionsafkast_files/figure-html/unnamed-chunk-128-1.png)<!-- -->




### Version b: Mix of simulations from estimated distribution of returns from individual funds.



```
## Down-and-out simulation:
## Probability of down-and-out: 0 percent
## 
## Mean portfolio index value after 20 years: 320.163 kr.
## SD of portfolio index value after 20 years: 90.704 kr.
## Min total portfolio index value after 20 years: 31.566 kr.
## Max total portfolio index value after 20 years: 1996.779 kr.
## 
## Share of paths finishing below 100: 0.3 percent
```





![](pensionsafkast_files/figure-html/unnamed-chunk-132-1.png)<!-- -->


![](pensionsafkast_files/figure-html/unnamed-chunk-133-1.png)<!-- -->


## Convergence

### Max vs sum

Max vs sum plots for the first four moments:




![](pensionsafkast_files/figure-html/unnamed-chunk-135-1.png)<!-- -->


### MC

![](pensionsafkast_files/figure-html/unnamed-chunk-136-1.png)<!-- -->

### IS







Parameters

```
## [1] 1.1990016 0.2668179
```

Objective function plots

![](pensionsafkast_files/figure-html/unnamed-chunk-140-1.png)<!-- -->

![](pensionsafkast_files/figure-html/unnamed-chunk-141-1.png)<!-- -->











![](pensionsafkast_files/figure-html/unnamed-chunk-144-1.png)<!-- -->



# Mix high risk, 2011 - 2023

## Fit to skew t distribution

```
## 
## AIC: -24.26084 
## BIC: -22.00104 
## m: 0.0822419 
## s: 0.07129843 
## nu (df): 89.86289 
## xi: 0.7697502 
## R^2: 0.961 
## 
## An R^2 of 0.961 suggests that the fit is very good.
## 
## What is the risk of losing max 10 %? =< 0 percent
## What is the risk of losing max 25 %? =< 0 percent
## What is the risk of losing max 50 %? =< 0 percent
## What is the risk of losing max 90 %? =< 0 percent
## What is the risk of losing max 99 %? =< 0 percent
## 
## What is the chance of gaining min 10 %? >= 52.5 percent
## What is the chance of gaining min 25 %? >= 45 percent
## What is the chance of gaining min 50 %? >= 38.33333 percent
## What is the chance of gaining min 90 %? >= 31.16667 percent
## What is the chance of gaining min 99 %? >= 29.83333 percent
```


## QQ Plot
![](pensionsafkast_files/figure-html/unnamed-chunk-146-1.png)<!-- -->

The qq plot looks good Returns for mixed medium risk portfolios seems to be consistent with a skewed t-distribution.  


## Data vs fit
Let's plot the fit and the observed returns together.  

![](pensionsafkast_files/figure-html/unnamed-chunk-147-1.png)<!-- -->

## Estimated distribution
Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pensionsafkast_files/figure-html/unnamed-chunk-148-1.png)<!-- -->

![](pensionsafkast_files/figure-html/unnamed-chunk-149-1.png)<!-- -->

We see that the high risk mix provides a much better upside and smaller downside.

![](pensionsafkast_files/figure-html/unnamed-chunk-150-1.png)<!-- -->




## Monte Carlo

### Version a: Simulation from estimated distribution of returns of mix.  

```
## Down-and-out simulation:
## Probability of down-and-out: 0 percent
## 
## Mean portfolio index value after 20 years: 545.492 kr.
## SD of portfolio index value after 20 years: 177.236 kr.
## Min total portfolio index value after 20 years: 142.716 kr.
## Max total portfolio index value after 20 years: 1730.752 kr.
## 
## Share of paths finishing below 100: 0 percent
```





![](pensionsafkast_files/figure-html/unnamed-chunk-153-1.png)<!-- -->



![](pensionsafkast_files/figure-html/unnamed-chunk-154-1.png)<!-- -->




### Version b: Mix of simulations from estimated distribution of returns from individual funds.


```
## Down-and-out simulation:
## Probability of down-and-out: 0 percent
## 
## Mean portfolio index value after 20 years: 519.12 kr.
## SD of portfolio index value after 20 years: 180.741 kr.
## Min total portfolio index value after 20 years: 50.466 kr.
## Max total portfolio index value after 20 years: 1424.783 kr.
## 
## Share of paths finishing below 100: 0.1 percent
```





![](pensionsafkast_files/figure-html/unnamed-chunk-158-1.png)<!-- -->


![](pensionsafkast_files/figure-html/unnamed-chunk-159-1.png)<!-- -->


#### Many simulations



1e6 paths:


```r
# Down-and-out simulation:
# Probability of down-and-out: 0 percent
# 
# Mean portfolio index value after 20 years: 478.339 kr.
# SD of portfolio index value after 20 years: 163.093 kr.
# Min total portfolio index value after 20 years: 2.233 kr.
# Max total portfolio index value after 20 years: 1561.965 kr.
# 
# Share of paths finishing below 100: 0.1181 percent
```



## Convergence

### Max vs sum
Max vs sum plots for the first four moments:




![](pensionsafkast_files/figure-html/unnamed-chunk-163-1.png)<!-- -->


### MC

![](pensionsafkast_files/figure-html/unnamed-chunk-164-1.png)<!-- -->

### IS






Parameters

```
## [1] 1.6704437 0.3454847
```

Objective function plots

![](pensionsafkast_files/figure-html/unnamed-chunk-168-1.png)<!-- -->

![](pensionsafkast_files/figure-html/unnamed-chunk-169-1.png)<!-- -->










![](pensionsafkast_files/figure-html/unnamed-chunk-172-1.png)<!-- -->


# Mix vmr+phr, 2011 - 2023

Log-returns for mix of Velliv medium risk (vm) and PFA high risk (ph):


## Fit to skew t distribution


```
## 
## AIC: -29.6509 
## BIC: -27.3911 
## m: 0.0668553 
## s: 0.09147987 
## nu (df): 4.659549 
## xi: 0.04824493 
## R^2: 0.927 
## 
## An R^2 of 0.927 suggests that the fit is good.
## 
## What is the risk of losing max 10 %? =< 0 percent
## What is the risk of losing max 25 %? =< 0 percent
## What is the risk of losing max 50 %? =< 0 percent
## What is the risk of losing max 90 %? =< 0 percent
## What is the risk of losing max 99 %? =< 0 percent
## 
## What is the chance of gaining min 10 %? >= 57.66667 percent
## What is the chance of gaining min 25 %? >= 46.33333 percent
## What is the chance of gaining min 50 %? >= 38 percent
## What is the chance of gaining min 90 %? >= 31 percent
## What is the chance of gaining min 99 %? >= 29.83333 percent
```


## QQ Plot
![](pensionsafkast_files/figure-html/unnamed-chunk-174-1.png)<!-- -->



## Data vs fit
Let's plot the fit and the observed returns together.  

![](pensionsafkast_files/figure-html/unnamed-chunk-175-1.png)<!-- -->




## Estimated distribution
Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pensionsafkast_files/figure-html/unnamed-chunk-176-1.png)<!-- -->

![](pensionsafkast_files/figure-html/unnamed-chunk-177-1.png)<!-- -->



![](pensionsafkast_files/figure-html/unnamed-chunk-178-1.png)<!-- -->



## Monte Carlo



### Mix of simulations from estimated distribution of returns from individual funds.



```
## Down-and-out simulation:
## Probability of down-and-out: 0 percent
## 
## Mean portfolio index value after 20 years: 447.961 kr.
## SD of portfolio index value after 20 years: 149.962 kr.
## Min total portfolio index value after 20 years: 50.946 kr.
## Max total portfolio index value after 20 years: 1151.679 kr.
## 
## Share of paths finishing below 100: 0.16 percent
```





![](pensionsafkast_files/figure-html/unnamed-chunk-181-1.png)<!-- -->


![](pensionsafkast_files/figure-html/unnamed-chunk-182-1.png)<!-- -->


## Convergence

### Max vs sum

Max vs sum plots for the first four moments:




![](pensionsafkast_files/figure-html/unnamed-chunk-184-1.png)<!-- -->


### MC

![](pensionsafkast_files/figure-html/unnamed-chunk-185-1.png)<!-- -->

### IS






Parameters

```
## [1] 1.526841 0.326815
```

Objective function plots

![](pensionsafkast_files/figure-html/unnamed-chunk-189-1.png)<!-- -->

![](pensionsafkast_files/figure-html/unnamed-chunk-190-1.png)<!-- -->










![](pensionsafkast_files/figure-html/unnamed-chunk-193-1.png)<!-- -->



# Mix vhr+pmr, 2011 - 2023

Log-returns for mix of Velliv high risk (vh) and PFA medium risk (pm):


## Fit to skew t distribution


```
## 
## AIC: -31.1004 
## BIC: -28.84061 
## m: 0.06249566 
## s: 0.0898826 
## nu (df): 3.89221 
## xi: 0.01893003 
## R^2: 0.933 
## 
## An R^2 of 0.933 suggests that the fit is good.
## 
## What is the risk of losing max 10 %? =< 0 percent
## What is the risk of losing max 25 %? =< 0 percent
## What is the risk of losing max 50 %? =< 0 percent
## What is the risk of losing max 90 %? =< 0 percent
## What is the risk of losing max 99 %? =< 0 percent
## 
## What is the chance of gaining min 10 %? >= 57 percent
## What is the chance of gaining min 25 %? >= 46 percent
## What is the chance of gaining min 50 %? >= 38.5 percent
## What is the chance of gaining min 90 %? >= 32.16667 percent
## What is the chance of gaining min 99 %? >= 31.16667 percent
```


## QQ Plot
![](pensionsafkast_files/figure-html/unnamed-chunk-195-1.png)<!-- -->




## Data vs fit
Let's plot the fit and the observed returns together.  

![](pensionsafkast_files/figure-html/unnamed-chunk-196-1.png)<!-- -->



## Estimated distribution
Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pensionsafkast_files/figure-html/unnamed-chunk-197-1.png)<!-- -->

![](pensionsafkast_files/figure-html/unnamed-chunk-198-1.png)<!-- -->


![](pensionsafkast_files/figure-html/unnamed-chunk-199-1.png)<!-- -->



## Monte Carlo



### Mix of simulations from estimated distribution of returns from individual funds.



```
## Down-and-out simulation:
## Probability of down-and-out: 0 percent
## 
## Mean portfolio index value after 20 years: 390.328 kr.
## SD of portfolio index value after 20 years: 137.046 kr.
## Min total portfolio index value after 20 years: 43.655 kr.
## Max total portfolio index value after 20 years: 3747.968 kr.
## 
## Share of paths finishing below 100: 0.24 percent
```





![](pensionsafkast_files/figure-html/unnamed-chunk-202-1.png)<!-- -->


![](pensionsafkast_files/figure-html/unnamed-chunk-203-1.png)<!-- -->


## Convergence

### Max vs sum

Max vs sum plots for the first four moments:




![](pensionsafkast_files/figure-html/unnamed-chunk-205-1.png)<!-- -->


### MC

![](pensionsafkast_files/figure-html/unnamed-chunk-206-1.png)<!-- -->

### IS






Parameters

```
## [1] 1.3976614 0.3233002
```

Objective function plots

![](pensionsafkast_files/figure-html/unnamed-chunk-210-1.png)<!-- -->

![](pensionsafkast_files/figure-html/unnamed-chunk-211-1.png)<!-- -->










![](pensionsafkast_files/figure-html/unnamed-chunk-214-1.png)<!-- -->



# Compare pension plans

## Risk of max loss
Risk of max loss of x percent for a single period (year).  
x values are row names.  




|   |  Vel_m| Vel_ml|  Vel_h|  PFA_m|  PFA_h|  mix_m|  mix_h|  vm_ph|  vh_pm|
|:--|------:|------:|------:|------:|------:|------:|------:|------:|------:|
|0  | 21.167| 17.833| 19.667| 11.833| 14.000| 12.333| 12.667| 16.667| 16.000|
|5  | 12.167|  9.333| 12.500|  5.667|  8.333|  5.833|  3.833|  8.667|  8.167|
|10 |  7.000|  5.000|  8.000|  3.000|  5.000|  2.833|  0.500|  4.333|  4.167|
|25 |  1.333|  0.833|  2.167|  0.500|  1.000|  0.333|  0.000|  0.333|  0.333|
|50 |  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|
|90 |  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|
|99 |  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|


### Worst ranking for loss percentiles


|      0|ranking |      5|ranking |    10|ranking |    25|ranking | 50|ranking | 90|ranking | 99|ranking |
|------:|:-------|------:|:-------|-----:|:-------|-----:|:-------|--:|:-------|--:|:-------|--:|:-------|
| 21.167|Vel_m   | 12.500|Vel_h   | 8.000|Vel_h   | 2.167|Vel_h   |  0|Vel_m   |  0|Vel_m   |  0|Vel_m   |
| 19.667|Vel_h   | 12.167|Vel_m   | 7.000|Vel_m   | 1.333|Vel_m   |  0|Vel_ml  |  0|Vel_ml  |  0|Vel_ml  |
| 17.833|Vel_ml  |  9.333|Vel_ml  | 5.000|Vel_ml  | 1.000|PFA_h   |  0|Vel_h   |  0|Vel_h   |  0|Vel_h   |
| 16.667|vm_ph   |  8.667|vm_ph   | 5.000|PFA_h   | 0.833|Vel_ml  |  0|PFA_m   |  0|PFA_m   |  0|PFA_m   |
| 16.000|vh_pm   |  8.333|PFA_h   | 4.333|vm_ph   | 0.500|PFA_m   |  0|PFA_h   |  0|PFA_h   |  0|PFA_h   |
| 14.000|PFA_h   |  8.167|vh_pm   | 4.167|vh_pm   | 0.333|mix_m   |  0|mix_m   |  0|mix_m   |  0|mix_m   |
| 12.667|mix_h   |  5.833|mix_m   | 3.000|PFA_m   | 0.333|vm_ph   |  0|mix_h   |  0|mix_h   |  0|mix_h   |
| 12.333|mix_m   |  5.667|PFA_m   | 2.833|mix_m   | 0.333|vh_pm   |  0|vm_ph   |  0|vm_ph   |  0|vm_ph   |
| 11.833|PFA_m   |  3.833|mix_h   | 0.500|mix_h   | 0.000|mix_h   |  0|vh_pm   |  0|vh_pm   |  0|vh_pm   |



## Chance of min gains
Chance of min gains of x percent for a single period (year).  
x values are row names.





|    | Velliv_m| Velliv_m_l| Velliv_h|  PFA_m|  PFA_h|  mix_m|  mix_h|  vm_ph|  vh_pm|
|:---|--------:|----------:|--------:|------:|------:|------:|------:|------:|------:|
|0   |   78.833|     82.167|   80.333| 88.167| 86.000| 87.667| 87.333| 83.333| 84.000|
|5   |   63.833|     65.000|   69.333| 71.667| 76.000| 71.667| 70.167| 69.333| 69.000|
|10  |   40.833|     36.000|   53.333| 32.500| 59.667| 35.500| 46.000| 47.167| 43.833|
|25  |    0.000|      0.000|    0.000|  0.000|  0.000|  0.000|  0.833|  0.000|  0.000|
|50  |    0.000|      0.000|    0.000|  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|
|100 |    0.000|      0.000|    0.000|  0.000|  0.000|  0.000|  0.000|  0.000|  0.000|

### Best ranking for gains percentiles


|      0|ranking    |      5|ranking    |     10|ranking    |    25|ranking    | 50|ranking    | 100|ranking    |
|------:|:----------|------:|:----------|------:|:----------|-----:|:----------|--:|:----------|---:|:----------|
| 88.167|PFA_m      | 76.000|PFA_h      | 59.667|PFA_h      | 0.833|mix_h      |  0|Velliv_m   |   0|Velliv_m   |
| 87.667|mix_m      | 71.667|PFA_m      | 53.333|Velliv_h   | 0.000|Velliv_m   |  0|Velliv_m_l |   0|Velliv_m_l |
| 87.333|mix_h      | 71.667|mix_m      | 47.167|vm_ph      | 0.000|Velliv_m_l |  0|Velliv_h   |   0|Velliv_h   |
| 86.000|PFA_h      | 70.167|mix_h      | 46.000|mix_h      | 0.000|Velliv_h   |  0|PFA_m      |   0|PFA_m      |
| 84.000|vh_pm      | 69.333|Velliv_h   | 43.833|vh_pm      | 0.000|PFA_m      |  0|PFA_h      |   0|PFA_h      |
| 83.333|vm_ph      | 69.333|vm_ph      | 40.833|Velliv_m   | 0.000|PFA_h      |  0|mix_m      |   0|mix_m      |
| 82.167|Velliv_m_l | 69.000|vh_pm      | 36.000|Velliv_m_l | 0.000|mix_m      |  0|mix_h      |   0|mix_h      |
| 80.333|Velliv_h   | 65.000|Velliv_m_l | 35.500|mix_m      | 0.000|vm_ph      |  0|vm_ph      |   0|vm_ph      |
| 78.833|Velliv_m   | 63.833|Velliv_m   | 32.500|PFA_m      | 0.000|vh_pm      |  0|vh_pm      |   0|vh_pm      |




## MC risk percentiles

Risk of loss from first to last period.  

`_m` is medium.  
`_h`  is high.  

`a` is simulation from estimated distribution of returns of mix.  
`b` is mix of simulations from estimated distribution of returns from individual 
funds.

`l` for "long", going back to 2007.




|   | Vel_m| Vel_ml| Vel_h| PFA_m| PFA_h| mix_ma| mix_ha| mix_mb| mix_hb| vm_ph| vh_pm|
|:--|-----:|------:|-----:|-----:|-----:|------:|------:|------:|------:|-----:|-----:|
|0  |  4.95|   2.89|  4.17|  1.95|  0.82|   1.11|      0|   0.32|   0.10|  0.18|  0.28|
|5  |  4.34|   2.48|  3.75|  1.82|  0.71|   0.99|      0|   0.26|   0.08|  0.12|  0.19|
|10 |  3.80|   2.16|  3.34|  1.67|  0.67|   0.86|      0|   0.24|   0.07|  0.11|  0.18|
|25 |  2.47|   1.48|  2.37|  1.17|  0.48|   0.55|      0|   0.07|   0.03|  0.04|  0.09|
|50 |  0.95|   0.62|  1.08|  0.56|  0.24|   0.21|      0|   0.01|   0.02|  0.00|  0.02|
|90 |  0.04|   0.06|  0.08|  0.15|  0.02|   0.04|      0|   0.00|   0.00|  0.00|  0.00|
|99 |  0.01|   0.02|  0.02|  0.06|  0.01|   0.00|      0|   0.00|   0.00|  0.00|  0.00|


1e6 simulation paths of `mhr_b`:






|         |     0|     5|    10|    25|    50| 90| 99|
|:--------|-----:|-----:|-----:|-----:|-----:|--:|--:|
|prob_pct | 0.118| 0.095| 0.076| 0.036| 0.008|  0|  0|


### Worst ranking for MC loss percentiles


|    0|ranking |    5|ranking |   10|ranking |   25|ranking |   50|ranking |   90|ranking |   99|ranking |
|----:|:-------|----:|:-------|----:|:-------|----:|:-------|----:|:-------|----:|:-------|----:|:-------|
| 4.95|Vel_m   | 4.34|Vel_m   | 3.80|Vel_m   | 2.47|Vel_m   | 1.08|Vel_h   | 0.15|PFA_m   | 0.06|PFA_m   |
| 4.17|Vel_h   | 3.75|Vel_h   | 3.34|Vel_h   | 2.37|Vel_h   | 0.95|Vel_m   | 0.08|Vel_h   | 0.02|Vel_ml  |
| 2.89|Vel_ml  | 2.48|Vel_ml  | 2.16|Vel_ml  | 1.48|Vel_ml  | 0.62|Vel_ml  | 0.06|Vel_ml  | 0.02|Vel_h   |
| 1.95|PFA_m   | 1.82|PFA_m   | 1.67|PFA_m   | 1.17|PFA_m   | 0.56|PFA_m   | 0.04|Vel_m   | 0.01|Vel_m   |
| 1.11|mix_ma  | 0.99|mix_ma  | 0.86|mix_ma  | 0.55|mix_ma  | 0.24|PFA_h   | 0.04|mix_ma  | 0.01|PFA_h   |
| 0.82|PFA_h   | 0.71|PFA_h   | 0.67|PFA_h   | 0.48|PFA_h   | 0.21|mix_ma  | 0.02|PFA_h   | 0.00|mix_ma  |
| 0.32|mix_mb  | 0.26|mix_mb  | 0.24|mix_mb  | 0.09|vh_pm   | 0.02|mix_hb  | 0.00|mix_ha  | 0.00|mix_ha  |
| 0.28|vh_pm   | 0.19|vh_pm   | 0.18|vh_pm   | 0.07|mix_mb  | 0.02|vh_pm   | 0.00|mix_mb  | 0.00|mix_mb  |
| 0.18|vm_ph   | 0.12|vm_ph   | 0.11|vm_ph   | 0.04|vm_ph   | 0.01|mix_mb  | 0.00|mix_hb  | 0.00|mix_hb  |
| 0.10|mix_hb  | 0.08|mix_hb  | 0.07|mix_hb  | 0.03|mix_hb  | 0.00|mix_ha  | 0.00|vm_ph   | 0.00|vm_ph   |
| 0.00|mix_ha  | 0.00|mix_ha  | 0.00|mix_ha  | 0.00|mix_ha  | 0.00|vm_ph   | 0.00|vh_pm   | 0.00|vh_pm   |





## MC gains percentiles

Chance of gains from first to last period.  
`_a` is simulation from estimated distribution of returns of mix.  
`_b` is mix of simulations from estimated distribution of returns from individual 
funds.




|     | Vel_m| Vel_ml| Vel_h| PFA_m| PFA_h| mix_ma| mix_ha| mix_mb| mix_hb| vm_ph| vh_pm|
|:----|-----:|------:|-----:|-----:|-----:|------:|------:|------:|------:|-----:|-----:|
|0    | 95.05|  97.11| 95.83| 98.05| 99.18|  98.89| 100.00|  99.68|  99.90| 99.82| 99.72|
|5    | 94.31|  96.69| 95.40| 97.89| 99.08|  98.70| 100.00|  99.64|  99.86| 99.78| 99.68|
|10   | 93.47|  96.24| 94.95| 97.66| 98.92|  98.47| 100.00|  99.55|  99.80| 99.72| 99.62|
|25   | 91.01|  94.47| 93.46| 96.83| 98.59|  97.79| 100.00|  99.08|  99.62| 99.56| 99.30|
|50   | 85.79|  90.51| 90.59| 94.79| 97.66|  96.11|  99.99|  97.70|  99.33| 99.00| 98.36|
|100  | 71.79|  78.71| 83.25| 88.35| 94.78|  90.17|  99.68|  89.91|  97.39| 96.13| 93.80|
|200  | 39.49|  44.18| 65.33| 59.73| 85.79|  59.98|  93.09|  48.93|  86.77| 79.55| 67.91|
|300  | 15.71|  17.44| 45.13| 22.39| 71.81|  22.13|  71.60|  11.68|  65.80| 51.65| 34.81|
|400  |  5.07|   4.93| 29.01|  4.32| 54.54|   3.91|  44.58|   1.33|  42.14| 24.74| 13.33|
|500  |  1.23|   1.07| 17.58|  0.54| 38.04|   0.16|  23.53|   0.11|  21.80|  9.12|  4.01|
|1000 |  0.00|   0.02|  0.70|  0.02|  2.30|   0.00|   0.29|   0.01|   0.06|  0.00|  0.01|


1e6 simulation paths of `mhr_b`: 






|     |      0|      5|     10|     25|     50|    100|    200|    300|    400|    500|  1000|
|:----|------:|------:|------:|------:|------:|------:|------:|------:|------:|------:|-----:|
|prob | 99.882| 99.854| 99.824| 99.686| 99.301| 97.513| 86.912| 65.992| 41.486| 21.693| 0.086|


### Best ranking for MC gains percentiles


|      0|ranking |      5|ranking |     10|ranking |     25|ranking |    50|ranking |   100|ranking |
|------:|:-------|------:|:-------|------:|:-------|------:|:-------|-----:|:-------|-----:|:-------|
| 100.00|mix_ha  | 100.00|mix_ha  | 100.00|mix_ha  | 100.00|mix_ha  | 99.99|mix_ha  | 99.68|mix_ha  |
|  99.90|mix_hb  |  99.86|mix_hb  |  99.80|mix_hb  |  99.62|mix_hb  | 99.33|mix_hb  | 97.39|mix_hb  |
|  99.82|vm_ph   |  99.78|vm_ph   |  99.72|vm_ph   |  99.56|vm_ph   | 99.00|vm_ph   | 96.13|vm_ph   |
|  99.72|vh_pm   |  99.68|vh_pm   |  99.62|vh_pm   |  99.30|vh_pm   | 98.36|vh_pm   | 94.78|PFA_h   |
|  99.68|mix_mb  |  99.64|mix_mb  |  99.55|mix_mb  |  99.08|mix_mb  | 97.70|mix_mb  | 93.80|vh_pm   |
|  99.18|PFA_h   |  99.08|PFA_h   |  98.92|PFA_h   |  98.59|PFA_h   | 97.66|PFA_h   | 90.17|mix_ma  |
|  98.89|mix_ma  |  98.70|mix_ma  |  98.47|mix_ma  |  97.79|mix_ma  | 96.11|mix_ma  | 89.91|mix_mb  |
|  98.05|PFA_m   |  97.89|PFA_m   |  97.66|PFA_m   |  96.83|PFA_m   | 94.79|PFA_m   | 88.35|PFA_m   |
|  97.11|Vel_ml  |  96.69|Vel_ml  |  96.24|Vel_ml  |  94.47|Vel_ml  | 90.59|Vel_h   | 83.25|Vel_h   |
|  95.83|Vel_h   |  95.40|Vel_h   |  94.95|Vel_h   |  93.46|Vel_h   | 90.51|Vel_ml  | 78.71|Vel_ml  |
|  95.05|Vel_m   |  94.31|Vel_m   |  93.47|Vel_m   |  91.01|Vel_m   | 85.79|Vel_m   | 71.79|Vel_m   |


|   200|ranking |   300|ranking |   400|ranking |   500|ranking | 1000|ranking |
|-----:|:-------|-----:|:-------|-----:|:-------|-----:|:-------|----:|:-------|
| 93.09|mix_ha  | 71.81|PFA_h   | 54.54|PFA_h   | 38.04|PFA_h   | 2.30|PFA_h   |
| 86.77|mix_hb  | 71.60|mix_ha  | 44.58|mix_ha  | 23.53|mix_ha  | 0.70|Vel_h   |
| 85.79|PFA_h   | 65.80|mix_hb  | 42.14|mix_hb  | 21.80|mix_hb  | 0.29|mix_ha  |
| 79.55|vm_ph   | 51.65|vm_ph   | 29.01|Vel_h   | 17.58|Vel_h   | 0.06|mix_hb  |
| 67.91|vh_pm   | 45.13|Vel_h   | 24.74|vm_ph   |  9.12|vm_ph   | 0.02|Vel_ml  |
| 65.33|Vel_h   | 34.81|vh_pm   | 13.33|vh_pm   |  4.01|vh_pm   | 0.02|PFA_m   |
| 59.98|mix_ma  | 22.39|PFA_m   |  5.07|Vel_m   |  1.23|Vel_m   | 0.01|mix_mb  |
| 59.73|PFA_m   | 22.13|mix_ma  |  4.93|Vel_ml  |  1.07|Vel_ml  | 0.01|vh_pm   |
| 48.93|mix_mb  | 17.44|Vel_ml  |  4.32|PFA_m   |  0.54|PFA_m   | 0.00|Vel_m   |
| 44.18|Vel_ml  | 15.71|Vel_m   |  3.91|mix_ma  |  0.16|mix_ma  | 0.00|mix_ma  |
| 39.49|Vel_m   | 11.68|mix_mb  |  1.33|mix_mb  |  0.11|mix_mb  | 0.00|vm_ph   |


## Summary statistics  

### Fit summary
Summary for fit of log returns to an F-S skew standardized Student-t distribution.  
`m`  is the location parameter.  
`s` is the scale parameter.  
`nu` is the estimated degrees of freedom, or shape parameter.  
`xi` is the estimated skewness parameter.  




|    | Vel_m| Vel_ml| Vel_h| PFA_m| PFA_h| mix_m|  mix_h| vm_ph| vh_pm|
|:---|-----:|------:|-----:|-----:|-----:|-----:|------:|-----:|-----:|
|m   | 0.048|  0.052| 0.065| 0.058| 0.084| 0.059|  0.082| 0.067| 0.062|
|s   | 0.120|  0.115| 0.150| 0.123| 0.121| 0.088|  0.071| 0.091| 0.090|
|nu  | 3.304|  2.706| 3.144| 2.265| 3.185| 2.773| 89.863| 4.660| 3.892|
|xi  | 0.034|  0.505| 0.002| 0.477| 0.018| 0.029|  0.770| 0.048| 0.019|
|R^2 | 0.993|  0.978| 0.991| 0.991| 0.964| 0.890|  0.961| 0.927| 0.933|

#### Fit statistics ranking


|     m|ranking |     s|ranking |   R^2|ranking |
|-----:|:-------|-----:|:-------|-----:|:-------|
| 0.084|PFA_h   | 0.071|mix_h   | 0.993|Vel_m   |
| 0.082|mix_h   | 0.088|mix_m   | 0.991|Vel_h   |
| 0.067|vm_ph   | 0.090|vh_pm   | 0.991|PFA_m   |
| 0.065|Vel_h   | 0.091|vm_ph   | 0.978|Vel_ml  |
| 0.062|vh_pm   | 0.115|Vel_ml  | 0.964|PFA_h   |
| 0.059|mix_m   | 0.120|Vel_m   | 0.961|mix_h   |
| 0.058|PFA_m   | 0.121|PFA_h   | 0.933|vh_pm   |
| 0.052|Vel_ml  | 0.123|PFA_m   | 0.927|vm_ph   |
| 0.048|Vel_m   | 0.150|Vel_h   | 0.890|mix_m   |



### Monte Carlo simulations summary

Monte Carlo simulations of portfolio index values (currency values).  
Statistics are given for the final state of all paths.  
Probability of down-and_out is calculated as the share of paths that reach 0 at
some point. All subsequent values for a path are set to 0, if the path reaches
at any point.  
0 is defined as any value below a threshold.    
`dai_pct` (for down-and-in) is the probability of losing money. This is calculated as the 
share of paths finishing below index 100.  


```
## Number of paths: 10000
```






|        |  Vel_m|  Vel_ml|   Vel_h|      PFA_m|   PFA_h| mix_ma|  mix_mb|  mix_ha|  mix_hb|   vm_ph|   vh_pm|
|:-------|------:|-------:|-------:|----------:|-------:|------:|-------:|-------:|-------:|-------:|-------:|
|mc_m    | 293.43|  310.72|  436.49|     559.20|  604.48| 345.46|  320.16|  545.49|  519.12|  447.96|  390.33|
|mc_s    | 132.77|  127.38|  238.77|   21464.17|  272.58| 107.65|   90.70|  177.24|  180.74|  149.96|  137.05|
|mc_min  |   0.25|    0.11|    0.01|       0.01|    0.72|   2.26|   31.57|  142.72|   50.47|   50.95|   43.65|
|mc_max  | 894.86| 1524.06| 1662.79| 2146730.28| 2041.09| 768.50| 1996.78| 1730.75| 1424.78| 1151.68| 3747.97|
|dao_pct |   0.00|    0.00|    0.02|       0.01|    0.00|   0.00|    0.00|    0.00|    0.00|    0.00|    0.00|
|dai_pct |   4.62|    2.64|    3.99|       1.91|    0.73|   1.04|    0.30|    0.00|    0.10|    0.16|    0.24|


#### Ranking


|   mc_m|ranking |     mc_s|ranking | mc_min|ranking |     mc_max|ranking | dao_pct|ranking | dai_pct|ranking |
|------:|:-------|--------:|:-------|------:|:-------|----------:|:-------|-------:|:-------|-------:|:-------|
| 604.48|PFA_h   |    90.70|mix_mb  | 142.72|mix_ha  | 2146730.28|PFA_m   |    0.00|Vel_m   |    0.00|mix_ha  |
| 559.20|PFA_m   |   107.65|mix_ma  |  50.95|vm_ph   |    3747.97|vh_pm   |    0.00|Vel_ml  |    0.10|mix_hb  |
| 545.49|mix_ha  |   127.38|Vel_ml  |  50.47|mix_hb  |    2041.09|PFA_h   |    0.00|PFA_h   |    0.16|vm_ph   |
| 519.12|mix_hb  |   132.77|Vel_m   |  43.65|vh_pm   |    1996.78|mix_mb  |    0.00|mix_ma  |    0.24|vh_pm   |
| 447.96|vm_ph   |   137.05|vh_pm   |  31.57|mix_mb  |    1730.75|mix_ha  |    0.00|mix_mb  |    0.30|mix_mb  |
| 436.49|Vel_h   |   149.96|vm_ph   |   2.26|mix_ma  |    1662.79|Vel_h   |    0.00|mix_ha  |    0.73|PFA_h   |
| 390.33|vh_pm   |   177.24|mix_ha  |   0.72|PFA_h   |    1524.06|Vel_ml  |    0.00|mix_hb  |    1.04|mix_ma  |
| 345.46|mix_ma  |   180.74|mix_hb  |   0.25|Vel_m   |    1424.78|mix_hb  |    0.00|vm_ph   |    1.91|PFA_m   |
| 320.16|mix_mb  |   238.77|Vel_h   |   0.11|Vel_ml  |    1151.68|vm_ph   |    0.00|vh_pm   |    2.64|Vel_ml  |
| 310.72|Vel_ml  |   272.58|PFA_h   |   0.01|Vel_h   |     894.86|Vel_m   |    0.01|PFA_m   |    3.99|Vel_h   |
| 293.43|Vel_m   | 21464.17|PFA_m   |   0.01|PFA_m   |     768.50|mix_ma  |    0.02|Vel_h   |    4.62|Vel_m   |

# Compare Gaussian and skewed t-distribution fits

## Gaussian fits




|   |   vmr|   vhr|   pmr|   phr|   mmr|   mhr| vm_ph_r| vh_pm_r|
|:--|-----:|-----:|-----:|-----:|-----:|-----:|-------:|-------:|
|m  | 0.064| 0.077| 0.061| 0.085| 0.062| 0.081|   0.076|   0.069|
|s  | 0.081| 0.099| 0.063| 0.101| 0.048| 0.070|   0.062|   0.060|


![](pensionsafkast_files/figure-html/unnamed-chunk-244-1.png)<!-- -->

### Gaussian QQ plots

![](pensionsafkast_files/figure-html/unnamed-chunk-245-1.png)<!-- -->

### Gaussian vs skewed t



Probability in percent that the smallest and largest (respectively) observed return for each fund was generated by a normal distribution:

|              |    vmr|    vhr|    pmr|    phr|    mmr|   mhr| vm_ph_r| vh_pm_r|
|:-------------|------:|------:|------:|------:|------:|-----:|-------:|-------:|
|P_norm(X_min) |  0.571|  0.758|  0.511|  1.676|  5.971| 6.842|   5.945|   4.228|
|P_norm(X_max) | 13.230| 11.876| 12.922| 15.359|  9.628| 6.429|   7.796|   8.592|
|P_t(X_min)    |  5.377|  5.457|  3.489|  4.315| 10.570| 8.015|  13.008|  10.520|
|P_t(X_max)    |  0.118|  0.001|  2.825|  0.188|  0.488| 5.141|   0.229|   0.175|

Average number of years between min or max events (respectively):

|                      |     vmr|        vhr|     pmr|     phr|     mmr|    mhr| vm_ph_r| vh_pm_r|
|:---------------------|-------:|----------:|-------:|-------:|-------:|------:|-------:|-------:|
|norm: avg yrs btw min | 175.248|    131.911| 195.568|  59.669|  16.748| 14.616|  16.820|  23.650|
|norm: avg yrs btw max |   7.559|      8.420|   7.739|   6.511|  10.386| 15.556|  12.827|  11.639|
|t: avg yrs btw min    |  18.596|     18.324|  28.663|  23.173|   9.461| 12.476|   7.688|   9.506|
|t: avg yrs btw max    | 848.548| 178349.076|  35.400| 531.552| 205.104| 19.450| 437.280| 572.483|


# Comments

(Ignoring `mhr_a`...)

`mhr` has some nice properties:  
- It has a relatively high `nu` value of 90, which means it is tending more towards exponential tails than polynomial tails. All other funds have `nu` values close to 3, except `phr` which is even worse at close to 2. (Note that for a Gaussian, `nu` is infinite.)  
- It has the lowest losing percentage of all simulations, which is better than 1/6 that of `phr`.  
- It has a DAO percentage of 0, which is the same as `mmr`, and less than `phr`.  
- Only `phr` has a higher `mc_m`.  
- It has a smaller `mc_s` than the individual components, `vhr` and `phr`.  
- It has the highest `xi` of all fits, suggesting less left skewness. Density plots for `vmr`, `phr` and `mmr` have an extremely sharp drop, as if an upward limiter has been applied, which corresponds to extremely low `xi` values. The density plot for `mhr` is by far the most symmetrical of all the fits. As seen in the section "Compare Gaussian and skewed t-distribution fits", the other skewed t-distribution fits don't capture the max observed returns at all.    
- Only `mmr` has as higher `mc_min`. However, that of `mmr` is 18 times higher with 62, so `mmr` is a clear winner here.  
- Naturally, it has a `mc_max` smaller than the individual components, `vhr` and `phr`, but ca. 1.5 times higher then `mmr`.  
- All the first 4 moments converge nicely. For all other fits, the 4th moment doesn't seem to converge.  


Taleb, Statistical Consequences Of Fat Tails, p. 97:  
"the variance of a finite variance random variable with tail exponent $< 4$ will be infinite".

And p. 363:  
"The hedging errors for an option portfolio (under a daily revision regime) over 3000 days, un- der a constant volatility Student T with tail exponent $\alpha = 3$. Technically the errors should not converge in finite time as their distribution has infinite variance."

- Importance Sampling seems to converge to a lower level than Monte Carlo does. Is that because IS catches more observations in the lower tail? Supporting this thesis is that MC for `mhr` with `1e4` paths gives a mean of 520, while `1e6` paths gives a mean of 478 (see under "Many simulations").  
- Note: QQ lines by design pass through 1st and 3rd quantiles. They are not trendlines in the sense of linear regression.  




# Appendix
## Average of returns vs returns of average

### Math

$$\text{Avg. of returns} := \dfrac{ \left(\dfrac{x_t}{x_{t-1}} + \dfrac{y_t}{y_{t-1}} \right) }{2}$$
$$\text{Returns of avg.} := \left(\dfrac{ x_t + y_t }{2}\right) \Big/ \left(\dfrac{ x_{t-1} + y_{t-1} }{2}\right) \equiv \dfrac{ x_t + y_t }{ x_{t-1} + y_{t-1}}$$

For which $x_1$ and $y_1$ are $\text{Avg. of returns} = \text{Returns of avg.}$?

$$\dfrac{ \left(\dfrac{x_t}{x_{t-1}} + \dfrac{y_t}{y_{t-1}} \right) }{2} = \dfrac{ x_t + y_t }{ x_{t-1} + y_{t-1}}$$

$$\dfrac{x_t}{x_{t-1}} + \dfrac{y_t}{y_{t-1}} = 2 \dfrac{ x_t + y_t }{ x_{t-1} + y_{t-1}}$$

$$(x_{t-1} + y_{t-1}) x_t y_{t-1} + (x_{t-1} + y_{t-1}) x_{t-1} y_t = 2 (x_{t-1}y_{t-1}x_t + x_{t-1}y_{t-1}y_t)$$


$$(x_{t-1}x_1y_{t-1} + y_{t-1}x_ty_{t-1}) + (x_{t-1}x_{t-1}y_t + x_{t-1}y_{t-1}y_t) = 2(x_{t-1}y_{t-1}x_t + x_{t-1}y_{t-1}y_t)$$
This is not generally true, but true if for instance $x_{t-1} = y_{t-1}$.




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
Test if a simulation of a mix (average) of two returns series has the same distribution as a mix of two simulated returns series.





```
## m(data_x): -0.008375401 
## s(data_x): 0.4184349 
## m(data_y): 9.445322 
## s(data_y): 2.665942 
## 
## m(data_x + data_y): 4.718473 
## s(data_x + data_y): 1.429784
```

m and s of final state of all paths.  
`_a` is mix of simulated returns.  
`_b` is simulated mixed returns.  


|    m_a|    m_b|   s_a|   s_b|
|------:|------:|-----:|-----:|
| 94.308| 94.032| 5.930| 6.447|
| 94.046| 94.419| 6.020| 6.583|
| 94.537| 94.423| 6.064| 6.567|
| 94.585| 94.491| 6.202| 6.386|
| 94.470| 94.184| 6.192| 6.242|
| 94.480| 94.510| 6.141| 6.366|
| 94.484| 94.503| 5.843| 6.303|
| 94.501| 94.179| 5.840| 6.397|
| 94.314| 94.193| 5.941| 6.350|
| 94.222| 94.482| 6.180| 6.661|


```
##       m_a             m_b             s_a             s_b       
##  Min.   :94.05   Min.   :94.03   Min.   :5.840   Min.   :6.242  
##  1st Qu.:94.31   1st Qu.:94.19   1st Qu.:5.933   1st Qu.:6.354  
##  Median :94.48   Median :94.42   Median :6.042   Median :6.391  
##  Mean   :94.39   Mean   :94.34   Mean   :6.035   Mean   :6.430  
##  3rd Qu.:94.50   3rd Qu.:94.49   3rd Qu.:6.170   3rd Qu.:6.537  
##  Max.   :94.59   Max.   :94.51   Max.   :6.202   Max.   :6.661
```

`_a` and `_b` are very close to equal.  
We attribute the differences to differences in estimating the distributions in 
version a and b.  


The final state is independent of the order of the preceding steps:  

![](pensionsafkast_files/figure-html/unnamed-chunk-261-1.png)<!-- -->


So does the order of the steps in the two processes matter, when mixing simulated returns?  

![](pensionsafkast_files/figure-html/unnamed-chunk-262-1.png)<!-- -->

![](pensionsafkast_files/figure-html/unnamed-chunk-263-1.png)<!-- -->

The order of steps in the individual paths do not matter, because the mix of simulated paths is a sum of a sum, so the order of terms doesn't affect the sum. If there is variation it is because the sets preceding steps are not the same. For instance, the steps between step 1 and 60 in the plot above are not the same for the two lines.

Recall,
$$\text{Var}(aX+bY) = a^2 \text{Var}(X) + b^2 \text{Var}(Y) + 2ab \text{Cov}(a, b)$$


```r
var(0.5 * vhr + 0.5 * phr)
```

```
## [1] 0.005355618
```

```r
0.5^2 * var(vhr) + 0.5^2 * var(phr) + 2 * 0.5 * 0.5 * cov(vhr, phr)
```

```
## [1] 0.005355618
```


Our distribution estimate is based on 13 observations. Is that enough for a robust estimate?
What if we suddenly hit a year like 2008? How would that affect our estimate?  
Let's try to include the Velliv data from 2007-2010.  
We do this by sampling 13 observations from `vmrl`.  


```
##        m                 s          
##  Min.   :0.05940   Min.   :0.04936  
##  1st Qu.:0.06631   1st Qu.:0.05986  
##  Median :0.07033   Median :0.06726  
##  Mean   :0.07071   Mean   :0.06858  
##  3rd Qu.:0.07282   3rd Qu.:0.07670  
##  Max.   :0.08455   Max.   :0.09120
```


## The meaning of `xi`

The fit for `mhr` has the highest `xi` value of all. This suggests right-skew:

![](pensionsafkast_files/figure-html/unnamed-chunk-266-1.png)<!-- -->


## Max vs sum plot


If the Law Of Large Numbers holds true,
$$\dfrac{\max (X_1^p, ..., X^p)}{\sum_{i=1}^n X_i^p} \rightarrow 0$$
for $n \rightarrow \infty$.

If not, $X$ doesn't have a $p$'th moment.

See Taleb: The Statistical Consequences Of Fat Tails, p. 192





