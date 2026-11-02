---
title: "Choosing a pension plan: An investor's advanced decision tool"
author: Martin Hoshi Vognsen
output:
  html_document:
    toc: true
    toc_depth: 3
    keep_md: yes
  pdf_document:
    toc: true
    toc_depth: 3
    latex_engine: xelatex
date: "21:32 02 November 2026"
params:
  data_dir: latest         ## Folder under data/: "latest" (refreshed by src/fetch_latest_data.R) or "monthly" (the reports' frozen case study).
  start_date: null         ## NULL = use the full comparable window (latest genuine common start); else a later "YYYY-MM-DD".
  monitor_months: 36       ## Length (months) of the "recent" window for the structure check.
  balance: 1000000         ## Current balance (kr) the decision applies to.
  flat_fee_velliv: 984     ## Velliv's flat annual fee (kr): The VækstPension policy fee, 82 kr/month in 2025 (84 in 2026).
  flat_fee_pfa: 807        ## PFA's flat annual fee (kr): PFA Plus administration, a fixed amount, not a share of savings (2025).
  prop_rate_velliv: 0.0117 ## Velliv proportional cost (fraction of balance): Investment costs 0.94% (2025 ÅOP, Aktiv high risk) plus the variable administration, about 0.23%.
  prop_rate_pfa: 0.0028    ## PFA proportional cost (fraction of balance): Indirect investment costs, 0.28% ÅOP (2025).
  risk_free: 0.02          ## Annual risk-free rate (e.g. 0.03 for a 3% deposit).
  gamma: 2                 ## Relative risk aversion.
  horizon: 20              ## Decision horizon in years.
  assumed_nu: 3.5          ## Assumed skew-t tail index for the stress simulation.
  assumed_xi: 0.7          ## Assumed skew-t skew for the stress simulation.
---





# Purpose

This tool is the decision companion to the diagnostic report *Monthly pension returns analysis*, which serves as its technical appendix. That report establishes how each plan's returns are distributed and why the methods used below are the right ones; this tool applies them to your data and costs and turns them into the two decisions an investor actually faces:

1. **Which risk level** -- and is a higher-risk plan anything more than a more-leveraged
   version of a lower-risk one?
2. **One provider or both** -- is there diversification between PFA and Velliv, and could
   it plausibly beat the cost of splitting?

The returns reports' central caveat governs everything here: With about 13 years of
data and fat tails, point estimates (means, Sharpe ratios, correlations) are noisy and
regime-dependent. The tool is therefore built to expose *how robust* each conclusion is,
not to emit a single "best" plan. Returns are monthly, 161 months
(2012-07 to 2025-11). Sharpe ratios use the risk-free rate set in the inputs below.
The comparison needs both providers, so it ends at the last month both have published: Velliv's index runs to 2025-11 and PFA's returns to 2026-09.
PFA's profiles appear by letter: A to D are today's Forsigtig, Lav, Middel and Høj, from lowest to
highest risk.

# Inputs

Every figure below is computed from your data and these settings. Change them in the YAML header at
the top of this document, or pass them as render parameters.


Table: Current inputs. Sharpe ratios, certainty equivalents, fee break-evens and the stress simulation all read from these.

|setting                  |value                  |
|:------------------------|:----------------------|
|Data folder              |data/latest            |
|Balance (kr)             |1,000,000              |
|Flat fee, Velliv (kr/yr) |984                    |
|Flat fee, PFA (kr/yr)    |807                    |
|Proportional fee, Velliv |1.17%                  |
|Proportional fee, PFA    |0.28%                  |
|Risk-free rate (annual)  |2.0%                   |
|Risk aversion            |2                      |
|Horizon (years)          |20                     |
|Start date               |full comparable window |
|Monitor window (months)  |36                     |
|Assumed tail index       |3.5                    |
|Assumed skew             |0.7                    |

The flat fees are each provider's fixed yearly charge, paid whatever the balance. The proportional
fees scale with the balance and are mostly investment costs. Both providers publish returns after
investment costs, so that part is already inside every return figure below. The flat fees come on
top, and they drive the cost arithmetic of Section 4.

# 1. Current regime check

The reports' working model is a heavy-tailed, left-skewed return distribution. Before any
mean-variance figure can be trusted, check whether the loaded data still look that way or have
moved toward the Gaussian. A skewed-$t$ fit answers it: A high tail index $\nu$ with a skew $\xi$ near 1
is near-Gaussian; a low $\nu$, or a $\xi$ below 1, is heavy tails and left skew.


Table: Skewed-$t$ fit per plan on the loaded data. A low tail index (heavy tails) or a skew below 1 (left skew) is the reports' regime; a high tail index with skew near 1 is near-Gaussian.

|plan          |tail index $\nu$ |$\nu$ SE |skew $\xi$ |$\xi$ SE |
|:-------------|:----------------|:--------|:----------|:--------|
|Velliv medium |3.4              |1.1      |0.71       |0.08     |
|Velliv high   |3.5              |1.2      |0.72       |0.08     |
|PFA B         |3.8              |1.5      |0.76       |0.08     |
|PFA D         |4.1              |1.5      |0.73       |0.08     |

Across these plans the median tail index is 3.7 and the median skew is
0.72. That is firmly heavy-tailed, the regime the reports assume, so the mean-variance figures here are body-of-distribution summaries and the tail caveats stand.

The test is deliberately asymmetric. A single extreme month can reveal a fat tail; no stretch of
calm can prove its absence.



The latest month (2025-11) is within the fitted tails of every plan: No fresh tail signal, which on its own proves nothing.
Calling the regime Gaussian instead needs far more data than a benign stretch provides. The tail
parameters are not pinned down at 161 observations: By the reports' analysis, matching even
30 Gaussian observations for the *mean* takes on the order of
62 heavy-tailed observations, and the tail needs more
still. Treat a quiet tail as unproven, not safe.

# 2. Within a provider: Which risk level?

A higher-risk plan is *pure leverage* of a lower-risk one when it has the same
reward-to-risk (Sharpe) and the same distributional shape, only scaled. If so, choosing a
risk level is a pure risk-appetite dial with no consequence for return-per-unit-risk. We
test this with the Sharpe ratio of each plan and, crucially, its stability across
sub-periods.


Table: Annualised Sharpe ratio by plan and start date.

|                      | Velliv low| Velliv med| Velliv high| PFA A| PFA B| PFA C| PFA D|
|:---------------------|----------:|----------:|-----------:|-----:|-----:|-----:|-----:|
|from 2012-07  (n=161) |       0.59|       0.67|        0.68|  0.60|  0.78|  0.85|  0.86|
|from 2016-12  (n=108) |       0.45|       0.53|        0.54|  0.25|  0.52|  0.64|  0.68|
|from 2021-05  (n=55)  |       0.23|       0.32|        0.38|  0.00|  0.38|  0.59|  0.66|

The table samples three start dates. The plot below sweeps every start date that leaves at least
two years of data to the same fixed end, with 95% confidence bands. Look for whether a provider's
plans have overlapping bands: Where they do, the plans cannot be told apart on reward-per-risk.

![](pension-returns_investor_files/figure-html/sharpe-stability-1.png)<!-- -->

**Velliv.** The three plans' Sharpe ratios (around 0.6) span 0.08
against a sampling error of about 0.28. That spread is within
the noise, so on this data Velliv behaves as a leverage ray.
Choosing a Velliv risk level is then a pure risk-appetite decision, with nothing to optimise.

**PFA.** The four profiles' Sharpe ratios span 0.26 against a sampling error of
about 0.28, so the menu is, within the noise, also a single ray.
The highest-Sharpe profile is PFA D from every start date in the table.
But the spread is within the noise, so no best-Sharpe profile is reliably identifiable, and you should not pay, in added risk or in fees, to chase one.

The same test reads off the risk-return map. Each plan sits at its annualised volatility and mean
return; plans on one line from the risk-free rate share a Sharpe ratio, and a plan off that line
differs in reward-per-risk. Look for whether each provider's plans line up.

![](pension-returns_investor_files/figure-html/mean-var-plot-1.png)<!-- -->

The derivation of the ray and its sampling error is in the Sharpe ratio section of the diagnostic report.

# 3. Across providers: Is there diversification?


Table: Correlation matrix of monthly returns across all plans.

|            | Velliv low| Velliv med| Velliv high| PFA A| PFA B| PFA C| PFA D|
|:-----------|----------:|----------:|-----------:|-----:|-----:|-----:|-----:|
|Velliv low  |      1.000|      0.994|       0.985| 0.925| 0.966| 0.963| 0.955|
|Velliv med  |      0.994|      1.000|       0.997| 0.905| 0.961| 0.966| 0.964|
|Velliv high |      0.985|      0.997|       1.000| 0.882| 0.952| 0.966| 0.967|
|PFA A       |      0.925|      0.905|       0.882| 1.000| 0.969| 0.927| 0.898|
|PFA B       |      0.966|      0.961|       0.952| 0.969| 1.000| 0.991| 0.978|
|PFA C       |      0.963|      0.966|       0.966| 0.927| 0.991| 1.000| 0.996|
|PFA D       |      0.955|      0.964|       0.967| 0.898| 0.978| 0.996| 1.000|

The lowest pairwise correlation is 0.88.
Every pair moves closely together.
The least-correlated plans are **PFA A** and
**Velliv high**. For why the plans co-move, see the Path crossing section of the
diagnostic report.


Table: 50/50 cross-provider mixes: Correlation and volatility reduction vs the weighted-average volatility.

|                    |correlation |vol reduction |
|:-------------------|:-----------|:-------------|
|PFA A + Velliv high |0.882       |2.5%          |
|Velliv low + PFA D  |0.955       |1.1%          |
|Velliv high + PFA D |0.967       |0.8%          |
|Velliv med + PFA B  |0.961       |1.0%          |

The largest risk reduction among these cross-provider mixes is **PFA A + Velliv high**, at about
2.5% of volatility. That is small, a few percent, not a step change: Cross-provider diversification does something, but little, in mean-variance terms.
The reduction comes from pairing the least-correlated plans; the composition behind those
correlations is in the Path crossing section of the diagnostic report.

## The diversification that *does* work is within a provider

Splitting across providers pairs equity with equity. The diversification that actually
reduces risk is across *asset classes* -- bonds with equity -- and it lives inside a single
provider, harvested simply by choosing a risk level. PFA's profiles are fixed blends of two
building-block funds, which can be backed out of the returns: The equity fund is $H = D$ and the
bond-like fund is $L = (4A - D)/3$. Both are exact for simple returns, since A holds a quarter in
the equity fund and D all of it, and neither weight changed in PFA's 2025 restructuring. Comparing
the two kinds of 50/50 blend:


Table: Volatility reduction from a 50/50 blend: Within a provider (across asset classes) vs across providers (same risk level).

|blend                                                      | correlation|vol. reduction |
|:----------------------------------------------------------|-----------:|:--------------|
|Within PFA: Mid-risk plan                                  |        0.59|8%             |
|Across providers: Velliv-high + PFA-high (same risk level) |        0.97|1%             |

The within-provider blend correlates about 0.6 and cuts volatility
several times more than the cross-provider split.
A single provider's mid-risk plan is therefore already more diversified than two equity-heavy plans held across providers, at one set of fees, not two. The upshot, reinforcing Sections 2 and 5: Diversify by lowering your risk level within one provider, not by adding a second.

# 4. One provider or both: The cost

Fees split into two kinds, and only one bears on the *split* decision:

- **Proportional fees** (a percentage of assets under management). If both providers charge
  the same rate they are *split-neutral*: A rate $p$ on the whole pot costs the same whether it
  sits in one plan or two ($pW = pW_1 + pW_2$). Equal proportional fees therefore drop out of the
  one-vs-two decision entirely.
- **Flat fees** (a fixed kr/year administration charge, independent of balance). These are
  paid *per provider*, so a second provider adds its flat fee $F_2$ every year, however little
  you place there.

The split decision thus turns on flat fees -- weighed against the diversification benefit --
and, separately, on any *difference* in proportional rates between providers. Holding both
providers instead of one costs the flat fee of the one you would otherwise drop: kr
984 a year for Velliv and kr 807 for PFA. Both values
of $F_2$ are carried through below.

## Is the diversification worth a second flat fee?

Express the diversification benefit the way it actually accrues, as a boost to the **compound**
growth rate: The variance drain it removes,
$\Delta g = (\sigma^2_{\text{single}} - \sigma^2_{\text{split}})/2$, where $\sigma^2_{\text{single}}$
is the average variance of the two single plans. The diagnostic report derives this variance drain,
and the certainty equivalent used later in this section, from the return moments.



For a cross-provider same-risk split this is **0.9 basis points per
year** -- the entire "gain that compounds" from holding two providers. In kroner it is
$\Delta g \cdot W$, while the flat fee $F_2$ is paid every year regardless of $W$. The split pays only
above a break-even balance $W^* = F_2/\Delta g$:


Table: Balance above which the cross-provider diversification covers a second provider's flat fee. The rows marked with a provider are its flat fee.

|flat fee per year (kr) |break-even balance (kr) |
|:----------------------|:-----------------------|
|404                    |4,564,000               |
|807 (PFA)              |9,116,000               |
|984 (Velliv)           |11,116,000              |
|1,968                  |22,232,000              |

With PFA as the second provider, the diversification covers its flat fee only above a balance of
about kr 9,116,000. With Velliv it takes about kr 11,116,000. Your balance of
kr 1,000,000 is below both,
so on pure diversification grounds one provider is enough.
The benefit is only about 0.9 basis points a year, and the flat fee is paid in
every low-balance year on the way up besides. A risk-averse investor values the volatility cut at
$\gamma$ times the variance drain in the mean-variance view, which divides the threshold by $\gamma$.
At your risk aversion of 2 it falls to about kr 4,558,000 to kr 5,558,000,
still above your balance.

## How much cheaper must a second provider be?

The other reason to add a provider is that it is *cheaper proportionally*. Moving an amount
$W_2$ to a provider whose rate is $\Delta p$ lower saves $\Delta p \cdot W_2$ per year, which must cover its
flat fee $F_2$. So a second provider must undercut the first by at least

$$\Delta p \;\ge\; \frac{F_2}{W_2}.$$


Table: Proportional-rate discount a second provider must offer to justify its flat fee, by amount placed there ($W_2$).

|                        |kr 250,000 |kr 500,000 |kr 750,000 |kr 1,000,000 |
|:-----------------------|:----------|:----------|:----------|:------------|
|$F_2$ = kr 807 (PFA)    |0.32%      |0.16%      |0.11%      |0.08%        |
|$F_2$ = kr 984 (Velliv) |0.39%      |0.20%      |0.13%      |0.10%        |
|$F_2$ = kr 1,968        |0.79%      |0.39%      |0.26%      |0.20%        |

At your balance of kr 1,000,000, a second provider must be at least
**0.08 to 0.10
percentage points/year** cheaper to break even on fees, the first figure for
PFA's flat fee and the second for Velliv's. The diversification
credit $\Delta g \cdot W$, about kr 89 a year at your balance, could be added to
the left-hand side. It barely moves the bar.
If a second provider is *strictly* cheaper on both fee types, the question is not whether to *add*
it but whether to *switch* entirely.

## The benefit the variance drain misses: Hedging an unidentifiable provider difference

The variance drain above compares the mix to the *average* single plan, treating the two
providers' expected returns as known and equal. But the real risk in the provider choice is
not knowing *which provider's drift will compound higher* -- and that difference is precisely
what the data cannot pin down.



Over the sample PFA-high out-returned Velliv-high
by **1.2 percentage points a year**, with a standard error of
0.7 pp/yr (t = 1.7), so it is
**not distinguishable from zero**.
You could not have known in advance which would win. The diagnostic report's Sharpe section carries the reference-period version of this comparison and a plot of the two paths.

How much of that realised edge is chance? The data cannot pin down the tail, so we assume one: A
skewed-$t$ with $\nu = 3.5$ and $\xi = 0.7$, set in the inputs. Simulating two
providers with the data's volatilities and correlation but *no* true difference in mean, the gap
between them over the sample has its own spread purely from chance and fat tails.



Under this fat-tailed null, a gap at least as large as the realised one arises by chance about
**13%** of the time, against 9%
under normal theory. The fatter tail makes the realised lead even less surprising than normal theory implies.
Either way the realised lead is well within what no edge at all produces, so it is not signal.

Committing to one provider is thus a bet on a difference in expected return that the data cannot
identify: The relative drift is not distinguishable from zero, so there is no statistical basis for predicting which provider will compound higher.
The stakes grow with the
horizon -- increasingly from the *estimation* uncertainty in the drift (which accumulates
linearly) rather than path noise (which accumulates only as √horizon):


Table: Dispersion between the two providers' cumulative outcomes by horizon, vs the second provider's flat fee over the horizon (PFA's the lower figure, Velliv's the higher).

|horizon |provider gap (1-sd) |share from estimation |gap on kr 1,000,000 |flat fee over horizon |
|:-------|:-------------------|:---------------------|:-------------------|:---------------------|
|5 yr    |7%                  |27%                   |72,205              |4,035 to 4,920        |
|10 yr   |12%                 |43%                   |117,591             |8,070 to 9,840        |
|20 yr   |21%                 |60%                   |206,617             |16,140 to 19,680      |
|30 yr   |30%                 |69%                   |299,789             |24,210 to 29,520      |

The **provider gap (1-sd)** column is one standard deviation of the spread between the two
providers' cumulative outcomes at that horizon, the typical distance by which one ends ahead of the
other. The **share from estimation** column is how much of that spread comes from not knowing the
relative drift (which grows with the horizon), as opposed to ordinary path noise.

In kroner the gap dwarfs the flat fee. But the gap is symmetric, since you might land on either
side, so what justifies hedging is its **risk-adjusted** value, not its raw size. For a saver with
constant relative risk aversion $\gamma$, the certainty-equivalent value of holding both, agnostic
about which is better, is about $\gamma\,\sigma^2_{\text{gap}}/8$, the result derived in the
diagnostic report. Here $\sigma^2_{\text{gap}}$ is the variance of the cumulative provider gap,
combining path noise with the estimation uncertainty in the relative drift:


Table: Certainty-equivalent value (kr, on kr 1,000,000) of holding both providers instead of one, by relative risk aversion (RRA, columns). Compare with the flat fees, kr 807/yr (PFA) and kr 984/yr (Velliv): kr 8,070 to 9,840 over 10 yr, kr 16,140 to 19,680 over 20 yr.

|      |RRA 1 |RRA 2 |RRA 4  |
|:-----|:-----|:-----|:------|
|10 yr |1,545 |3,090 |6,180  |
|20 yr |4,410 |8,819 |17,638 |

At your risk aversion of 2 and a 20-year horizon, the certainty-equivalent value
of holding both providers is about kr 8,819, against kr 16,140 to
kr 19,680 of extra flat fees over that horizon, depending on which provider is the
second. So the hedge falls short of its cost either way, covering about 45% to 55% of it.
The large realised gap is hindsight, not an expected gain.
It would clear only for a more risk-averse saver or a longer horizon.
The risk-level choice of Sections 2 and 5 remains the larger lever, and all of this assumes the
saver does not chase the apparent drift edge that Section 2 says cannot be trusted.

*The break-evens above read off the flat fees and the balance set in the Inputs section.*

## A second lens: The split as insurance

The certainty equivalent prices the body of the distribution. A complementary view, free of any
distributional assumption, treats the split as insurance. A 50/50 buy-and-hold split ends at the
average of the two single outcomes, so its terminal wealth always lands between the worse and the
better provider. Splitting removes the risk of committing to the worse provider, and pays for it
by giving up the better provider's upside.



Over the sample, 1 kr grew to about 3.9 kr in PFA-high and about
3.3 kr in Velliv-high. A 50/50 buy-and-hold split would have ended at about
3.6 kr, between the two. The premium is symmetric, and
you cannot know in advance which provider will win, since the realised drift gap is not distinguishable from zero, as shown above.

The honest limit of this lens is that the insurance cannot be priced reliably against the flat
fee. Its value depends on the dispersion of the provider gap, and under the heavy tails the
returns reports document that dispersion is not something the data pin down. The Monte Carlo in
Section 5, and the long-horizon simulations in the returns reports, show that compounded outcomes
over a long horizon can diverge to an extreme degree. So the mean-variance certainty equivalent
gives a point estimate that covers only 45% to 55% of the flat fees,
while the insurance lens says the protection is real but its price is genuinely uncertain. The decision rests on how much an unquantifiable hedge
against picking the worse provider is worth to the saver, set against a known annual flat fee.

# 5. Does a second provider help in the tail?

Sections 2--4 are second-moment -- Sharpe, correlation, volatility. The returns reports show
the second moment is the wrong lens: The tail index $\nu$ is around 3--5, returns are
left-skewed, and correlation is itself unstable under fat tails. The decision-relevant
question is whether holding two providers protects the *tail* -- a crash -- and by how much.

The data fix each plan's *marginal* (mean, volatility, fat-tailed shape) and the *linear
correlation* between providers (about 0.97 for two high-risk plans), but they do **not** fix the
*tail dependence*: Whether the two crash *together* (a systemic equity selloff) or whether
one can crash *alone*. So rather than a single number we simulate three models that **all
match the observed means, volatilities and correlation** and differ only in the tail -- a
**Gaussian** world (no fat tails); the fitted skewed-$t$ marginals with **independent**
crashes (a Gaussian copula); and the same marginals with **coincident** crashes (a
Student-$t$ copula). For each we compare holding one high-risk plan (100% Velliv high)
against a 50/50 provider split (Velliv high + PFA high) over **one year** -- the horizon at
which a crash actually bites (over twenty years the law of large numbers smooths the monthly
tails away and the split's effect all but vanishes).


Table: One-year wealth (start = 100): One high-risk plan vs a 50/50 provider split, under three models matched on mean, volatility and correlation.

|                         | single 5th-pct| single P(loss>10%)| split 5th-pct| split P(loss>10%)|
|:------------------------|--------------:|------------------:|-------------:|-----------------:|
|Gaussian                 |          90.09|               4.89|         91.86|              3.14|
|Fat, independent crashes |          89.90|               5.10|         91.75|              3.72|
|Fat, coincident crashes  |          89.69|               5.13|         91.41|              3.87|

Three things stand out. **Fat tails make the single plan riskier than a Gaussian view admits.**
The chance of a one-year loss worse than 10% rises from about 4.9%
under the Gaussian to about 5.1% with
fat tails, and for deeper losses the gap widens. **Splitting across two same-risk providers helps
only modestly.** It trims that probability to about 3.7%
and lifts the 5th-percentile floor by about 1.8
points. And crucially, **that modest benefit barely moves between the independent-crash and
coincident-crash models**: At a correlation of 0.97 the bulk
co-movement already caps the diversification, so the tail dependence we *cannot* estimate turns
out not to change the answer. Provider-splitting at the same risk level is a weak crash hedge,
since two highly-correlated providers mostly fall together.

The far larger lever for crash protection is the **risk level itself**: The bond sleeve of a
lower-risk plan cuts the crash probability much more than a second provider does (the flip
side of the "Path crossing" result in the returns reports -- the lower-risk plan genuinely
cushions a drawdown, at the cost of expected return). The one diversification a *returns*
analysis cannot see is **provider-specific operational risk** -- a fund or administrator
failing on its own -- which is the strongest remaining argument for splitting and lies
outside this data.

# 6. Monitoring: What has changed?

These choices are not made once. The data that drive them -- the regime, the gap between
providers, what each plan holds, the fees -- change, and a wrong assumption ("the bull market
will continue") reveals itself only with time. This tool is therefore also meant to be
**re-run periodically as a monitor**, flagging when a decision needs revisiting:



- **Regime shifts** -- a change in the level of returns, in volatility, or in the tail that
  would alter the *risk-level* choice (e.g. when staying in a high-risk plan stops looking
  safe).
- **Provider divergence** -- a widening gap between the providers' cumulative outcomes. Over
  2012-07 to 2025-11, 1 m DKK in PFA-high grew to about 3.9 m
  versus about 3.3 m in Velliv-high, a spread of about
  0.6 m, with PFA-high compounding about 1.2 pp/year
  faster. No one could have called this in advance. A monitor shows such a gap opening and forces
  the question of whether it is signal or luck.
- **Composition or fee changes** -- e.g. PFA's restructuring of 1 April 2025, which renamed its
  profiles and moved B and C toward equities, or any change in the flat fees that drive the
  Section 4 arithmetic.

## Distance to a path crossing

Section 2 showed the high plan is a leverage of the medium plan, and the diagnostic report shows the
flip side: The high plan trails the medium plan exactly while the medium plan sits below its entry
value. The distance to a crossing is therefore the cushion the medium plan has built above the
chosen entry, and a crossing begins once a drawdown gives that cushion back. The table reads this
off for each provider, from the saver's entry (the start of the supplied data by default) and from
the medium plan's most recent peak.


Table: Distance to a within-provider path crossing. The high plan trails the medium plan once the medium plan falls back to its entry level. 'Drawdown to a crossing' is the fall from today, gradual or in a single month, that would trigger it; 'drawdown from peak now' is how far the medium plan already sits under its running high; 'medium return, 6m' shows whether the cushion is widening (positive) or narrowing.

|             provider| cushion since entry| drawdown to a crossing| drawdown from peak now| medium return, 6m|
|--------------------:|-------------------:|----------------------:|----------------------:|-----------------:|
| Velliv (high vs med)|               +172%|                    63%|                     0%|             +8.7%|
|         PFA (D vs B)|               +141%|                    59%|                     0%|             +7.2%|

What to read in the table. The **drawdown to a crossing** is how far the medium plan must fall from
today before the high plan slips behind it. It is large from a long-held entry and small from a
recent one, because the cushion is whatever the plan has gained since the entry. The **drawdown
from peak now** is the fragile reading: An entry at the medium plan's most recent peak is closest
to a crossing, since any further fall puts the plan below its entry. That is the situation the
diagnostic report illustrates with the COVID-eve example. A positive six-month medium return means
the cushion is widening and a crossing receding; a negative one means it is narrowing. This is the
within-provider crossing, the high plan against its own medium plan, separate from the
cross-provider spread above.

## Has the return structure changed?

The tool monitors *structure*, not only level. The bluntest signal is the number of return
streams: When a provider splits or merges its profiles, the column count changes. A reweighting
leaves the count intact. PFA's April 2025 restructuring is an example: Its feed kept all four
profiles under new names, but two of them took on more equity. Such subtler shifts, and a change of
underlying funds, show up as drift in the per-provider leverage, the volatility of the lower-risk
plans, and the correlations. The check below compares a baseline window with the most recent
months.


Table: Structure check: Baseline window vs the most recent 36 months. The data carry 7 return streams; a change in that count is itself an obvious structural change.

|metric                                |baseline |recent |change  |
|:-------------------------------------|:--------|:------|:-------|
|Velliv leverage $\beta$ (high on med) |1.26     |1.28   |+0.01   |
|PFA leverage $\beta$ (high on med)    |1.59     |1.63   |+0.04   |
|Velliv medium volatility (ann.)       |8.5%     |7.1%   |-1.4 pp |
|PFA medium volatility (ann.)          |6.0%     |5.4%   |-0.6 pp |
|Velliv low-high correlation           |0.99     |0.98   |-0.00   |
|PFA low-high correlation              |0.90     |0.92   |+0.02   |

These drifts mix market conditions with policy. PFA's profiles allow a sharper test, because each
is a fixed blend of the two funds of Section 3, $H = D$ and $L = (4A - D)/3$. A profile's share in
the high-risk fund changes only when PFA reweights it, whatever the market does. The scan below
finds, for B and C, the month that best splits the window into two constant shares.


Table: Reweighting scan for PFA's middle profiles: The share of the high-risk fund before and after the best single split of the window, and how much of a constant-share fit's misfit that split removes.

|profile |best split |high-risk share before |high-risk share after |misfit removed |
|:-------|:----------|:----------------------|:---------------------|:--------------|
|PFA B   |2025-04    |50%                    |60%                   |94%            |
|PFA C   |2025-04    |75%                    |95%                   |98%            |

The scan flags a reweighting: From 2025-04, PFA B moved from 50% to 60% and PFA C moved from 75% to 95% high-risk fund. That is a change of policy, not of market conditions. Only the last 8 months carry the new weights, so the full-window figures above still mostly describe the old profiles. Going forward, judge these profiles by their new weights, not by their history.
A flag is a prompt to ask which of three causes is at work, market conditions, a change of policy,
or a change in the underlying funds and weights, and then to revisit the risk-level and provider
decisions above.

# 7. Verdict

On the loaded data and your inputs:

- **Risk level.** Velliv reads as a leverage ray, and PFA's profiles also read as a ray within the noise. In both, pick the risk level by drawdown tolerance; there is nothing to optimise. The larger lever, for growth and for crash protection alike, is the risk level itself, not the provider. PFA reweighted B and C from 2025-04, so choose among its profiles by their new weights.
- **One provider or both.** The best cross-provider mix (PFA A + Velliv high) cuts volatility about 2.5%. On diversification grounds one provider is enough at your balance. As insurance against the unidentifiable provider difference, the certainty equivalent (kr 8,819) falls short of the extra flat fees over your horizon (kr 16,140 to kr 19,680), and the joint simulation makes a same-risk split a weak crash hedge. The strongest case for a second provider is operational risk, which the return data cannot measure.
- **Trust.** The loaded data are heavy-tailed, and the tail is not pinned down at 161 months. Treat every figure here as direction, not precision, and re-run the tool as the data grow.
