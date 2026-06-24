---
title: "Monthly pension returns analysis: \nVelliv June 2012 - April 2024"
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
  run_individual: TRUE ## Include individual reports?
  run_comparison: TRUE ## Include comparison report? Depends on run_individual.
  run_mc_plot: TRUE ## Depends on run_individual.
  run_is_sim: TRUE
  run_is_plot: TRUE
  include_long: TRUE
date: "06:42 24 June 2026"
---































# Summary

A comparison of returns from pension plans provided by PFA and Velliv respectively:  
- Velliv medium risk (vmr), June 2012 - April 2024  
- Velliv high risk (vhr), June 2012 - April 2024  
- PFA medium risk (pmr), June 2012 - April 2024  
- PFA high risk (phr), June 2012 - April 2024  

The combinations of low and high risk funds for each PFA plan can be found here:  
https://www.pfa.dk/privat/opsparing/aktivsammensaetning/

The Velliv website only provides a list of funds.  

The analysis also looks at these mixes of plans:  
- Mix medium risk (mmr), June 2012 - April 2024  
- Mix high risk (mhr), June 2012 - April 2024  
- Mix vmr+phr (vm_ph), June 2012 - April 2024  
- Mix vhr+pmr (mh_pm), June 2012 - April 2024





We observe that
1. **The four plans are weighted blends of the same two underlying funds.** A principal
component analysis gives a first component that explains 97.7% of the variance and loads
almost equally on all four plans. Within each provider the high-risk plan is a scalar multiple
of the medium-risk plan in log returns (slope 1.26 for Velliv, 1.60 for PFA, intercept near
zero, $R^2$ of 0.99 and 0.96). PFA's product description confirms the structure: profiles B
and D are fixed blends of the same low- and high-risk funds. The first decision within a
provider is how much of one factor to hold, not which portfolio.

2. **"Risk" is leverage on that factor.** The high-risk plan amplifies the common factor in
both directions, earning a higher average return and drawing down more (worst peak-to-trough
$-17\%$ vs $-15\%$ for Velliv, $-16\%$ vs $-12\%$ for PFA). That the high-risk path never dips
below the medium-risk path is an artefact of starting at the 2012 low; rebased to the eve of
the COVID drawdown it falls below for about nine months. The reward-to-risk ratio is
near-constant along the menu, so there is no better blend to find: Velliv is a near-perfect
leverage ray, and PFA's slight curvature is well inside sampling noise.

3. **The data fix the body of the distribution but not its tail.** Location and scale are
estimated precisely; the tail index is not, with a 95% interval reaching from below 2 to above
5, so we cannot even settle whether the variance is finite. The left skew is the one tail
feature that is established ($\hat\xi\approx0.70$, interval entirely below symmetry). The
departure from a Gaussian is real and in the tail: Anderson-Darling rejects both the normal
and the symmetric-t in favour of the skewed-t, and the worst observed month would recur about
once every 400,000 years under a Gaussian against once every two centuries under the
skewed-t.

4. **The simulated wealth distribution is the core result, and the choice of distribution
governs it.** Simulated over twenty years, the established skewed-t implies roughly a 30%
chance that a Velliv plan finishes below its starting value, against 1% to 2% under a
symmetric-t or normal. The wealth distribution is right-skewed and bounded below at zero even
though the log-return distribution is left-skewed and unbounded. The benign single-regime
sample is more likely to understate than overstate the tail, and a mandatory pension cannot
"stay home", so we take the heavy left skew at face value.

The Findings at the end develop these points.

# Returns data

The returns data for PFA can be seen here:  
https://www.pfa.dk/privat/opsparing/pfa-afkast/  

The data for Velliv can be seen here:  
https://www.velliv.dk/opsparing/vaekstpension/vaekstpension-aktiv/afkast  

Fit log returns to F-S skew standardized Student-t distribution.  
`m`  is the location parameter.  
`s` is the scale parameter.  
`nu` is the estimated shape parameter (degrees of freedom).  
`xi` is the estimated skewness parameter.  

The long version of Velliv medium risk data runs from January 2007 to April 2024 (incl).  
For January 2007 to May 2012 no low risk and high risk funds existed. For this period the medium risk data is copied into the other funds.  

The short version runs from June 2012 to April 2024.

Velliv returns are including bonus and "DinKapital.  
PFA returns are including "KundeKapital".  




























![](pension-returns_monthly_files/figure-html/unnamed-chunk-12-1.png)<!-- -->

![](pension-returns_monthly_files/figure-html/unnamed-chunk-13-1.png)<!-- -->




![](pension-returns_monthly_files/figure-html/unnamed-chunk-14-1.png)<!-- -->


![](pension-returns_monthly_files/figure-html/unnamed-chunk-15-1.png)<!-- -->




![](pension-returns_monthly_files/figure-html/unnamed-chunk-16-1.png)<!-- -->

![](pension-returns_monthly_files/figure-html/unnamed-chunk-17-1.png)<!-- -->

![](pension-returns_monthly_files/figure-html/unnamed-chunk-18-1.png)<!-- -->


































































































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





## Path crossing and the starting point

In the "Velliv and PFA monthly prices" plot above every plan starts at index 100 in June 2012, and the riskier plans' paths never fall below the less-risky ones. It is tempting to read this as *more risk always pays*. It could look like the different risk plans for each provider are simply different weighted shares of returns from a single portfolio. What is actually going on here?

The observation does not generalise: It is an artefact of **where the index starts**. Each high-risk plan is, in effect, a leveraged exposure to one common return factor. The high-risk profile is, to a good approximation, a *scaled* version of the medium-risk one -- a slope above 1, essentially zero intercept, and a high $R^2$:

```
## Velliv  corr(medium, high) = 0.997 ;  high = 1.2627 + -0.00 * medium ,  R^2 = 0.994
```

```
## PFA     corr(medium, high) = 0.977 ;  high = -0.0002 + 1.60 * medium ,  R^2 = 0.955
```

"Approximately" matters: The $R^2$ is below 1, and that residual is where the paths separate. The profiles are not one stream scaled, but blends of two genuinely different funds -- a low-risk and a high-risk building block. Backing PFA's two funds out of the medium and high profiles (high fund $H = D$, low fund $L = 2B - D$, exact for simple returns):

```
## PFA building blocks (simple returns): corr(low fund, high fund) = 0.59 ; volatility ratio high/low = 3.1
```

The two underlying funds are only moderately correlated and differ several-fold in volatility -- far from interchangeable -- even though the *profiles* built from them are nearly collinear. That collinearity is not surprising: It is what two equity-dominated portfolios must produce. A "low-risk *plan*" is not a low-risk *fund*. Taking PFA's published 2026 strategic allocation (this is after a structural change in 2024) as an example, even the low-risk plan is roughly 76% equity-like (global, emerging, private equity, real estate) and only ~24% bonds. To see how little bond content it takes, treat a plan as a weight $w$ in equities and $(1-w)$ in bonds and ask which $w$ reproduces a given correlation with a 100%-equity plan (illustrative capital-market assumptions, not estimated from the data):


|equity vol |bond vol |equity weight for corr 0.986 |equity weight for corr 0.84 |
|:----------|:--------|:----------------------------|:---------------------------|
|15%        |4%       |61%                          |29%                         |
|12%        |5%       |71%                          |39%                         |
|18%        |4%       |57%                          |26%                         |

An equity weight of only about two-thirds already yields a ~0.986 correlation with a pure-equity plan. The observed correlations are therefore unremarkable -- exactly what equity-heavy "low-risk" plans produce -- and not evidence of anything hidden.  
  
The implication for the choice is the point of this section. High correlation means the plans rise and fall together, so over a benign, rising sample the higher-risk plan simply ends up higher and the choice looks free. But correlation describes co-movement, not magnitude and not the tails. The lower-risk plan holds a real bond sleeve and a distinct, lower-volatility fund, and -- as the crossings above show -- that cushion is exactly what bites in a drawdown. The plans look alike because both are mostly equities; they are not alike when equities fall.  
  
### One common factor

The correlations point to a single common factor. A principal component analysis of the four
plans confirms it.


Table: Principal components of the four plans' monthly log returns (correlation scaling).

|    | variance share| cumulative|
|:---|--------------:|----------:|
|PC1 |          97.7%|      97.7%|
|PC2 |           1.7%|      99.4%|
|PC3 |           0.6%|     100.0%|
|PC4 |           0.0%|     100.0%|

The first component explains 97.7% of the variance and the first two explain 99.4%. The first
component loads almost equally on all four plans, near 0.50 each, so it is a common market
factor. The second component, under two percent, is a Velliv-versus-PFA contrast. To a close
approximation the four plans are therefore one factor seen at four exposures, which is the
structure the leverage reading below assumes. The within-provider relation is the special
case of this: the high plan is a scaled version of the medium plan, as the regression above
shows. PFA's two profiles are in addition fixed blends of the same two building blocks, with
the high-risk fund equal to profile D and the low-risk fund recovered as $2B-D$. That last
decomposition rests on PFA's stated profile weights, not on the data, which only confirm that
the recovered low-risk fund is coherent.

### The crossing condition

For each plan $X\in\{m,h\}$ (medium, high) and period $u=1,2,\dots$ from the chosen start
date, let $s_{X,u}$ be the simple return (gross return $1+s_{X,u}$), $r_{X,u}=\log(1+s_{X,u})$
the log return, $R_{X,t}=\sum_{u=1}^{t}r_{X,u}$ the cumulative log return through period $t$,
and $W_{X,t}=100\,e^{R_{X,t}}$ the wealth index rebased to $100$ at the start. Since
$x\mapsto 100\,e^{x}$ is strictly increasing,
$$
W_{h,t}<W_{m,t}\iff R_{h,t}<R_{m,t},
$$
exactly. What makes this usable is a model for how $R_{h,t}$ relates to $R_{m,t}$.

**Model A (proportionality in log returns).** The regression above fits the affine relation in
log returns, $r_{h,u}=\alpha+\beta\,r_{m,u}+\varepsilon_u$ with $\beta>1$. Summing over
$u=1,\dots,t$ and writing $E_t=\sum_{u\le t}\varepsilon_u$ for the cumulative residual gives
$R_{h,t}=\alpha t+\beta R_{m,t}+E_t$, so
$$
\begin{aligned}
W_{h,t}<W_{m,t}
&\iff \alpha t+\beta R_{m,t}+E_t<R_{m,t}\\
&\iff \alpha t+E_t<(1-\beta)\,R_{m,t}\\
&\iff R_{m,t}<-\frac{\alpha t+E_t}{\beta-1},
\end{aligned}
$$
the last step dividing by $1-\beta<0$, which reverses the inequality. Writing
$\theta_t=-(\alpha t+E_t)/(\beta-1)$ for the threshold, the crossing is $R_{m,t}<\theta_t$. In
the idealisation $\alpha=0$ and $\varepsilon_u\equiv0$ (hence $E_t\equiv0$) the threshold is
$\theta_t=0$, giving the clean rule
$$
W_{h,t}<W_{m,t}\iff R_{m,t}<0\iff W_{m,t}<100:
$$
the high plan sits below the medium plan exactly over those windows in which the medium
(safer) plan is itself below its starting value.

The clean rule replaces $\theta_t$ by $0$; its error $\theta_t$ has an intercept part
$-\alpha t/(\beta-1)$ and a residual part $-E_t/(\beta-1)$. With an intercept in the
regression, least squares forces $\sum_{u=1}^{T}\hat\varepsilon_u=0$ over the full sample of
length $T$, so $E_T=0$ and the residual part vanishes over the whole window; over a strict
sub-window (the COVID rebasing below is one), the partial sum
$E_t=\sum_{u\le t}\hat\varepsilon_u$ is generally nonzero and is the slack between the clean
rule and the truth there.

More fundamentally, $\beta$ is the population least-squares slope: minimising
$E\!\left[(r_h-a-b\,r_m)^2\right]$ over $(a,b)$ gives the first-order conditions
$a=E[r_h]-b\,E[r_m]$ and $E[r_m r_h]=a\,E[r_m]+b\,E[r_m^2]$, which eliminate $a$ to leave
$\operatorname{Cov}(r_h,r_m)=b\,\operatorname{Var}(r_m)$, hence
$$
\beta=\frac{\operatorname{Cov}(r_h,r_m)}{\operatorname{Var}(r_m)}.
$$
This is defined only when the second moments are finite, and stably estimable only under
stronger conditions. The fitted $\nu\approx3$ to $4$ with a confidence interval reaching
$\nu\le2$, together with the max-sum plots, is precisely the evidence that finite variance
cannot be assumed: the crossing rule is therefore not a geometric identity but a statement
conditional on the existence of the second moments, the same caveat that governs every tail
estimate in this study.

**Model B (constant leverage).** Read "the high plan is a $\beta$-leveraged version of the
medium plan" literally, as a position rebalanced each period to hold constant exposure $\beta$.
Ignoring financing this scales the simple returns, $s_{h,u}=\beta\,s_{m,u}$ (a per-period
borrowing rate $c$ gives $s_{h,u}=\beta s_{m,u}-(\beta-1)c$; take $c=0$). Log returns are now
not proportional, and the crossing condition is exact,
$$
W_{h,t}<W_{m,t}\iff\sum_{u=1}^{t}\bigl[\log(1+\beta s_{m,u})-\log(1+s_{m,u})\bigr]<0
\iff\prod_{u=1}^{t}\frac{1+\beta s_{m,u}}{1+s_{m,u}}<1,
$$
valid while $s_{m,u}>-1/\beta$ (the leveraged plan is not wiped out). Expanding with
$\log(1+x)=x-\tfrac12 x^2+O(x^3)$ gives
$\log(1+\beta s)-\log(1+s)=(\beta-1)s-\tfrac12(\beta^2-1)s^2+O(s^3)$; summing, setting the
total $<0$, dividing by $\beta-1>0$ and using $\beta^2-1=(\beta-1)(\beta+1)$,
$$
\bar s_m<\tfrac12(\beta+1)\,\overline{s_m^{2}},\qquad
\overline{s_m^{2}}=\tfrac1n\sum_{u}s_{m,u}^2=\widehat{\operatorname{Var}}(s_m)+\bar s_m^2
\approx\hat\sigma_m^2 .
$$
For i.i.d. returns with $\mu=E[s_m]$ and $\sigma^2=\operatorname{Var}(s_m)$, the long-run
growth rate is $g=E[\log(1+s)]\approx\mu-\tfrac12\sigma^2$, so $g_m\approx\mu-\tfrac12\sigma^2$
and $g_h\approx\beta\mu-\tfrac12\beta^2\sigma^2$. The leveraged path stays below iff
$g_h<g_m$:
$$
(\beta-1)\mu<\tfrac12(\beta^2-1)\sigma^2\iff\mu<\tfrac12(\beta+1)\sigma^2\iff\beta>2\beta^\star-1,
$$
with the growth-optimal (Kelly) leverage $\beta^\star=\mu/\sigma^2$.

**The two models contrasted.** Both conditions read $\bar s_m<k\,\overline{s_m^{2}}$:
$k=\tfrac12$ for Model A (since
$R_m<0\iff\sum_u\log(1+s_{m,u})<0\iff\bar s_m<\tfrac12\overline{s_m^2}$ to second order) and
$k=\tfrac{\beta+1}{2}$ for Model B. With $\beta>1$ Model B crosses below over a wider set of
paths; in drift terms the thresholds on the medium plan's growth are $g_m<0$ (A) versus
$g_m<\tfrac12\beta\sigma^2$ (B). Model B's is strictly positive (a constant-leverage high
plan can sit below while the medium plan still grows), because leverage multiplies the
variance by $\beta^2$ but the mean only by $\beta$. The two constructions differ in which
variable carries the proportionality:
$$
g_h^{A}=E[\beta r_m]=\beta g_m,\qquad
g_h^{B}=\beta\mu-\tfrac12\beta^2\sigma^2=\beta g_m-\underbrace{\tfrac12\beta(\beta-1)\sigma^2}_{\text{leverage drag}} .
$$
Model A imposes $r_h=\beta r_m$, i.e. $1+s_h=(1+s_m)^{\beta}$, a convex power rule
($s_h=\beta s_m+\tfrac12\beta(\beta-1)s_m^2+O(s^3)$, holding more than $\beta s_m$ in large
moves), and that extra convexity has expectation $\tfrac12\beta(\beta-1)\sigma^2$, exactly
cancelling the drag, so $g_h^{A}=\beta g_m$ with no separate penalty.

For the four plans, the high plan regressed on the medium plan (monthly log returns):


Table: High plan regressed on medium plan, monthly log returns (n = 142).

|                        | $\beta$| $\alpha$ (per month)| $R^2$ (log)| $R^2$ (simple)|
|:-----------------------|-------:|--------------------:|-----------:|--------------:|
|Velliv (medium to high) |   1.263|              -0.0003|       0.994|          0.993|
|PFA (medium to high)    |   1.600|              -0.0002|       0.955|          0.954|



Table: Medium-plan moments and leverage diagnostics (annualised).

|       | $\mu$ (ann.)| $\sigma$ (ann.)| $\tfrac12\beta\sigma^2$| $\tfrac12\beta(\beta-1)\sigma^2$| Kelly $\beta^\star$|
|:------|------------:|---------------:|-----------------------:|--------------------------------:|-------------------:|
|Velliv |        7.45%|           8.35%|                   0.44%|                            0.12%|                10.7|
|PFA    |        6.50%|           5.94%|                   0.28%|                            0.17%|                18.4|

$\hat\beta>1$ with $\hat\alpha\approx0$ for both, so Model A's clean rule is the operative one.
The log- and simple-return $R^2$ differ by only about $0.001$ because returns are small, so
Models A and B are observationally almost identical here; the distinction is conceptual. The
constant-leverage threshold sits only $\tfrac12\beta\hat\sigma^2\approx0.3\%$ to $0.4\%$ per
year above zero, because $\beta$ is near $1$; for a genuine 2x or 3x product it would
dominate. The in-sample Kelly $\hat\beta^\star\approx11$ to $18$ is not a tangency to chase:
it is $\hat\mu/\hat\sigma^2$ measured on a crash-free window, the ratio of the two
least-robust quantities: the moment-existence caveat once more.
  
June 2012 was a low point just before a long bull market, so the safer plans never
revisited 100 and the paths never crossed. Start the index instead just before a drawdown and the high-risk path falls below. The COVID crash is a clean realised example: rebasing every plan to 100 at the end of February 2020, the high-risk plans drop **below** the medium-risk plans through the March-2020 trough -- and stay there for about nine months -- before recovering.  

![](pension-returns_monthly_files/figure-html/unnamed-chunk-140-1.png)<!-- -->

The high-risk plans regain and overtake the medium-risk plans only once the cumulative return since the start date turns positive again. Whether the realised paths cross is therefore not a property of the plans but of the chosen starting point relative to the market cycle. (A deeper or more prolonged regime -- e.g. one in which the index spends years below its start, as in 2008-2009 -- would keep the high-risk plan below for correspondingly longer.)

![](pension-returns_monthly_files/figure-html/unnamed-chunk-141-1.png)<!-- -->
![](pension-returns_monthly_files/figure-html/unnamed-chunk-142-1.png)<!-- -->


## When the high plan falls behind

Absolute wealth paths are hard to compare near the terminal date. There they converge. The
lead of the high plan over the medium plan is easier to read. It is the high index minus the
medium index, with both rebased to 100 at the entry. It crosses zero exactly when the high
plan falls behind.

Take first a fixed terminal and a varying entry. Invest 100 at every month in the sample. Hold
each entry to the last month in the data. The terminal wealth of an entry at month $i$ is
$W_i=100\,e^{R_i}$ with $R_i=\sum_{u=i}^{t} r_{X_u}$ and $t$ the last month. The lead is the
high terminal wealth minus the medium terminal wealth, read across entry months.

![](pension-returns_monthly_files/figure-html/entry-month-lead-1.png)<!-- -->

The lead never crosses zero. It is largest for the earliest entries. It shrinks toward zero as
the entry nears the terminal month. The reason is the terminal date. Our sample ends near its
high. Every entry has therefore gained by the end. So the high plan leads at every entry.
Running through all entry months shows no crossing.

Now reverse the exercise. Fix the entry at the first month and vary the terminal. Invest 100 at
the first month. Read the lead at each terminal month over the entire period.

![](pension-returns_monthly_files/figure-html/high-plan-lead-1.png)<!-- -->

The lead never turns negative. It builds over the bull market. It dips through the March-2020
trough but stays above zero. The two plots are mirror images. The full-sample lead sits at the
left edge of the first plot and at the right edge of this one. From the 2012 low looking
forward, and from the 2024 high looking back, the high plan stays ahead.

Neither full-sample view shows a below-zero lead. That does not rule one out. Each view fixes
one endpoint and moves the other. To be certain the lead never turns negative we would have to
run every entry against every terminal, every sub-window of the sample. We do not do that. A
below-zero lead appears whenever the entry sits at an interior peak. The plot below is one
example. The entry is the eve of the COVID crash, end-February 2020, a market peak.

![](pension-returns_monthly_files/figure-html/covid-entry-lead-1.png)<!-- -->

The lead turns negative through the March-2020 trough. It stays negative for about nine months
before recovering. This is the realised crossing, now visible as the lead dipping below zero.
The condition is the one derived above. The high plan trails the medium plan exactly while the
medium plan is below its entry value.

**A counterfactual.** The non-crossing in the two full-sample views is a feature of this
sample. The sample is a bull market that ends near its high. To see how much rests on that,
reverse every monthly return. Replace each $r_{X_u}$ with $-r_{X_u}$. The counterfactual
terminal wealth is $W'_i=100\,e^{R'_i}$ with $R'_i=\sum_{u=i}^{t} -r_{X_u}$. This is the same
world with the opposite luck. A rising market becomes a falling one. The leverage relation
survives the reversal. The reversed high plan is still a $\beta$-scaled version of the reversed
medium plan, because negating both sides of $h_u=\alpha+\beta m_u$ leaves the slope. Only the
sign of the cumulative return flips.

![](pension-returns_monthly_files/figure-html/cf-entry-month-lead-1.png)<!-- -->

Now the lead is below zero everywhere. The high plan falls behind at every entry. The mirror
view by terminal month agrees.

![](pension-returns_monthly_files/figure-html/cf-terminal-month-lead-1.png)<!-- -->

The reversed market ends near a low. Every cumulative return is negative. The high plan
amplifies losses exactly as it amplifies gains. So it sits below the medium plan throughout.
The realised non-crossing was the luck of a rising sample. It was never a property of the
plans.

## The downward bound

A pension account cannot fall below zero. In return terms the simple return satisfies
$s\ge-1$: at worst a period wipes out the capital, but it cannot take more. This bound sits
oddly beside a left-skewed and unbounded distribution of log returns. The two are reconciled
by the way wealth compounds. Wealth is $W=100\,e^{R}=100\prod_u(1+s_u)$, and $e^{R}>0$ for
every real $R$, so exponentiating a log-return model can never produce a negative value. The
simulated paths approach zero but never breach it. The wealth distribution is therefore
right-skewed and bounded below at zero, even though the log-return distribution that generates
it is left-skewed and unbounded. The heavy left tail in log space becomes a cluster of paths
near zero, not a set of negative balances.

This also settles which leverage reading applies. Under log-return scaling,
$1+s_h=(1+s_m)^{\beta}$, so as the medium plan approaches a total loss the high plan does too,
and neither breaches the bound. Under constant financial leverage, $s_h=\beta s_m$, a loss in
the medium plan beyond $1/\beta$ would drive the high plan below $-1$ and wipe it out. The
plans never do this, because they are long-only blends: the weights sum to one and no money is
borrowed, so the value is a weighted sum of non-negative fund values and stays non-negative.
The leverage here is higher exposure to the volatile fund, not borrowed money, which is why
the data follow the log-scaling relation rather than constant financial leverage.

## The Sharpe ratio: leverage ray or curve?

The crossing model $r_{h,u}=\alpha+\beta\,r_{m,u}+\varepsilon_u$ has a second consequence --
about reward per unit of risk rather than path order.

**Definition.** The annualised Sharpe ratio of plan $X$ is $S_X=(\mu_X-r_f)/\sigma_X$, with
$\mu_X$ and $\sigma_X$ the mean and standard deviation of the monthly log returns and $r_f$ the
risk-free rate. Danish short rates are near zero over the sample, so we set $r_f=0$ and
$S_X=\mu_X/\sigma_X$, estimated by $\hat S_X=(\bar x_X/\hat\sigma_X)\sqrt{12}$; the $\sqrt{12}$
annualisation assumes serially independent returns. Geometrically, plotting each plan as a
point $(\sigma_X,\mu_X)$, the Sharpe is the slope of the line from the origin to that point,
so a set of plans shares one Sharpe if and only if the points lie on a single ray through the
origin.

**A ray is the signature of leverage.** Under Model A with a clean fit ($\alpha=0$,
$\varepsilon_u\equiv0$), scaling the log returns by $\beta$ scales both moments by $\beta$ (so
$\mu_h=\beta\mu_m$ and $\sigma_h=\beta\sigma_m$), giving $S_h=\beta\mu_m/(\beta\sigma_m)=S_m$: the
two plans share a Sharpe and lie exactly on a ray. This is the same log-scaling that produced
the clean crossing rule. With a real fit ($\alpha\approx0$, $R^2<1$), let
$\rho=\operatorname{Cov}(r_h,r_m)/(\sigma_h\sigma_m)$ be the correlation; since
$\operatorname{Cov}(r_h,r_m)=\beta\sigma_m^2$ we have $\rho=\beta\sigma_m/\sigma_h$, hence
$$
S_h=\frac{\alpha+\beta\mu_m}{\sigma_h}=\rho\left(S_m+\frac{\alpha}{\beta\sigma_m}\right)\approx\rho\,S_m\quad(\alpha\approx0).
$$
The high plan's Sharpe is the medium plan's Sharpe scaled by the correlation $\rho=\sqrt{R^2}$.
A perfect leverage ray is $\rho=1$ ($S_h=S_m$); the menu bends by exactly the log-collinearity
shortfall $1-\rho$, the same residual the crossing section flagged. (Equivalently, in
simple-return space, constant leverage financed at $r_f$, i.e. Model B, traces the
constant-excess-Sharpe Capital Allocation Line; a ray is the signature of leverage in either
reading.)

**Why the curvature cannot be read off.** Two obstructions, both the study's theme. First,
$S=\mu/\sigma$ requires a finite variance ($\nu>2$); the fitted $\nu$ has a confidence
interval reaching $\nu\le2$, so the denominator may not exist, and where it does not the
Sharpe is not a population quantity. Second, even granting a finite variance, the sampling
variance of the estimator is (Lo 2002; Mertens 2002, under serial independence)
$$
\operatorname{Var}(\hat S)\approx\frac1T\left(1+\tfrac12 S^2-\gamma_3 S+\tfrac14(\gamma_4-3)S^2\right),
$$
with $\gamma_3$ the skewness and $\gamma_4$ the kurtosis, which is finite only for
$\nu>4$. The fitted $\nu\approx3.4$ to $4.3$ straddles $4$: the Sharpe is computable, but its own
standard error need not be finite. The figures below use the i.i.d.-normal standard error
$\operatorname{SE}(\hat S)\approx\sqrt{12\,(1+S^2/24)/n}$, which is a lower bound: the sample
skewness ($\approx-1$) and kurtosis ($\approx6$) inflate it, and the population kurtosis may
be infinite.


Table: Annualised Sharpe ratio by plan and start date.

|                      | Velliv medium| Velliv high| PFA medium| PFA high|
|:---------------------|-------------:|-----------:|----------:|--------:|
|from 2012-06  (n=142) |          0.84|        0.81|       1.06|     1.01|
|from 2016-01  (n=100) |          0.61|        0.58|       0.75|     0.75|
|from 2019-01  (n=64)  |          0.66|        0.66|       0.67|     0.82|

The full-sample decomposition $S_h=\rho(S_m+\alpha/(\beta\sigma_m))$ and the sampling error of
each estimate:


Table: Within-provider Sharpe decomposition and sampling error (full sample, n = 142; annualised; SE i.i.d.-normal, a lower bound).

|       | $\rho$| $S_m$| $S_h$| $\rho S_m$| $\mathrm{SE}(S)$| gap / SE|
|:------|------:|-----:|-----:|----------:|----------------:|--------:|
|Velliv |  0.997|  0.84|  0.81|       0.84|             0.29|     0.11|
|PFA    |  0.977|  1.06|  1.01|       1.03|             0.30|     0.17|

**Reading.** For Velliv $\hat\rho=0.997$: the medium and high plans are a near-perfect leverage
ray, $\hat S_h$ is reproduced by $\hat\rho(\hat S_m+\hat\alpha/(\hat\beta\hat\sigma_m))$ to the
displayed precision, and the gap $\hat S_m-\hat S_h\approx0.03$ is about $0.1$ of one standard
error. Choosing the Velliv risk level is pure risk appetite, with nothing to optimise: the
same $\beta$-scaling that gives Velliv's clean crossing rule. For PFA $\hat\rho=0.977$: the
menu is measurably more bent (by about $2\%$), but the Sharpe gap is still only about $0.2$ of
a standard error, and which profile leads flips with the start date (the by-window table
above). So although PFA's menu does curve, no best-Sharpe blend is identifiable at this sample
size, and the standard error itself is only a lower bound (the kurtosis it omits may
be infinite). It is not worth paying, in added risk or in fees, to chase a tangency that the
data cannot locate.

The risk-return map shows the same result. Each plan sits at its annualised volatility and mean
return. Plans on one ray through the origin share a Sharpe ratio; a bend off the ray is a Sharpe
difference.

![](pension-returns_monthly_files/figure-html/mean-var-plot-1.png)<!-- -->

The three Velliv plans lie close to one ray, the signature of leverage. PFA's profiles sit a
little off it, the small bend the decomposition above quantified.

## Diversifying across providers: variance drain and certainty equivalent

The crossing and Sharpe results concern one provider's menu. A separate question is what the
return moments say about holding *both* providers at one risk level, for example Velliv high
together with PFA high. This is the diversification the investor tool weighs against fees. We
derive its value here from the moments alone, and the tool applies it to costs.

**Variance drain.** Compound growth sits below the arithmetic mean by half the variance. If a
plan's simple returns have arithmetic mean $a$ and variance $\sigma^2$, wealth compounds at
about $g\approx a-\tfrac12\sigma^2$ per period. Cutting variance therefore lifts the compound
rate one part in two: a reduction $\Delta\sigma^2$ raises $g$ by $\Delta\sigma^2/2$.

**A 50/50 blend cuts variance.** Take two plans of equal variance $\sigma^2$ and correlation
$\rho$. The equal-weight blend has variance $\tfrac12\sigma^2(1+\rho)$, a reduction of
$\tfrac12\sigma^2(1-\rho)$. Write $\sigma^2_{\mathrm{gap}}=\operatorname{Var}(r_A-r_B)=2\sigma^2(1-\rho)$
for the variance of the gap between the two plans. The reduction is then $\sigma^2_{\mathrm{gap}}/4$,
and the compound-growth lift is
$$\Delta g=\tfrac12\cdot\frac{\sigma^2_{\mathrm{gap}}}{4}=\frac{\sigma^2_{\mathrm{gap}}}{8}.$$

**Certainty equivalent.** A saver with constant relative risk aversion $\gamma$ values a variance
cut at $\tfrac12\gamma$ times its size, so the certainty-equivalent value of holding both plans
rather than one is
$$\mathrm{CE}\approx\tfrac12\gamma\cdot\frac{\sigma^2_{\mathrm{gap}}}{4}=\frac{\gamma\,\sigma^2_{\mathrm{gap}}}{8}.$$
The variance drain is the case $\gamma=1$, log utility, where the risk-adjusted value equals the
raw growth lift. The value scales linearly in risk aversion above that.

**Two sources over a horizon.** Over $T$ periods the gap between the two plans' cumulative log
returns has two parts. One is path noise, the accumulation of the per-period gap, which grows
linearly in $T$. The other is uncertainty about the *relative* drift, since which provider
compounds faster is not known in advance, and this grows as $T^2$, so it dominates at long
horizons. Both enter $\sigma^2_{\mathrm{gap}}$ and so the certainty equivalent. The estimation
part is the larger stake for a long-horizon saver, and it is exactly what the data cannot pin
down.


Table: Diversification value of a 50/50 cross-provider blend at one risk level, from the return moments (full sample, n = 142). $\Delta g$ is the variance drain, equal to the certainty equivalent at $\gamma=1$; $\Delta g$ and CE are in basis points per year. A mean-variance, body-of-the-distribution figure.

|                      blend| $\sigma_{\mathrm{gap}}$ (ann.)| $\Delta g$ (bp/yr)| CE, $\gamma=2$ (bp/yr)| CE, $\gamma=4$ (bp/yr)|
|--------------------------:|------------------------------:|------------------:|----------------------:|----------------------:|
|     Velliv high + PFA high|                           2.8%|                1.0|                    1.9|                    3.8|
| Velliv medium + PFA medium|                           3.1%|                1.2|                    2.5|                    4.9|

**A body result, not a tail result.** This is a mean-variance argument, valid for the centre of
the distribution where a variance is a meaningful summary. The report's central finding is that
the tail is heavy and the variance may not be finite, in which case $\sigma^2$ and everything
built on it lose their meaning. The value above is therefore the diversification benefit in the
body. Whether holding both providers helps in a crash is a tail question, and the investor tool
takes it up with a joint simulation.

### The provider gap is one realised path

The certainty equivalent above prices the uncertainty about *which* provider compounds faster.
That uncertainty is real: over the sample the two high-risk plans drift apart, but by a margin the
data cannot distinguish from zero.


Table: Realised return gap, PFA high minus Velliv high (full sample, n = 142).

|annualised gap |standard error |t   |
|:--------------|:--------------|:---|
|+1.2 pp/yr     |0.8 pp/yr      |1.5 |

![](pension-returns_monthly_files/figure-html/provider-drift-plot-1.png)<!-- -->

The paths separate, yet with $t\approx1.5$ the gap is not
distinguishable from zero. Which provider leads is not something the data establish in advance,
which is exactly the uncertainty the certainty equivalent prices.


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




|   |  vmr|    vhr|    pmr|    phr|  mmr|    mhr| vmr_phr| vhr_pmr|
|:--|----:|------:|------:|------:|----:|------:|-------:|-------:|
|0  | 31.5| 32.167| 28.167| 31.333| 29.5| 31.167|  30.833|  30.333|
|5  |  1.0|  2.167|  0.167|  1.500|  0.5|  1.833|   1.167|   1.000|
|10 |  0.0|  0.000|  0.000|  0.000|  0.0|  0.000|   0.000|   0.000|
|25 |  0.0|  0.000|  0.000|  0.000|  0.0|  0.000|   0.000|   0.000|
|50 |  0.0|  0.000|  0.000|  0.000|  0.0|  0.000|   0.000|   0.000|
|90 |  0.0|  0.000|  0.000|  0.000|  0.0|  0.000|   0.000|   0.000|
|99 |  0.0|  0.000|  0.000|  0.000|  0.0|  0.000|   0.000|   0.000|


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


|      0|ranking |     5|ranking | 10|ranking | 25|ranking | 50|ranking | 90|ranking | 99|ranking |
|------:|:-------|-----:|:-------|--:|:-------|--:|:-------|--:|:-------|--:|:-------|--:|:-------|
| 32.167|vhr     | 2.167|vhr     |  0|vmr     |  0|vmr     |  0|vmr     |  0|vmr     |  0|vmr     |
| 31.500|vmr     | 1.833|mhr     |  0|vhr     |  0|vhr     |  0|vhr     |  0|vhr     |  0|vhr     |
| 31.333|phr     | 1.500|phr     |  0|pmr     |  0|pmr     |  0|pmr     |  0|pmr     |  0|pmr     |
| 31.167|mhr     | 1.167|vmr_phr |  0|phr     |  0|phr     |  0|phr     |  0|phr     |  0|phr     |
| 30.833|vmr_phr | 1.000|vmr     |  0|mmr     |  0|mmr     |  0|mmr     |  0|mmr     |  0|mmr     |
| 30.333|vhr_pmr | 1.000|vhr_pmr |  0|mhr     |  0|mhr     |  0|mhr     |  0|mhr     |  0|mhr     |
| 29.500|mmr     | 0.500|mmr     |  0|vmr_phr |  0|vmr_phr |  0|vmr_phr |  0|vmr_phr |  0|vmr_phr |
| 28.167|pmr     | 0.167|pmr     |  0|vhr_pmr |  0|vhr_pmr |  0|vhr_pmr |  0|vhr_pmr |  0|vhr_pmr |


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




|    |  vmr|    vhr|    pmr|    phr|    mmr|    mhr| vmr_phr| vhr_pmr|
|:---|----:|------:|------:|------:|------:|------:|-------:|-------:|
|0   | 68.5| 67.833| 71.833| 68.667| 70.500| 68.833|  69.167|  69.667|
|5   |  4.0|  7.833|  1.167|  6.833|  2.333|  7.167|   5.333|   4.000|
|10  |  0.0|  0.667|  0.000|  0.333|  0.000|  0.500|   0.167|   0.167|
|25  |  0.0|  0.000|  0.000|  0.000|  0.000|  0.000|   0.000|   0.000|
|50  |  0.0|  0.000|  0.000|  0.000|  0.000|  0.000|   0.000|   0.000|
|100 |  0.0|  0.000|  0.000|  0.000|  0.000|  0.000|   0.000|   0.000|


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


|      0|ranking |     5|ranking |    10|ranking | 25|ranking | 50|ranking | 100|ranking |
|------:|:-------|-----:|:-------|-----:|:-------|--:|:-------|--:|:-------|---:|:-------|
| 71.833|pmr     | 7.833|vhr     | 0.667|vhr     |  0|vmr     |  0|vmr     |   0|vmr     |
| 70.500|mmr     | 7.167|mhr     | 0.500|mhr     |  0|vhr     |  0|vhr     |   0|vhr     |
| 69.667|vhr_pmr | 6.833|phr     | 0.333|phr     |  0|pmr     |  0|pmr     |   0|pmr     |
| 69.167|vmr_phr | 5.333|vmr_phr | 0.167|vmr_phr |  0|phr     |  0|phr     |   0|phr     |
| 68.833|mhr     | 4.000|vmr     | 0.167|vhr_pmr |  0|mmr     |  0|mmr     |   0|mmr     |
| 68.667|phr     | 4.000|vhr_pmr | 0.000|vmr     |  0|mhr     |  0|mhr     |   0|mhr     |
| 68.500|vmr     | 2.333|mmr     | 0.000|pmr     |  0|vmr_phr |  0|vmr_phr |   0|vmr_phr |
| 67.833|vhr     | 1.167|pmr     | 0.000|mmr     |  0|vhr_pmr |  0|vhr_pmr |   0|vhr_pmr |


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




|   |   vmr|   vhr|  pmr|   phr|   mmr|   mhr| vmr_phr| vhr_pmr|
|:--|-----:|-----:|----:|-----:|-----:|-----:|-------:|-------:|
|0  | 17.07| 18.84| 9.95| 12.39| 14.82| 15.14|   13.99|   15.97|
|5  |  8.87| 11.40| 3.54|  6.71|  6.91|  8.47|    7.61|    8.21|
|10 |  4.26|  6.49| 1.08|  3.46|  2.88|  4.42|    3.70|    3.63|
|25 |  0.45|  1.02| 0.06|  0.35|  0.20|  0.42|    0.32|    0.34|
|50 |  0.03|  0.01| 0.00|  0.03|  0.03|  0.03|    0.02|    0.00|
|90 |  0.00|  0.00| 0.00|  0.00|  0.00|  0.00|    0.00|    0.00|
|99 |  0.00|  0.00| 0.00|  0.00|  0.00|  0.00|    0.00|    0.00|




Standardized $t$-distribution (std):  




|   |  vmr|  vhr|  pmr|  phr|  mmr|  mhr| vmr_phr| vhr_pmr|
|:--|----:|----:|----:|----:|----:|----:|-------:|-------:|
|0  | 6.21| 6.74| 4.20| 4.67| 4.61| 5.48|    4.93|    5.38|
|5  | 2.47| 3.34| 1.20| 1.93| 1.57| 2.62|    2.15|    2.26|
|10 | 0.88| 1.49| 0.34| 0.70| 0.43| 1.19|    0.76|    0.78|
|25 | 0.05| 0.17| 0.05| 0.05| 0.03| 0.07|    0.04|    0.05|
|50 | 0.00| 0.00| 0.00| 0.00| 0.00| 0.01|    0.01|    0.01|
|90 | 0.00| 0.00| 0.00| 0.00| 0.00| 0.00|    0.00|    0.00|
|99 | 0.00| 0.00| 0.00| 0.00| 0.00| 0.00|    0.00|    0.00|


Normal distribution:  




|   |   vmr|   vhr|  pmr|   phr|   mmr|   mhr| vmr_phr| vhr_pmr|
|:--|-----:|-----:|----:|-----:|-----:|-----:|-------:|-------:|
|0  | 13.93| 16.01| 9.13| 10.13| 12.30| 12.31|   11.87|   12.83|
|5  |  5.80|  8.34| 2.18|  4.51|  4.09|  5.89|    4.91|    5.38|
|10 |  1.85|  3.75| 0.37|  1.61|  0.99|  2.37|    1.86|    1.68|
|25 |  0.00|  0.11| 0.00|  0.01|  0.00|  0.01|    0.04|    0.00|
|50 |  0.00|  0.00| 0.00|  0.00|  0.00|  0.00|    0.00|    0.00|
|90 |  0.00|  0.00| 0.00|  0.00|  0.00|  0.00|    0.00|    0.00|
|99 |  0.00|  0.00| 0.00|  0.00|  0.00|  0.00|    0.00|    0.00|


### Worst ranking for MC loss percentiles

Skewed $t$-distribution (sstd):  


|     0|ranking |     5|ranking |   10|ranking |   25|ranking |   50|ranking | 90|ranking | 99|ranking |
|-----:|:-------|-----:|:-------|----:|:-------|----:|:-------|----:|:-------|--:|:-------|--:|:-------|
| 18.84|vhr     | 11.40|vhr     | 6.49|vhr     | 1.02|vhr     | 0.03|vmr     |  0|vmr     |  0|vmr     |
| 17.07|vmr     |  8.87|vmr     | 4.42|mhr     | 0.45|vmr     | 0.03|phr     |  0|vhr     |  0|vhr     |
| 15.97|vhr_pmr |  8.47|mhr     | 4.26|vmr     | 0.42|mhr     | 0.03|mmr     |  0|pmr     |  0|pmr     |
| 15.14|mhr     |  8.21|vhr_pmr | 3.70|vmr_phr | 0.35|phr     | 0.03|mhr     |  0|phr     |  0|phr     |
| 14.82|mmr     |  7.61|vmr_phr | 3.63|vhr_pmr | 0.34|vhr_pmr | 0.02|vmr_phr |  0|mmr     |  0|mmr     |
| 13.99|vmr_phr |  6.91|mmr     | 3.46|phr     | 0.32|vmr_phr | 0.01|vhr     |  0|mhr     |  0|mhr     |
| 12.39|phr     |  6.71|phr     | 2.88|mmr     | 0.20|mmr     | 0.00|pmr     |  0|vmr_phr |  0|vmr_phr |
|  9.95|pmr     |  3.54|pmr     | 1.08|pmr     | 0.06|pmr     | 0.00|vhr_pmr |  0|vhr_pmr |  0|vhr_pmr |


Standardized $t$-distribution (std):  


|    0|ranking |    5|ranking |   10|ranking |   25|ranking |   50|ranking | 90|ranking | 99|ranking |
|----:|:-------|----:|:-------|----:|:-------|----:|:-------|----:|:-------|--:|:-------|--:|:-------|
| 6.74|vhr     | 3.34|vhr     | 1.49|vhr     | 0.17|vhr     | 0.01|mhr     |  0|vmr     |  0|vmr     |
| 6.21|vmr     | 2.62|mhr     | 1.19|mhr     | 0.07|mhr     | 0.01|vmr_phr |  0|vhr     |  0|vhr     |
| 5.48|mhr     | 2.47|vmr     | 0.88|vmr     | 0.05|vmr     | 0.01|vhr_pmr |  0|pmr     |  0|pmr     |
| 5.38|vhr_pmr | 2.26|vhr_pmr | 0.78|vhr_pmr | 0.05|pmr     | 0.00|vmr     |  0|phr     |  0|phr     |
| 4.93|vmr_phr | 2.15|vmr_phr | 0.76|vmr_phr | 0.05|phr     | 0.00|vhr     |  0|mmr     |  0|mmr     |
| 4.67|phr     | 1.93|phr     | 0.70|phr     | 0.05|vhr_pmr | 0.00|pmr     |  0|mhr     |  0|mhr     |
| 4.61|mmr     | 1.57|mmr     | 0.43|mmr     | 0.04|vmr_phr | 0.00|phr     |  0|vmr_phr |  0|vmr_phr |
| 4.20|pmr     | 1.20|pmr     | 0.34|pmr     | 0.03|mmr     | 0.00|mmr     |  0|vhr_pmr |  0|vhr_pmr |


Normal distribution:  


|     0|ranking |    5|ranking |   10|ranking |   25|ranking | 50|ranking | 90|ranking | 99|ranking |
|-----:|:-------|----:|:-------|----:|:-------|----:|:-------|--:|:-------|--:|:-------|--:|:-------|
| 16.01|vhr     | 8.34|vhr     | 3.75|vhr     | 0.11|vhr     |  0|vmr     |  0|vmr     |  0|vmr     |
| 13.93|vmr     | 5.89|mhr     | 2.37|mhr     | 0.04|vmr_phr |  0|vhr     |  0|vhr     |  0|vhr     |
| 12.83|vhr_pmr | 5.80|vmr     | 1.86|vmr_phr | 0.01|phr     |  0|pmr     |  0|pmr     |  0|pmr     |
| 12.31|mhr     | 5.38|vhr_pmr | 1.85|vmr     | 0.01|mhr     |  0|phr     |  0|phr     |  0|phr     |
| 12.30|mmr     | 4.91|vmr_phr | 1.68|vhr_pmr | 0.00|vmr     |  0|mmr     |  0|mmr     |  0|mmr     |
| 11.87|vmr_phr | 4.51|phr     | 1.61|phr     | 0.00|pmr     |  0|mhr     |  0|mhr     |  0|mhr     |
| 10.13|phr     | 4.09|mmr     | 0.99|mmr     | 0.00|mmr     |  0|vmr_phr |  0|vmr_phr |  0|vmr_phr |
|  9.13|pmr     | 2.18|pmr     | 0.37|pmr     | 0.00|vhr_pmr |  0|vhr_pmr |  0|vhr_pmr |  0|vhr_pmr |


## MC gains percentiles




Skewed $t$-distribution (sstd):  




|     |   vmr|   vhr|   pmr|   phr|   mmr|   mhr| vmr_phr| vhr_pmr|
|:----|-----:|-----:|-----:|-----:|-----:|-----:|-------:|-------:|
|0    | 82.93| 81.16| 90.05| 87.61| 85.18| 84.86|   86.01|   84.03|
|5    | 70.76| 71.99| 76.14| 79.04| 72.11| 75.08|   76.41|   73.09|
|10   | 55.32| 60.46| 55.17| 68.30| 54.87| 63.86|   63.19|   58.42|
|25   | 13.52| 24.27|  4.49| 30.34|  8.63| 26.11|   21.38|   15.78|
|50   |  0.27|  1.55|  0.00|  1.67|  0.05|  1.61|    0.52|    0.20|
|100  |  0.01|  0.01|  0.00|  0.00|  0.00|  0.00|    0.01|    0.01|
|200  |  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|    0.01|    0.00|
|300  |  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|    0.00|    0.00|
|400  |  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|    0.00|    0.00|
|500  |  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|    0.00|    0.00|
|1000 |  0.00|  0.00|  0.00|  0.00|  0.00|  0.00|    0.00|    0.00|




Standardized $t$-distribution (std):  




|     |   vmr|   vhr|   pmr|   phr|   mmr|   mhr| vmr_phr| vhr_pmr|
|:----|-----:|-----:|-----:|-----:|-----:|-----:|-------:|-------:|
|0    | 93.79| 93.26| 95.80| 95.33| 95.39| 94.52|   95.07|   94.62|
|5    | 86.63| 87.86| 87.73| 90.31| 88.89| 88.92|   89.29|   88.12|
|10   | 74.95| 79.28| 71.91| 82.31| 76.03| 81.41|   80.43|   77.28|
|25   | 29.38| 44.36| 13.85| 44.89| 24.06| 45.54|   39.68|   33.17|
|50   |  1.83|  7.27|  0.21|  5.44|  0.73|  6.37|    3.57|    2.11|
|100  |  0.03|  0.13|  0.01|  0.05|  0.03|  0.03|    0.04|    0.02|
|200  |  0.00|  0.01|  0.00|  0.00|  0.01|  0.00|    0.00|    0.01|
|300  |  0.00|  0.01|  0.00|  0.00|  0.01|  0.00|    0.00|    0.01|
|400  |  0.00|  0.01|  0.00|  0.00|  0.01|  0.00|    0.00|    0.00|
|500  |  0.00|  0.01|  0.00|  0.00|  0.00|  0.00|    0.00|    0.00|
|1000 |  0.00|  0.01|  0.00|  0.00|  0.00|  0.00|    0.00|    0.00|


Normal distribution:  




|     |   vmr|   vhr|   pmr|   phr|   mmr|   mhr| vmr_phr| vhr_pmr|
|:----|-----:|-----:|-----:|-----:|-----:|-----:|-------:|-------:|
|0    | 86.07| 83.99| 90.87| 89.87| 87.70| 87.69|   88.13|   87.17|
|5    | 72.88| 73.65| 75.16| 80.75| 73.79| 77.80|   77.45|   75.20|
|10   | 56.82| 61.39| 51.06| 68.10| 54.76| 65.72|   63.56|   59.08|
|25   | 14.87| 25.32|  4.59| 28.98|  9.29| 27.71|   21.63|   16.53|
|50   |  0.27|  2.15|  0.01|  1.92|  0.03|  2.12|    0.98|    0.33|
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
| 90.05|pmr     | 79.04|phr     | 68.30|phr     | 30.34|phr     | 1.67|phr     | 0.01|vmr     |
| 87.61|phr     | 76.41|vmr_phr | 63.86|mhr     | 26.11|mhr     | 1.61|mhr     | 0.01|vhr     |
| 86.01|vmr_phr | 76.14|pmr     | 63.19|vmr_phr | 24.27|vhr     | 1.55|vhr     | 0.01|vmr_phr |
| 85.18|mmr     | 75.08|mhr     | 60.46|vhr     | 21.38|vmr_phr | 0.52|vmr_phr | 0.01|vhr_pmr |
| 84.86|mhr     | 73.09|vhr_pmr | 58.42|vhr_pmr | 15.78|vhr_pmr | 0.27|vmr     | 0.00|pmr     |
| 84.03|vhr_pmr | 72.11|mmr     | 55.32|vmr     | 13.52|vmr     | 0.20|vhr_pmr | 0.00|phr     |
| 82.93|vmr     | 71.99|vhr     | 55.17|pmr     |  8.63|mmr     | 0.05|mmr     | 0.00|mmr     |
| 81.16|vhr     | 70.76|vmr     | 54.87|mmr     |  4.49|pmr     | 0.00|pmr     | 0.00|mhr     |


|  200|ranking | 300|ranking | 400|ranking | 500|ranking | 1000|ranking |
|----:|:-------|---:|:-------|---:|:-------|---:|:-------|----:|:-------|
| 0.01|vmr_phr |   0|vmr     |   0|vmr     |   0|vmr     |    0|vmr     |
| 0.00|vmr     |   0|vhr     |   0|vhr     |   0|vhr     |    0|vhr     |
| 0.00|vhr     |   0|pmr     |   0|pmr     |   0|pmr     |    0|pmr     |
| 0.00|pmr     |   0|phr     |   0|phr     |   0|phr     |    0|phr     |
| 0.00|phr     |   0|mmr     |   0|mmr     |   0|mmr     |    0|mmr     |
| 0.00|mmr     |   0|mhr     |   0|mhr     |   0|mhr     |    0|mhr     |
| 0.00|mhr     |   0|vmr_phr |   0|vmr_phr |   0|vmr_phr |    0|vmr_phr |
| 0.00|vhr_pmr |   0|vhr_pmr |   0|vhr_pmr |   0|vhr_pmr |    0|vhr_pmr |


Standardized $t$-distribution (std):  


|     0|ranking |     5|ranking |    10|ranking |    25|ranking |   50|ranking |  100|ranking |
|-----:|:-------|-----:|:-------|-----:|:-------|-----:|:-------|----:|:-------|----:|:-------|
| 95.80|pmr     | 90.31|phr     | 82.31|phr     | 45.54|mhr     | 7.27|vhr     | 0.13|vhr     |
| 95.39|mmr     | 89.29|vmr_phr | 81.41|mhr     | 44.89|phr     | 6.37|mhr     | 0.05|phr     |
| 95.33|phr     | 88.92|mhr     | 80.43|vmr_phr | 44.36|vhr     | 5.44|phr     | 0.04|vmr_phr |
| 95.07|vmr_phr | 88.89|mmr     | 79.28|vhr     | 39.68|vmr_phr | 3.57|vmr_phr | 0.03|vmr     |
| 94.62|vhr_pmr | 88.12|vhr_pmr | 77.28|vhr_pmr | 33.17|vhr_pmr | 2.11|vhr_pmr | 0.03|mmr     |
| 94.52|mhr     | 87.86|vhr     | 76.03|mmr     | 29.38|vmr     | 1.83|vmr     | 0.03|mhr     |
| 93.79|vmr     | 87.73|pmr     | 74.95|vmr     | 24.06|mmr     | 0.73|mmr     | 0.02|vhr_pmr |
| 93.26|vhr     | 86.63|vmr     | 71.91|pmr     | 13.85|pmr     | 0.21|pmr     | 0.01|pmr     |


|  200|ranking |  300|ranking |  400|ranking |  500|ranking | 1000|ranking |
|----:|:-------|----:|:-------|----:|:-------|----:|:-------|----:|:-------|
| 0.01|vhr     | 0.01|vhr     | 0.01|vhr     | 0.01|vhr     | 0.01|vhr     |
| 0.01|mmr     | 0.01|mmr     | 0.01|mmr     | 0.00|vmr     | 0.00|vmr     |
| 0.01|vhr_pmr | 0.01|vhr_pmr | 0.00|vmr     | 0.00|pmr     | 0.00|pmr     |
| 0.00|vmr     | 0.00|vmr     | 0.00|pmr     | 0.00|phr     | 0.00|phr     |
| 0.00|pmr     | 0.00|pmr     | 0.00|phr     | 0.00|mmr     | 0.00|mmr     |
| 0.00|phr     | 0.00|phr     | 0.00|mhr     | 0.00|mhr     | 0.00|mhr     |
| 0.00|mhr     | 0.00|mhr     | 0.00|vmr_phr | 0.00|vmr_phr | 0.00|vmr_phr |
| 0.00|vmr_phr | 0.00|vmr_phr | 0.00|vhr_pmr | 0.00|vhr_pmr | 0.00|vhr_pmr |


Normal distribution:  


|     0|ranking |     5|ranking |    10|ranking |    25|ranking |   50|ranking | 100|ranking |
|-----:|:-------|-----:|:-------|-----:|:-------|-----:|:-------|----:|:-------|---:|:-------|
| 90.87|pmr     | 80.75|phr     | 68.10|phr     | 28.98|phr     | 2.15|vhr     |   0|vmr     |
| 89.87|phr     | 77.80|mhr     | 65.72|mhr     | 27.71|mhr     | 2.12|mhr     |   0|vhr     |
| 88.13|vmr_phr | 77.45|vmr_phr | 63.56|vmr_phr | 25.32|vhr     | 1.92|phr     |   0|pmr     |
| 87.70|mmr     | 75.20|vhr_pmr | 61.39|vhr     | 21.63|vmr_phr | 0.98|vmr_phr |   0|phr     |
| 87.69|mhr     | 75.16|pmr     | 59.08|vhr_pmr | 16.53|vhr_pmr | 0.33|vhr_pmr |   0|mmr     |
| 87.17|vhr_pmr | 73.79|mmr     | 56.82|vmr     | 14.87|vmr     | 0.27|vmr     |   0|mhr     |
| 86.07|vmr     | 73.65|vhr     | 54.76|mmr     |  9.29|mmr     | 0.03|mmr     |   0|vmr_phr |
| 83.99|vhr     | 72.88|vmr     | 51.06|pmr     |  4.59|pmr     | 0.01|pmr     |   0|vhr_pmr |


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


|     |   vmr|   vhr|   pmr|   phr|   mmr|   mhr| vmr_phr| vhr_pmr|
|:----|-----:|-----:|-----:|-----:|-----:|-----:|-------:|-------:|
|m    | 0.005| 0.007| 0.005| 0.008| 0.005| 0.007|   0.007|   0.006|
|s    | 0.027| 0.034| 0.019| 0.030| 0.023| 0.031|   0.028|   0.027|
|nu   | 3.384| 3.488| 3.474| 3.959| 3.344| 3.702|   3.726|   3.369|
|xi   | 0.699| 0.708| 0.770| 0.737| 0.716| 0.714|   0.715|   0.709|
|PPCC | 0.993| 0.992| 0.994| 0.996| 0.993| 0.993|   0.994|   0.993|

The fits in this section are based on **n = 142** observations.

##### Standard errors

Standard errors for the skewed-$t$ parameters, from the observed Fisher information (the
inverse Hessian of the log-likelihood at the maximum). An entry of `NaN`/`NA` flags a
non-positive or singular information matrix: the parameter is then not locally identified
at this sample size.


|   |    vmr|    vhr|    pmr|    phr|    mmr|    mhr| vmr_phr| vhr_pmr|
|:--|------:|------:|------:|------:|------:|------:|-------:|-------:|
|m  | 0.0022| 0.0027| 0.0015| 0.0025| 0.0018| 0.0025|  0.0023|  0.0022|
|s  | 0.0057| 0.0067| 0.0034| 0.0046| 0.0049| 0.0055|  0.0049|  0.0057|
|nu | 1.1631| 1.2181| 1.2340| 1.4812| 1.1786| 1.3952|  1.4105|  1.1694|
|xi | 0.0859| 0.0854| 0.0773| 0.0847| 0.0712| 0.0768|  0.0729|  0.0867|



The four parameters split sharply by how much data they require. The location `m` and
scale `s` are pinned down even here -- their standard errors are a small fraction of the
estimates, on the order of what a Gaussian of the same mean and variance would give. The
tail index `nu` and skew `xi` are another matter. Where `nu` is identified its relative standard error
ranges from 34% to 38%; for `` vmr `` the
95% interval is approximately [1.1, 5.7], which
straddles both `nu = 2` (below which the variance ceases to exist) and `nu = 4` (below
which the kurtosis is infinite). At this sample size, then, the data cannot settle whether
the return variance is even finite. The skew for `` vmr `` is `xi` = 0.7
with 95% interval [0.53, 0.87], which lies entirely below 1, so the left skew is statistically established.
Because it is the tail parameters that carry the risk, this imprecision -- not the
well-determined mean -- is the binding constraint on what the fit can tell us (cf. the
$\kappa$ and $n_{\min}$ results below).


Standardized $t$-distribution (std):


|     |   vmr|   vhr|   pmr|   phr|   mmr|   mhr| vmr_phr| vhr_pmr|
|:----|-----:|-----:|-----:|-----:|-----:|-----:|-------:|-------:|
|m    | 0.009| 0.011| 0.007| 0.011| 0.008| 0.011|   0.010|   0.009|
|s    | 0.026| 0.033| 0.019| 0.029| 0.022| 0.030|   0.027|   0.026|
|nu   | 3.534| 3.591| 3.269| 4.338| 3.367| 3.834|   3.863|   3.434|
|PPCC | 0.979| 0.978| 0.971| 0.981| 0.974| 0.978|   0.978|   0.975|


Normal distribution:  


|     |   vmr|   vhr|   pmr|   phr|   mmr|   mhr| vmr_phr| vhr_pmr|
|:----|-----:|-----:|-----:|-----:|-----:|-----:|-------:|-------:|
|m    | 0.006| 0.007| 0.005| 0.008| 0.006| 0.008|   0.007|   0.006|
|s    | 0.024| 0.031| 0.017| 0.028| 0.021| 0.029|   0.026|   0.024|
|PPCC | 0.968| 0.969| 0.962| 0.973| 0.965| 0.969|   0.969|   0.966|


#### AIC and BIC  


AIC





|       |      vmr|      vhr|      pmr|      phr|      mmr|      mhr|  vmr_phr|  vhr_pmr|
|:------|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|
|sstd   | -671.412| -603.343| -768.368| -622.474| -718.914| -617.207| -647.901| -672.555|
|std    | -663.820| -596.171| -763.943| -617.193| -711.297| -609.563| -640.384| -664.804|
|normal | -650.514| -583.369| -747.179| -607.088| -696.459| -597.830| -628.670| -650.870|


BIC  




|       |      vmr|      vhr|      pmr|      phr|      mmr|      mhr|  vmr_phr|  vhr_pmr|
|:------|--------:|--------:|--------:|--------:|--------:|--------:|--------:|--------:|
|sstd   | -659.588| -591.520| -756.545| -610.651| -707.091| -605.384| -636.077| -660.732|
|std    | -654.953| -587.304| -755.075| -608.326| -702.429| -600.696| -631.516| -655.937|
|normal | -644.602| -577.458| -741.267| -601.177| -690.548| -591.918| -622.758| -644.958|

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
|sstd   | 0.21| 0.23| 0.35| 0.21| 0.25| 0.27|    0.26|    0.24|
|std    | 1.19| 1.15| 1.03| 0.92| 1.24| 1.21|    1.18|    1.24|
|normal | 2.39| 2.34| 2.47| 1.82| 2.55| 2.29|    2.25|    2.50|

Parametric-bootstrap p-value (small = reject the distribution):


|       |   vmr|   vhr|   pmr|   phr|   mmr|   mhr| vmr_phr| vhr_pmr|
|:------|-----:|-----:|-----:|-----:|-----:|-----:|-------:|-------:|
|sstd   | 0.527| 0.487| 0.136| 0.547| 0.369| 0.333|   0.353|   0.425|
|std    | 0.004| 0.004| 0.004| 0.010| 0.002| 0.002|   0.006|   0.004|
|normal | 0.000| 0.000| 0.000| 0.002| 0.000| 0.000|   0.000|   0.000|

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
| 0.15| 0.15| 0.15| 0.12| 0.16| 0.14|    0.14|    0.15|


$n_{min}$  

What is the minimum value of $n_{\nu}$, the number of observations from a given skewed $t$-distribution, we need to achieve the same degree of convergence as with $n_g=30$ observations from a Gaussian distribution with the same mean and standard deviation?


| vmr| vhr| pmr| phr| mmr| mhr| vmr_phr| vhr_pmr|
|---:|---:|---:|---:|---:|---:|-------:|-------:|
|  57|  54|  55|  48|  57|  51|      53|      57|



#### Fit statistics ranking  


Skewed $t$-distribution (sstd):  


|     m|ranking |     s|ranking |  PPCC|ranking |
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


|     m|ranking |     s|ranking |  PPCC|ranking |
|-----:|:-------|-----:|:-------|-----:|:-------|
| 0.011|mhr     | 0.019|pmr     | 0.981|phr     |
| 0.011|phr     | 0.022|mmr     | 0.979|vmr     |
| 0.011|vhr     | 0.026|vmr     | 0.978|vhr     |
| 0.010|vmr_phr | 0.026|vhr_pmr | 0.978|vmr_phr |
| 0.009|vhr_pmr | 0.027|vmr_phr | 0.978|mhr     |
| 0.009|vmr     | 0.029|phr     | 0.975|vhr_pmr |
| 0.008|mmr     | 0.030|mhr     | 0.974|mmr     |
| 0.007|pmr     | 0.033|vhr     | 0.971|pmr     |

Normal distribution:  


|     m|ranking |     s|ranking |  PPCC|ranking |
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




|        |     vmr|      vhr|    pmr|     phr|     mmr|     mhr| vmr_phr| vhr_pmr|
|:-------|-------:|--------:|------:|-------:|-------:|-------:|-------:|-------:|
|mc_m    |  393.84|   551.09| 369.09|  751.26|  375.07|  623.74|  543.46|  437.97|
|mc_s    |  167.82|   371.75| 108.16|  361.74|  130.47|  311.31|  240.07|  183.93|
|mc_min  |   11.50|    51.29|  93.49|   84.41|   74.10|   68.70|   73.13|   34.79|
|mc_max  | 1514.87| 23012.49| 978.92| 4783.13| 1322.92| 3314.49| 2511.39| 1828.16|
|dao_pct |    0.00|     0.00|   0.00|    0.00|    0.00|    0.00|    0.00|    0.00|
|dai_pct |    0.30|     0.31|   0.02|    0.01|    0.13|    0.09|    0.02|    0.15|


Standardized $t$-distribution (std):  




|        |     vmr|      vhr|     pmr|     phr|     mmr|     mhr| vmr_phr| vhr_pmr|
|:-------|-------:|--------:|-------:|-------:|-------:|-------:|-------:|-------:|
|mc_m    |  898.35|  1531.03|  620.18| 1506.67|  775.98| 1601.63| 1255.34| 1030.32|
|mc_s    |  365.51|   858.22|  189.26|  710.07|  279.44|  806.08|  553.56|  435.55|
|mc_min  |   51.19|    65.32|  135.06|  186.28|  177.70|  259.10|  179.27|  173.78|
|mc_max  | 3935.03| 19786.04| 4360.03| 8939.93| 4031.82| 9340.36| 4975.39| 7608.44|
|dao_pct |    0.00|     0.00|    0.00|    0.00|    0.00|    0.00|    0.00|    0.00|
|dai_pct |    0.01|     0.01|    0.00|    0.00|    0.00|    0.00|    0.00|    0.00|


Normal distribution:  




|        |     vmr|     vhr|    pmr|     phr|     mmr|     mhr| vmr_phr| vhr_pmr|
|:-------|-------:|-------:|------:|-------:|-------:|-------:|-------:|-------:|
|mc_m    |  443.09|  624.11| 364.09|  786.04|  401.94|  701.99|  605.00|  483.86|
|mc_s    |  171.77|  314.07|  97.72|  358.29|  130.51|  330.89|  256.79|  188.82|
|mc_min  |   97.61|   84.92| 134.97|  116.33|  131.33|  140.54|  101.53|  113.51|
|mc_max  | 1715.68| 3496.08| 861.64| 3501.49| 1229.30| 2990.84| 2338.73| 1987.37|
|dao_pct |    0.00|    0.00|   0.00|    0.00|    0.00|    0.00|    0.00|    0.00|
|dai_pct |    0.02|    0.03|   0.00|    0.00|    0.00|    0.00|    0.00|    0.00|


#### Ranking  


Skewed $t$-distribution (sstd):  


|   mc_m|ranking |   mc_s|ranking | mc_min|ranking |   mc_max|ranking | dao_pct|ranking | dai_pct|ranking |
|------:|:-------|------:|:-------|------:|:-------|--------:|:-------|-------:|:-------|-------:|:-------|
| 751.26|phr     | 108.16|pmr     |  93.49|pmr     | 23012.49|vhr     |       0|vmr     |    0.01|phr     |
| 623.74|mhr     | 130.47|mmr     |  84.41|phr     |  4783.13|phr     |       0|vhr     |    0.02|pmr     |
| 551.09|vhr     | 167.82|vmr     |  74.10|mmr     |  3314.49|mhr     |       0|pmr     |    0.02|vmr_phr |
| 543.46|vmr_phr | 183.93|vhr_pmr |  73.13|vmr_phr |  2511.39|vmr_phr |       0|phr     |    0.09|mhr     |
| 437.97|vhr_pmr | 240.07|vmr_phr |  68.70|mhr     |  1828.16|vhr_pmr |       0|mmr     |    0.13|mmr     |
| 393.84|vmr     | 311.31|mhr     |  51.29|vhr     |  1514.87|vmr     |       0|mhr     |    0.15|vhr_pmr |
| 375.07|mmr     | 361.74|phr     |  34.79|vhr_pmr |  1322.92|mmr     |       0|vmr_phr |    0.30|vmr     |
| 369.09|pmr     | 371.75|vhr     |  11.50|vmr     |   978.92|pmr     |       0|vhr_pmr |    0.31|vhr     |


Standardized $t$-distribution (std):  


|    mc_m|ranking |   mc_s|ranking | mc_min|ranking |   mc_max|ranking | dao_pct|ranking | dai_pct|ranking |
|-------:|:-------|------:|:-------|------:|:-------|--------:|:-------|-------:|:-------|-------:|:-------|
| 1601.63|mhr     | 189.26|pmr     | 259.10|mhr     | 19786.04|vhr     |       0|vmr     |    0.00|pmr     |
| 1531.03|vhr     | 279.44|mmr     | 186.28|phr     |  9340.36|mhr     |       0|vhr     |    0.00|phr     |
| 1506.67|phr     | 365.51|vmr     | 179.27|vmr_phr |  8939.93|phr     |       0|pmr     |    0.00|mmr     |
| 1255.34|vmr_phr | 435.55|vhr_pmr | 177.70|mmr     |  7608.44|vhr_pmr |       0|phr     |    0.00|mhr     |
| 1030.32|vhr_pmr | 553.56|vmr_phr | 173.78|vhr_pmr |  4975.39|vmr_phr |       0|mmr     |    0.00|vmr_phr |
|  898.35|vmr     | 710.07|phr     | 135.06|pmr     |  4360.03|pmr     |       0|mhr     |    0.00|vhr_pmr |
|  775.98|mmr     | 806.08|mhr     |  65.32|vhr     |  4031.82|mmr     |       0|vmr_phr |    0.01|vmr     |
|  620.18|pmr     | 858.22|vhr     |  51.19|vmr     |  3935.03|vmr     |       0|vhr_pmr |    0.01|vhr     |


Normal distribution:  


|   mc_m|ranking |   mc_s|ranking | mc_min|ranking |  mc_max|ranking | dao_pct|ranking | dai_pct|ranking |
|------:|:-------|------:|:-------|------:|:-------|-------:|:-------|-------:|:-------|-------:|:-------|
| 786.04|phr     |  97.72|pmr     | 140.54|mhr     | 3501.49|phr     |       0|vmr     |    0.00|pmr     |
| 701.99|mhr     | 130.51|mmr     | 134.97|pmr     | 3496.08|vhr     |       0|vhr     |    0.00|phr     |
| 624.11|vhr     | 171.77|vmr     | 131.33|mmr     | 2990.84|mhr     |       0|pmr     |    0.00|mmr     |
| 605.00|vmr_phr | 188.82|vhr_pmr | 116.33|phr     | 2338.73|vmr_phr |       0|phr     |    0.00|mhr     |
| 483.86|vhr_pmr | 256.79|vmr_phr | 113.51|vhr_pmr | 1987.37|vhr_pmr |       0|mmr     |    0.00|vmr_phr |
| 443.09|vmr     | 314.07|vhr     | 101.53|vmr_phr | 1715.68|vmr     |       0|mhr     |    0.00|vhr_pmr |
| 401.94|mmr     | 330.89|mhr     |  97.61|vmr     | 1229.30|mmr     |       0|vmr_phr |    0.02|vmr     |
| 364.09|pmr     | 358.29|phr     |  84.92|vhr     |  861.64|pmr     |       0|vhr_pmr |    0.03|vhr     |



# Compare Gaussian and skewed t-distribution fits

## Gaussian vs skewed t



Probability in percent that the smallest and largest (respectively) observed return for each fund was generated by a normal distribution:

|              |   vmr|   vhr|   pmr|   phr|   mmr|   mhr| vmr_phr| vhr_pmr|
|:-------------|-----:|-----:|-----:|-----:|-----:|-----:|-------:|-------:|
|P_norm(X_min) | 0.000| 0.000| 0.000| 0.000| 0.000| 0.000|   0.000|   0.000|
|P_norm(X_max) | 0.546| 0.580| 1.599| 0.796| 1.161| 0.746|   0.793|   0.903|
|P_t(X_min)    | 0.556| 0.523| 0.342| 0.387| 0.476| 0.443|   0.433|   0.499|
|P_t(X_max)    | 0.448| 0.469| 1.135| 0.614| 0.739| 0.518|   0.543|   0.613|

Average number of years between min or max events (respectively):

|                      |        vmr|        vhr|         pmr|        phr|        mmr|        mhr|    vmr_phr|    vhr_pmr|
|:---------------------|----------:|----------:|-----------:|----------:|----------:|----------:|----------:|----------:|
|norm: avg yrs btw min | 375090.326| 344496.266| 2151333.384| 457015.684| 898933.995| 474181.557| 513324.185| 695394.732|
|norm: avg yrs btw max |    183.096|    172.426|      62.528|    125.687|     86.141|    134.124|    126.139|    110.720|
|t: avg yrs btw min    |    179.836|    191.230|     292.412|    258.492|    209.940|    225.743|    230.914|    200.219|
|t: avg yrs btw max    |    223.334|    213.054|      88.115|    162.868|    135.275|    192.893|    184.323|    163.056|


### Lilliefors test  






p-values for Lilliefors test.  
Testing $H_0$, that log-returns are Gaussian.


|        | vmr| vhr| pmr| phr| mmr|   mhr| vmr_phr| vhr_pmr|
|:-------|---:|---:|---:|---:|---:|-----:|-------:|-------:|
|p value |   0|   0|   0|   0|   0| 0.001|   0.001|       0|



### Wittgenstein's Ruler  


For different given probabilities that returns are Gaussian, what is the probability that the distribution is Gaussian rather than skewed t-distributed, given the smallest/largest observed log-returns?

Conditional probabilities for smallest observed log-returns:

![](pension-returns_monthly_files/figure-html/unnamed-chunk-238-1.png)<!-- -->


Use $1 - \text{p-value}$ from Lilliefors test as prior probability that the distribution is Gaussian.  
$x_{\text{obs}} = \min(x)$ and $P[\text{Event}\ |\ \text{Gaussian}] = P_{\text{Gauss}}[X \leq x_{\text{min}}]$:




|                      |   vmr|  vhr|   pmr|  phr|   mmr|   mhr| vmr_phr| vhr_pmr|
|:---------------------|-----:|----:|-----:|----:|-----:|-----:|-------:|-------:|
|Lillie p-val          | 0.000| 0.00| 0.000| 0.00| 0.000| 0.001|   0.001|   0.000|
|Prior prob            | 1.000| 1.00| 1.000| 1.00| 1.000| 0.999|   0.999|   1.000|
|P[Gauss &#124; Event] | 0.838| 0.82| 0.768| 0.69| 0.815| 0.486|   0.418|   0.965|



Use $1 - \text{p-value}$ from Lilliefors test as prior probability that the distribution is Gaussian.  
$x_{\text{obs}} = \max(x)$ and $P[\text{Event}\ |\ \text{Gaussian}] = P_{\text{Gauss}}[X \geq x_{\text{max}}]$:

![](pension-returns_monthly_files/figure-html/unnamed-chunk-241-1.png)<!-- -->




|                      | vmr| vhr| pmr| phr| mmr|   mhr| vmr_phr| vhr_pmr|
|:---------------------|---:|---:|---:|---:|---:|-----:|-------:|-------:|
|Lillie p-val          |   0|   0|   0|   0|   0| 0.001|   0.001|       0|
|Prior prob            |   1|   1|   1|   1|   1| 0.999|   0.999|       1|
|P[Gauss &#124; Event] |   1|   1|   1|   1|   1| 1.000|   1.000|       1|


# Velliv medium risk (vmr), June 2012 - April 2024




## QQ Plot

Skewed $t$-distribution (sstd):  

![](pension-returns_monthly_files/figure-html/unnamed-chunk-328-1.png)<!-- -->



## Data vs fit

Let's plot the fit and the observed returns together.  

![](pension-returns_monthly_files/figure-html/unnamed-chunk-329-1.png)<!-- -->



## Estimated distribution

Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pension-returns_monthly_files/figure-html/unnamed-chunk-330-1.png)<!-- -->



## Monte Carlo



















Sorted portfolio index values for last period of all runs

![](pension-returns_monthly_files/figure-html/unnamed-chunk-335-1.png)<!-- -->


## Convergence

### Max vs sum

Max-vs-sum plots for the first four moments -- a ratio that doesn't fall toward zero flags
that moment as possibly non-existent (see "Max-sum plots" in the comparison report for what
this diagnostic tests). Panels by fitted distribution:

![](pension-returns_monthly_files/figure-html/unnamed-chunk-336-1.png)<!-- -->




### MC

![](pension-returns_monthly_files/figure-html/unnamed-chunk-337-1.png)<!-- -->


### IS

Skewed $t$-distribution with a normal proposal distribution.

![](pension-returns_monthly_files/figure-html/unnamed-chunk-338-1.png)<!-- -->

Parameters

```
## [1] 1.4575522 0.4135162
```

Objective function plots

![](pension-returns_monthly_files/figure-html/unnamed-chunk-340-1.png)<!-- -->





# Velliv high risk (vhr), June 2012 - April 2024




## QQ Plot

Skewed $t$-distribution (sstd):  

![](pension-returns_monthly_files/figure-html/unnamed-chunk-357-1.png)<!-- -->



## Data vs fit

Let's plot the fit and the observed returns together.  

![](pension-returns_monthly_files/figure-html/unnamed-chunk-358-1.png)<!-- -->



## Estimated distribution

Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pension-returns_monthly_files/figure-html/unnamed-chunk-359-1.png)<!-- -->



## Monte Carlo



















Sorted portfolio index values for last period of all runs

![](pension-returns_monthly_files/figure-html/unnamed-chunk-364-1.png)<!-- -->


## Convergence

### Max vs sum

Max-vs-sum plots for the first four moments -- a ratio that doesn't fall toward zero flags
that moment as possibly non-existent (see "Max-sum plots" in the comparison report for what
this diagnostic tests). Panels by fitted distribution:

![](pension-returns_monthly_files/figure-html/unnamed-chunk-365-1.png)<!-- -->




### MC

![](pension-returns_monthly_files/figure-html/unnamed-chunk-366-1.png)<!-- -->


### IS

Skewed $t$-distribution with a normal proposal distribution.

![](pension-returns_monthly_files/figure-html/unnamed-chunk-367-1.png)<!-- -->

Parameters

```
## [1] 1.8343283 0.5082016
```

Objective function plots

![](pension-returns_monthly_files/figure-html/unnamed-chunk-369-1.png)<!-- -->





# PFA medium risk (pmr), June 2012 - April 2024




## QQ Plot

Skewed $t$-distribution (sstd):  

![](pension-returns_monthly_files/figure-html/unnamed-chunk-386-1.png)<!-- -->



## Data vs fit

Let's plot the fit and the observed returns together.  

![](pension-returns_monthly_files/figure-html/unnamed-chunk-387-1.png)<!-- -->



## Estimated distribution

Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pension-returns_monthly_files/figure-html/unnamed-chunk-388-1.png)<!-- -->



## Monte Carlo



















Sorted portfolio index values for last period of all runs

![](pension-returns_monthly_files/figure-html/unnamed-chunk-393-1.png)<!-- -->


## Convergence

### Max vs sum

Max-vs-sum plots for the first four moments -- a ratio that doesn't fall toward zero flags
that moment as possibly non-existent (see "Max-sum plots" in the comparison report for what
this diagnostic tests). Panels by fitted distribution:

![](pension-returns_monthly_files/figure-html/unnamed-chunk-394-1.png)<!-- -->




### MC

![](pension-returns_monthly_files/figure-html/unnamed-chunk-395-1.png)<!-- -->


### IS

Skewed $t$-distribution with a normal proposal distribution.

![](pension-returns_monthly_files/figure-html/unnamed-chunk-396-1.png)<!-- -->

Parameters

```
## [1] 1.3478515 0.2887121
```

Objective function plots

![](pension-returns_monthly_files/figure-html/unnamed-chunk-398-1.png)<!-- -->





# PFA high risk (phr), June 2012 - April 2024




## QQ Plot

Skewed $t$-distribution (sstd):  

![](pension-returns_monthly_files/figure-html/unnamed-chunk-415-1.png)<!-- -->



## Data vs fit

Let's plot the fit and the observed returns together.  

![](pension-returns_monthly_files/figure-html/unnamed-chunk-416-1.png)<!-- -->



## Estimated distribution

Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pension-returns_monthly_files/figure-html/unnamed-chunk-417-1.png)<!-- -->



## Monte Carlo






phr has the sstd fit with the highest sstd fit with thevalue of nu. Compare with other distributions:





![](pension-returns_monthly_files/figure-html/unnamed-chunk-419-1.png)<!-- -->

![](pension-returns_monthly_files/figure-html/unnamed-chunk-420-1.png)<!-- -->

![](pension-returns_monthly_files/figure-html/unnamed-chunk-421-1.png)<!-- -->


Sorted portfolio index values for last period of all runs

![](pension-returns_monthly_files/figure-html/unnamed-chunk-422-1.png)<!-- -->


## Convergence

### Max vs sum

Max-vs-sum plots for the first four moments -- a ratio that doesn't fall toward zero flags
that moment as possibly non-existent (see "Max-sum plots" in the comparison report for what
this diagnostic tests). Panels by fitted distribution:

![](pension-returns_monthly_files/figure-html/unnamed-chunk-423-1.png)<!-- -->




### MC

![](pension-returns_monthly_files/figure-html/unnamed-chunk-424-1.png)<!-- -->


### IS

Skewed $t$-distribution with a normal proposal distribution.

![](pension-returns_monthly_files/figure-html/unnamed-chunk-425-1.png)<!-- -->

Parameters

```
## [1] 2.1231707 0.4591479
```

Objective function plots

![](pension-returns_monthly_files/figure-html/unnamed-chunk-427-1.png)<!-- -->





# Mix medium risk (mmr), June 2012 - April 2024




## QQ Plot

Skewed $t$-distribution (sstd):  

![](pension-returns_monthly_files/figure-html/unnamed-chunk-444-1.png)<!-- -->



## Data vs fit

Let's plot the fit and the observed returns together.  

![](pension-returns_monthly_files/figure-html/unnamed-chunk-445-1.png)<!-- -->



## Estimated distribution

Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pension-returns_monthly_files/figure-html/unnamed-chunk-446-1.png)<!-- -->



## Monte Carlo








mmr has the sstd fit with the lowest value of nu. Compare with other distributions:



![](pension-returns_monthly_files/figure-html/unnamed-chunk-448-1.png)<!-- -->

![](pension-returns_monthly_files/figure-html/unnamed-chunk-449-1.png)<!-- -->

![](pension-returns_monthly_files/figure-html/unnamed-chunk-450-1.png)<!-- -->


Sorted portfolio index values for last period of all runs

![](pension-returns_monthly_files/figure-html/unnamed-chunk-451-1.png)<!-- -->


## Convergence

### Max vs sum

Max-vs-sum plots for the first four moments -- a ratio that doesn't fall toward zero flags
that moment as possibly non-existent (see "Max-sum plots" in the comparison report for what
this diagnostic tests). Panels by fitted distribution:

![](pension-returns_monthly_files/figure-html/unnamed-chunk-452-1.png)<!-- -->




### MC

![](pension-returns_monthly_files/figure-html/unnamed-chunk-453-1.png)<!-- -->


### IS

Skewed $t$-distribution with a normal proposal distribution.

![](pension-returns_monthly_files/figure-html/unnamed-chunk-454-1.png)<!-- -->

Parameters

```
## [1] 1.3801769 0.3404913
```

Objective function plots

![](pension-returns_monthly_files/figure-html/unnamed-chunk-456-1.png)<!-- -->





# Mix high risk (mhr), June 2012 - April 2024




## QQ Plot

Skewed $t$-distribution (sstd):  

![](pension-returns_monthly_files/figure-html/unnamed-chunk-473-1.png)<!-- -->



## Data vs fit

Let's plot the fit and the observed returns together.  

![](pension-returns_monthly_files/figure-html/unnamed-chunk-474-1.png)<!-- -->



## Estimated distribution

Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pension-returns_monthly_files/figure-html/unnamed-chunk-475-1.png)<!-- -->



## Monte Carlo



















Sorted portfolio index values for last period of all runs

![](pension-returns_monthly_files/figure-html/unnamed-chunk-480-1.png)<!-- -->


## Convergence

### Max vs sum

Max-vs-sum plots for the first four moments -- a ratio that doesn't fall toward zero flags
that moment as possibly non-existent (see "Max-sum plots" in the comparison report for what
this diagnostic tests). Panels by fitted distribution:

![](pension-returns_monthly_files/figure-html/unnamed-chunk-481-1.png)<!-- -->




### MC

![](pension-returns_monthly_files/figure-html/unnamed-chunk-482-1.png)<!-- -->


### IS

Skewed $t$-distribution with a normal proposal distribution.

![](pension-returns_monthly_files/figure-html/unnamed-chunk-483-1.png)<!-- -->

Parameters

```
## [1] 1.9450423 0.4749438
```

Objective function plots

![](pension-returns_monthly_files/figure-html/unnamed-chunk-485-1.png)<!-- -->





# Mix vmr+phr (vm_ph), June 2012 - April 2024




## QQ Plot

Skewed $t$-distribution (sstd):  

![](pension-returns_monthly_files/figure-html/unnamed-chunk-502-1.png)<!-- -->



## Data vs fit

Let's plot the fit and the observed returns together.  

![](pension-returns_monthly_files/figure-html/unnamed-chunk-503-1.png)<!-- -->



## Estimated distribution

Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pension-returns_monthly_files/figure-html/unnamed-chunk-504-1.png)<!-- -->



## Monte Carlo



















Sorted portfolio index values for last period of all runs

![](pension-returns_monthly_files/figure-html/unnamed-chunk-509-1.png)<!-- -->


## Convergence

### Max vs sum

Max-vs-sum plots for the first four moments -- a ratio that doesn't fall toward zero flags
that moment as possibly non-existent (see "Max-sum plots" in the comparison report for what
this diagnostic tests). Panels by fitted distribution:

![](pension-returns_monthly_files/figure-html/unnamed-chunk-510-1.png)<!-- -->




### MC

![](pension-returns_monthly_files/figure-html/unnamed-chunk-511-1.png)<!-- -->


### IS

Skewed $t$-distribution with a normal proposal distribution.

![](pension-returns_monthly_files/figure-html/unnamed-chunk-512-1.png)<!-- -->

Parameters

```
## [1] 1.7833719 0.4233113
```

Objective function plots

![](pension-returns_monthly_files/figure-html/unnamed-chunk-514-1.png)<!-- -->





# Mix vhr+pmr (mh_pm), June 2012 - April 2024




## QQ Plot

Skewed $t$-distribution (sstd):  

![](pension-returns_monthly_files/figure-html/unnamed-chunk-531-1.png)<!-- -->



## Data vs fit

Let's plot the fit and the observed returns together.  

![](pension-returns_monthly_files/figure-html/unnamed-chunk-532-1.png)<!-- -->



## Estimated distribution

Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pension-returns_monthly_files/figure-html/unnamed-chunk-533-1.png)<!-- -->



## Monte Carlo



















Sorted portfolio index values for last period of all runs

![](pension-returns_monthly_files/figure-html/unnamed-chunk-538-1.png)<!-- -->


## Convergence

### Max vs sum

Max-vs-sum plots for the first four moments -- a ratio that doesn't fall toward zero flags
that moment as possibly non-existent (see "Max-sum plots" in the comparison report for what
this diagnostic tests). Panels by fitted distribution:

![](pension-returns_monthly_files/figure-html/unnamed-chunk-539-1.png)<!-- -->




### MC

![](pension-returns_monthly_files/figure-html/unnamed-chunk-540-1.png)<!-- -->


### IS

Skewed $t$-distribution with a normal proposal distribution.

![](pension-returns_monthly_files/figure-html/unnamed-chunk-541-1.png)<!-- -->

Parameters

```
## [1] 1.560453 0.406833
```

Objective function plots

![](pension-returns_monthly_files/figure-html/unnamed-chunk-543-1.png)<!-- -->


# Velliv medium risk (vmr), June 2012 - April 2024




## QQ Plot

Skewed $t$-distribution (sstd):  

![](pension-returns_monthly_files/figure-html/unnamed-chunk-561-1.png)<!-- -->



## Data vs fit

Let's plot the fit and the observed returns together.  

![](pension-returns_monthly_files/figure-html/unnamed-chunk-562-1.png)<!-- -->



## Estimated distribution

Now lets look at the CDF of the estimated distribution for each 0.1% increment between 0.5% and 99.5% for the estimated distribution:

![](pension-returns_monthly_files/figure-html/unnamed-chunk-563-1.png)<!-- -->



## Monte Carlo



















Sorted portfolio index values for last period of all runs

![](pension-returns_monthly_files/figure-html/unnamed-chunk-568-1.png)<!-- -->


## Convergence

### Max vs sum

Max-vs-sum plots for the first four moments -- a ratio that doesn't fall toward zero flags
that moment as possibly non-existent (see "Max-sum plots" in the comparison report for what
this diagnostic tests). Panels by fitted distribution:

![](pension-returns_monthly_files/figure-html/unnamed-chunk-569-1.png)<!-- -->




### MC

![](pension-returns_monthly_files/figure-html/unnamed-chunk-570-1.png)<!-- -->


### IS

Skewed $t$-distribution with a normal proposal distribution.

![](pension-returns_monthly_files/figure-html/unnamed-chunk-571-1.png)<!-- -->

Parameters

```
## [1] 1.4575522 0.4135162
```

Objective function plots

![](pension-returns_monthly_files/figure-html/unnamed-chunk-573-1.png)<!-- -->


# Findings

With the data deliberately frozen, we can interpret a fixed set of estimates rather
than chase a moving target. We present the salient results, analyse them against the
theory that motivates the study, and draw out the implications.

## 1. The plans are weighted blends of the same two funds

*Result.* A principal component analysis of the four plans gives a first component that
explains 97.7% of the variance and loads almost equally on all four, with the first two
components together at 99.4%. Within each provider the high-risk plan is a scalar multiple of
the medium-risk plan in log returns, with slope 1.26 for Velliv and 1.60 for PFA, intercept
near zero, and $R^2$ of 0.994 and 0.955. Correlations run from 0.95 across providers to 0.997
within Velliv. For PFA the two building blocks recovered from profiles B and D, the high-risk
fund as $D$ and the low-risk fund as $2B-D$, are only moderately correlated (0.59) and differ
several-fold in volatility (ratio 3.1).

*Analysis.* The single dominant component is an empirical result: the four plans are, to a
close approximation, one common factor seen at four exposures, and the within-provider scaling
is the special case of this. The further statement that PFA's profiles are blends of exactly
two funds, with the high-risk fund equal to $D$ and the low-risk fund equal to $2B-D$, rests
on PFA's stated profile weights rather than on the data, which only confirm that the recovered
low-risk fund is coherent. PFA states that profile B is a 50/50 blend of its high- and
low-risk funds and profile D is the high-risk fund alone, so the profiles are fixed affine
combinations of the same two funds.

*Implication.* The investor's first decision within a provider is how much of one factor to
hold, not which portfolio.

## 2. "Risk" is leverage on that factor, and within a provider there is nothing to optimise

*Result.* Because the slope exceeds 1 with near-zero intercept, the high-risk plan amplifies
the common factor symmetrically: higher average growth, but deeper drawdowns (worst monthly
peak-to-trough 17.3% against 15.2% for Velliv, 15.9% against 11.9% for PFA) and
underperformance in flat or falling markets. The much-noted fact that the cumulative high-risk
path never dips below the medium-risk path holds only for an index started at the 2012 low.
Rebased to the eve of the COVID drawdown, the high plan trails the medium plan for about nine
months. The reward-to-risk ratio is near-constant along the menu: the high-plan Sharpe equals
the medium-plan Sharpe times their correlation, so Velliv (correlation 0.997) is a
near-perfect leverage ray and PFA (0.977) bends by about two percent. That bend, and the
medium-to-high Sharpe gap, are well inside one standard error.

*Analysis.* With the high plan a scaled version of the medium plan in log returns, it lies
below the medium plan exactly over windows in which the medium plan is below its entry value.
Non-crossing is a property of the entry date relative to the cycle, not of the plans. The
near-constant Sharpe is the same scaling seen as reward per unit of risk, a leverage ray
rather than a curve with a best point to locate.

*Implication.* The risk level is a pure risk-appetite decision. There is no identifiable
best-Sharpe blend to chase, in added risk or in fees.

## 3. The body of the distribution is estimable; the tail is not

This is the methodological core. We fit a four-parameter Fernández-Steel skewed Student-t,
with location m, scale s, tail index nu, and skew xi. The parameters split sharply by how much
data they require.

*The location and scale are estimable.* The mean and scale have small relative standard
errors, comparable to what a Gaussian of the same moments would give. For vmr the monthly mean
is 0.005 with standard error 0.0022, so the positive drift is real.

*The tail and skew are the hard parameters, and they carry the risk.* The tail index runs 3.3
to 4.0 monthly, with relative standard errors of 34% to 38% and a 95% interval for vmr of
roughly [1.1, 5.7]. That interval straddles nu = 2, below which the variance ceases to exist,
and nu = 4, below which the kurtosis does. The skew runs 0.70 to 0.77 with an interval lying
entirely below 1, about 3.5 standard errors from symmetry. The left skew is statistically
established; the tail index is not pinned down. The annual report, with 13 observations,
cannot identify nu at all: the information matrix is singular for three of the four plans, and
xi is driven to a degenerate corner.

*Analysis, why nu and xi are hard while m is easy.* The Gaussian has only m and s. The t adds
nu and xi, which govern the tail and have no Gaussian counterpart, so the entire data burden
lives in them. Taleb's recommended workflow is to estimate the tail exponent by maximum
likelihood and then derive the mean analytically by plug-in, because the tail exponent
captures the low-probability deviations better than the sample mean does. The catch is that
plug-in presupposes an estimable nu, which we have at best loosely monthly and not at all
annually. The convergence metric kappa makes the asymmetry precise: for these fits kappa is
about 0.14, so matching the convergence of 30 Gaussian observations takes about 55
observations of the fitted t, a threshold the 142 monthly points clear. That metric concerns
the mean. The tail parameters are harder still, so an adequately converged mean is a floor,
not a guarantee, for the tail.

*Implication.* The direction of the tail, fat and left-skewed, is robust where we have power.
Its magnitude is not pinned down even monthly.

## 4. The departure from the Gaussian is real and lies in the tail

*Result.* AIC and BIC both prefer the skewed-t for every fund, but those criteria, like the
probability-plot correlation, weigh the body. The tail-weighted Anderson-Darling test, with
bootstrap p-values, rejects the normal (p at most 0.002) and the symmetric-t (p 0.002 to
0.010) for every fund, and fails to reject only the skewed-t. The skew, not merely fat tails,
is needed. Lilliefors rejects normality outright (p near zero). Under a fitted Gaussian the
smallest observed monthly return is effectively impossible, recurring once every 400,000 to
2,000,000 years against once every roughly 180 to 290 years under the skewed-t. We cannot
confirm finite variance, since the nu interval includes nu < 2 for every fund, and for nu at
or below 2 the sample standard deviation does not converge and E[100 e^X] is undefined.

*Analysis.* The probability-plot correlation, reported as PPCC, is a statement about the body,
and a high value does not validate the tail. The max-sum plots ask the prior question of
whether the relevant moments exist at all, and read together with the wide nu interval they
leave finite variance unconfirmed. The variance-based statistics, and the symmetric-t
simulation, therefore rest on an assumption the data cannot secure.

*Implication.* Any Gaussian or variance-based risk number understates the downside that
matters.

## 5. The simulated wealth distribution is the core result, and the distribution choice governs it

*Result.* The Monte Carlo simulations of accumulated wealth are the central output, and they
hinge on the estimated tail parameters diagnosed above. Simulated over twenty years as a
single black-box fit per series, the probability of finishing below the starting value is
about 0.30 for the Velliv plans under the skewed-t, against 0.01 to 0.02 under the symmetric-t
or the normal. PFA's plans stay near 0.01 to 0.02 under all three, helped by a higher
reward-to-risk ratio. The worst simulated Velliv-medium path falls close to a tenth of its
starting value.

*Analysis.* The driver is the established left skew interacting with Velliv's higher
volatility. The symmetric models hide a downside that the better-fitting and statistically
established skew reveals. The shape of the wealth distribution is itself worth stating: it is
right-skewed and bounded below at zero, even though the log-return distribution that generates
it is left-skewed and unbounded. Because wealth is $100\,e^{R}$, exponentiating never produces
a negative value, so the heavy left tail in log space becomes a cluster of paths near zero
rather than a set of negative balances. The same bound is why the plans behave like log-return
scaling rather than constant financial leverage: they are long-only blends whose weights sum
to one, so they cannot be wiped out.

*Implication.* We report the skewed-t outcome as the operative one. These results carry over
to the investor-facing analysis, where the choice between risk levels and across providers is
made.

## 6. A precautionary reading, and the bottom line

*The asymmetry of the inference.* The fits are heavy-left-skewed with a small positive mean, a
shape that predicts losses worse than any yet observed, and the benign, low-rate, bull-market
sample has not delivered them. One could object that more data might instead reveal large
upside, symmetrising the fit and thinning the tail. Two considerations weigh against that
hope. Taleb's escape, to stay home when no reliable estimator exists, is unavailable for a
compulsory pension, and his qualifier, that one may still take risky decisions if bounded for
maximum losses, does not apply because a pension is not bounded that way. And the sample is a
single regime, more likely to understate than overstate the tail.

*A speculative but coherent mechanism.* The observed shape, a left skew with a positive mean,
is what a return-capping design would produce. Trimming large gains while leaving the
occasional large loss to be booked as chance pushes the mean up. We cannot establish design
from the data, but the shape is consistent with it, and prudence argues for taking the heavy
left skew at face value until evidence says otherwise.

*The cost of this precaution.* Assuming a heavier left tail also raises the apparent value of
diversifying across the two providers, since the tail-softening from holding both is larger
the fatter the assumed idiosyncratic tail. Precaution here is therefore not free, and the
trade-off is properly weighed in the investor-facing analysis.

*Bottom line.* Qualitatively the conclusions are firm: the plans are leverage on one factor,
the tails are fat and left-skewed, drawdowns are asymmetric, and path-dominance is a
starting-point artefact. Quantitatively, the mean, the scale, and the direction of the skew
are established monthly, but the tail index is not pinned down at 142 observations and is
unidentified at 13. Because the simulated wealth distribution turns on that tail, and because
"staying home" is not an option, we treat the distribution as heavily left-skewed while
flagging that this stance may overstate the benefit of diversifying across providers.

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
## m(data_x): -0.01246035 
## s(data_x): 0.3284963 
## m(data_y): 10.66759 
## s(data_y): 2.71343 
## 
## m(data_x + data_y): 5.327564 
## s(data_x + data_y): 1.337732
```

m and s of final state of all paths.\
`_a` is mix of simulated returns.\
`_b` is simulated mixed returns.


|     m_a|     m_b|   s_a|   s_b|
|-------:|-------:|-----:|-----:|
| 106.829| 106.496| 6.262| 5.941|
| 106.330| 106.519| 6.021| 5.994|
| 106.865| 106.744| 6.079| 5.823|
| 106.468| 106.781| 6.159| 5.926|
| 106.954| 106.668| 6.305| 5.949|
| 106.668| 106.671| 6.081| 5.851|
| 106.378| 106.176| 6.195| 6.007|
| 106.334| 106.547| 6.379| 5.803|
| 106.424| 106.546| 6.025| 6.092|
| 106.804| 106.467| 6.027| 5.970|


```
##       m_a             m_b             s_a             s_b       
##  Min.   :106.3   Min.   :106.2   Min.   :6.021   Min.   :5.803  
##  1st Qu.:106.4   1st Qu.:106.5   1st Qu.:6.040   1st Qu.:5.869  
##  Median :106.6   Median :106.5   Median :6.120   Median :5.945  
##  Mean   :106.6   Mean   :106.6   Mean   :6.153   Mean   :5.936  
##  3rd Qu.:106.8   3rd Qu.:106.7   3rd Qu.:6.245   3rd Qu.:5.988  
##  Max.   :107.0   Max.   :106.8   Max.   :6.379   Max.   :6.092
```

`_a` and `_b` are very close to equal.\
We attribute the differences to differences in estimating the
distributions in version a and b.

The final state is independent of the order of the preceding steps:

![](pension-returns_monthly_files/figure-html/unnamed-chunk-44-1.png)<!-- -->

So does the order of the steps in the two processes matter, when mixing
simulated returns?

![](pension-returns_monthly_files/figure-html/unnamed-chunk-45-1.png)<!-- -->

![](pension-returns_monthly_files/figure-html/unnamed-chunk-46-1.png)<!-- -->

The order of steps in the individual paths do not matter, because the
mix of simulated paths is a sum of a sum, so the order of terms doesn't
affect the sum. If there is variation it is because the sets preceding
steps are not the same. For instance, the steps between step 1 and 60 in
the plot above are not the same for the two lines.

Recall,
$$\text{Var}(aX+bY) = a^2 \text{Var}(X) + b^2 \text{Var}(Y) + 2ab \text{Cov}(a, b)$$


``` r
var(0.5 * data_df$vhr + 0.5 * data_df$phr)
```

```
## [1] 0.0008537742
```

``` r
0.5^2 * var(data_df$vhr) + 0.5^2 * var(data_df$phr) + 2 * 0.5 * 0.5 * cov(data_df$vhr, data_df$phr)
```

```
## [1] 0.0008537742
```

Our distribution estimate is based on 142 monthly observations. Is that
enough for a robust estimate? What if we suddenly hit a month like the
2008 crash? How would that affect our estimate?\
Let's try to include the Velliv data going back to 2007, which spans the GFC.\
We do this by sampling 142 observations from the long series `vmrl`
(`data_df_l$vmrl`, 207 monthly observations incl. 2007-2012).


```
##        m                  s          
##  Min.   :0.005517   Min.   :0.01670  
##  1st Qu.:0.006232   1st Qu.:0.01789  
##  Median :0.006550   Median :0.01861  
##  Mean   :0.006576   Mean   :0.01857  
##  3rd Qu.:0.006837   3rd Qu.:0.01919  
##  Max.   :0.007453   Max.   :0.02026
```

## The meaning of `xi`

The fit for `mhr` has the highest `xi` value of all. This suggests
right-skew:

![](pension-returns_monthly_files/figure-html/unnamed-chunk-49-1.png)<!-- -->

## Max vs sum plot

If the Law Of Large Numbers holds true,
$$\dfrac{\max (X_1^p, ..., X^p)}{\sum_{i=1}^n X_i^p} \rightarrow 0$$ for
$n \rightarrow \infty$.

If not, $X$ doesn't have a $p$'th moment.

See Taleb: The Statistical Consequences Of Fat Tails, p. 192


