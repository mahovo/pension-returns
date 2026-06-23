---
title: "Choosing a pension plan: an investor's decision tool"
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
date: "13:10 23 June 2026"
params:
  start_date: null   ## NULL = use the full span of the supplied data; else a "YYYY-MM-DD" cut-off.
---





# Purpose

This is a companion to the two returns reports `pension-returns_monthly` and `pension-returns_annual`. Those reports characterise the *distribution* of each plan's returns -- fat tails, a persistent left skew, and a tail index the data cannot pin down. This tool turns those findings into the two decisions an investor actually faces:

1. **Which risk level** -- and is a higher-risk plan anything more than a more-leveraged
   version of a lower-risk one?
2. **One provider or both** -- is there diversification between PFA and Velliv, and could
   it plausibly beat the cost of splitting?

The returns reports' central caveat governs everything here: with about 14 years of
data and fat tails, point estimates (means, Sharpe ratios, correlations) are noisy and
regime-dependent. The tool is therefore built to expose *how robust* each conclusion is,
not to emit a single "best" plan. Returns are monthly, 172 months
(2010-01 to 2024-04), PFA at the 30-year horizon; rates over the period are
near zero, so "Sharpe" is return divided by volatility.

# 1. Within a provider: Is a higher-risk plan just more leverage?

A higher-risk plan is *pure leverage* of a lower-risk one when it has the same
reward-to-risk (Sharpe) and the same distributional shape, only scaled. If so, choosing a
risk level is a pure risk-appetite dial with no consequence for return-per-unit-risk. We
test this with the Sharpe ratio of each plan and, crucially, its stability across
sub-periods.


Table: Annualised Sharpe ratio by plan and start date.

|                      | Velliv low| Velliv med| Velliv high| PFA low (A)| PFA B| PFA C| PFA high (D)|
|:---------------------|----------:|----------:|-----------:|-----------:|-----:|-----:|------------:|
|from 2010-01  (n=172) |       0.82|       0.84|        0.81|        1.24|  1.10|  0.99|         0.90|
|from 2014-09  (n=116) |       0.62|       0.64|        0.62|        0.79|  0.81|  0.81|         0.79|
|from 2019-07  (n=58)  |       0.44|       0.52|        0.53|        0.30|  0.52|  0.64|         0.68|

**Velliv is a leverage ray.** In every sub-period the three Velliv plans have essentially
the same Sharpe (about 0.8), so they are scaled versions of one portfolio.
Choosing a Velliv risk level is a pure risk-appetite decision: more risk buys proportionally
more expected return, with no change in reward-per-unit-risk and nothing to "optimise."

**PFA's menu curves, but the direction is not identifiable.** PFA's profiles do not share a
single Sharpe, so the menu is a curve rather than a ray. The highest-Sharpe profile by start
window is PFA low (A) from 2010-01; PFA C from 2014-09; PFA high (D) from 2019-07. These differences
sit inside the noise the returns reports warn about, so the better end is not reliably
identifiable. The practical conclusion is the opposite of the textbook "find the tangency
portfolio": for PFA you cannot reliably pick a best-Sharpe blend, so you should not pay, in risk
or in fees, to chase one.

![](pension-returns_investor_files/figure-html/mean-var-plot-1.png)<!-- -->

# 2. Across providers: Is there diversification?


Table: Correlation matrix of monthly returns across all plans.

|             | Velliv low| Velliv med| Velliv high| PFA low (A)| PFA B| PFA C| PFA high (D)|
|:------------|----------:|----------:|-----------:|-----------:|-----:|-----:|------------:|
|Velliv low   |      1.000|      0.991|       0.974|       0.870| 0.951| 0.954|        0.945|
|Velliv med   |      0.991|      1.000|       0.994|       0.868| 0.951| 0.955|        0.946|
|Velliv high  |      0.974|      0.994|       1.000|       0.855| 0.941| 0.947|        0.939|
|PFA low (A)  |      0.870|      0.868|       0.855|       1.000| 0.948| 0.885|        0.837|
|PFA B        |      0.951|      0.951|       0.941|       0.948| 1.000| 0.987|        0.967|
|PFA C        |      0.954|      0.955|       0.947|       0.885| 0.987| 1.000|        0.995|
|PFA high (D) |      0.945|      0.946|       0.939|       0.837| 0.967| 0.995|        1.000|

Every pair is highly correlated. The lowest pairwise correlation is 0.84,
because every plan is equity-dominated (see the "Path crossing" section of the returns reports:
even a "low-risk plan" is mostly equities). The least-correlated plans are
**PFA high (D)** and **PFA low (A)**.


Table: 50/50 cross-provider mixes: Correlation and volatility reduction vs the weighted-average volatility.

|                           |correlation |vol reduction |
|:--------------------------|:-----------|:-------------|
|PFA low (A) + Velliv high  |0.855       |3.1%          |
|Velliv low + PFA high (D)  |0.945       |1.4%          |
|Velliv high + PFA high (D) |0.939       |1.6%          |
|Velliv med + PFA B         |0.951       |1.2%          |

The largest risk reduction among simple cross-provider mixes is **PFA-low + Velliv-high** --
consistent with the intuition that pairing the most bond-heavy plan of one provider with the
most equity-heavy of the other combines the most-different compositions. But the benefit is
*small*: A few percent of volatility, not a step change. Diversifying across providers does
something, just not much, in mean-variance terms.

## The diversification that *does* work is within a provider

Splitting across providers pairs equity with equity. The diversification that actually
reduces risk is across *asset classes* -- bonds with equity -- and it lives inside a single
provider, harvested simply by choosing a risk level. Backing PFA's two building-block funds
out of its profiles (equity fund `H = D`, bond-like fund `L = 2B − D`, exact for simple
returns) and comparing the two kinds of 50/50 blend:


Table: Volatility reduction from a 50/50 blend: within a provider (across asset classes) vs across providers (same risk level).

|blend                                                      | correlation|vol. reduction |
|:----------------------------------------------------------|-----------:|:--------------|
|Within PFA: Mid-risk plan                                  |        0.36|14%            |
|Across providers: Velliv-high + PFA-high (same risk level) |        0.94|2%             |

The within-provider blend correlates about 0.4 and cuts volatility several times more than the
cross-provider split. A single provider's mid-risk plan is therefore already *more*
diversified than two equity-heavy plans held across providers -- at one set of fees, not two.
The upshot, reinforcing Sections 1 and 4: **Diversify by lowering your risk level within one
provider, not by adding a second provider.**

# 3. Diversification vs. cost: Which fees actually matter

Fees split into two kinds, and only one bears on the *split* decision:

- **Proportional fees** (a percentage of assets under management). If both providers charge
  the same rate they are *split-neutral*: `p` on the whole pot costs the same whether it sits
  in one plan or two (`p·W = p·W₁ + p·W₂`). Equal proportional fees therefore drop out of the
  one-vs-two decision entirely.
- **Flat fees** (a fixed kr/year administration charge, independent of balance). These are
  paid *per provider*, so a second provider adds its flat fee `F₂` every year, however little
  you place there.

The split decision thus turns on flat fees -- weighed against the diversification benefit --
and, separately, on any *difference* in proportional rates between providers.

## Is the diversification worth a second flat fee?

Express the diversification benefit the way it actually accrues, as a boost to the **compound**
growth rate: the variance drain it removes, `Δg = (σ²_single − σ²_split)/2`. The monthly report
derives this variance drain, and the certainty equivalent used later in this section, from the
return moments.



For a cross-provider same-risk split this is **1.3 basis points per
year** -- the entire "gain that compounds" from holding two providers. In kroner it is
`dg · W`, while the flat fee `F₂` is paid every year regardless of `W`. The split pays only
above a break-even balance `W* = F₂ / dg`:


Table: Balance above which the cross-provider diversification covers a second provider's flat fee.

| flat fee per year (kr)|break-even balance (kr) |
|----------------------:|:-----------------------|
|                    500|3,739,000               |
|                    600|4,487,000               |
|                    700|5,235,000               |
|                    800|5,983,000               |
|                    900|6,731,000               |
|                   1000|7,479,000               |
|                   1100|8,227,000               |
|                   1200|8,975,000               |
|                   1300|9,722,000               |
|                   1400|10,470,000              |
|                   1500|11,218,000              |

Because the benefit is only about a basis point a year, the break-even balances run into the
millions -- for realistic flat fees the diversification never covers them within a normal
saver's balance, and the flat fee is paid in every low-balance year on the way up besides.
*On diversification grounds: one provider.* (A risk-averse investor values the volatility cut
somewhat above the pure variance-drain, but not nearly enough to move these thresholds.)

## How much cheaper must a second provider be?

The other reason to add a provider is that it is *cheaper proportionally*. Moving an amount
`W₂` to a provider whose rate is `Δp` lower saves `Δp · W₂` per year, which must cover its
flat fee `F₂`. So a second provider must undercut the first by at least

$$\Delta p \;\ge\; \frac{F_2}{W_2}.$$


Table: Proportional-rate discount a second provider must offer to justify its flat fee, by amount placed there (W2).

|              |kr 500,000 |kr 600,000 |kr 700,000 |kr 800,000 |kr 900,000 |
|:-------------|:----------|:----------|:----------|:----------|:----------|
|F2 = kr 500   |0.10%      |0.08%      |0.07%      |0.06%      |0.06%      |
|F2 = kr 600   |0.12%      |0.10%      |0.09%      |0.07%      |0.07%      |
|F2 = kr 700   |0.14%      |0.12%      |0.10%      |0.09%      |0.08%      |
|F2 = kr 800   |0.16%      |0.13%      |0.11%      |0.10%      |0.09%      |
|F2 = kr 900   |0.18%      |0.15%      |0.13%      |0.11%      |0.10%      |
|F2 = kr 1,000 |0.20%      |0.17%      |0.14%      |0.12%      |0.11%      |
|F2 = kr 1,100 |0.22%      |0.18%      |0.16%      |0.14%      |0.12%      |
|F2 = kr 1,200 |0.24%      |0.20%      |0.17%      |0.15%      |0.13%      |
|F2 = kr 1,300 |0.26%      |0.22%      |0.19%      |0.16%      |0.14%      |
|F2 = kr 1,400 |0.28%      |0.23%      |0.20%      |0.17%      |0.16%      |
|F2 = kr 1,500 |0.30%      |0.25%      |0.21%      |0.19%      |0.17%      |

A second provider charging kr 1,000/year that receives kr 100,000 of your savings must be a
full **1 percentage point/year** cheaper just to break even on fees; at kr 1,000,000 placed
the bar falls to **0.1 pp/year**. The diversification credit (`dg · W`) could be added to the
left-hand side, but at ~1 bp it barely moves the bar. (If a second provider is *strictly*
cheaper on both fee types, the question is not whether to *add* it but whether to *switch*
entirely.)

## The benefit the variance drain misses: Hedging an unreadable provider bet

The variance drain above compares the mix to the *average* single plan, treating the two
providers' expected returns as known and equal. But the real risk in the provider choice is
not knowing *which provider's drift will compound higher* -- and that difference is precisely
what the data cannot pin down.



Over the sample PFA-high out-returned Velliv-high by **1
percentage points a year** -- but with a standard error of 0.9 pp/yr
(t = 1.1), so it is **not distinguishable from zero**. You could not
have known which would win, and Section 1 showed the ranking flips across windows.

Committing to one provider is thus a bet on an unreadable coin, and the stakes grow with the
horizon -- increasingly from the *estimation* uncertainty in the drift (which accumulates
linearly) rather than path noise (which accumulates only as √horizon):


Table: Dispersion between the two providers' cumulative outcomes by horizon, vs the second provider's flat fee.

|horizon |provider gap (1-sd) |share from estimation |gap on kr 1,000,000 |flat fee over horizon |
|:-------|:-------------------|:---------------------|:-------------------|:---------------------|
|5 yr    |10%                 |26%                   |96,595              |3,500                 |
|10 yr   |16%                 |41%                   |157,541             |7,000                 |
|20 yr   |28%                 |58%                   |278,592             |14,000                |
|30 yr   |41%                 |68%                   |407,802             |21,000                |

In kroner the gap dwarfs the flat fee. But the gap is symmetric, since you might land on either
side, so what justifies hedging is its **risk-adjusted** value, not its raw size. For a saver with
constant relative risk aversion `γ`, the certainty-equivalent value of holding both, agnostic
about which is better, is about `γ · σ²gap / 8`, the result derived in the monthly report. Here
`σ²gap` is the variance of the cumulative provider gap, combining path noise with the estimation
uncertainty in the relative drift:


Table: Certainty-equivalent value (kr, on kr 1,000,000) of holding both providers instead of one, by relative risk aversion (RRA, columns). Compare with the flat fee, kr 700/yr: kr 7,000 over 10 yr, kr 14,000 over 20 yr.

|      |RRA 1 |RRA 2  |RRA 4  |
|:-----|:-----|:------|:------|
|10 yr |2,675 |5,351  |10,702 |
|20 yr |7,550 |15,099 |30,199 |

This is a genuine close call rather than a slam dunk. The certainty-equivalent value of hedging
the provider bet is comparable to the flat fee. It falls short for a moderately risk-averse
saver (`γ ≈ 1–2`) and clears it only for a more risk-averse one (`γ ≳ 2–4`) over a long horizon.
The large realised gap is hindsight, not an expected gain. The defensible reading is that for a
sufficiently risk-averse saver with a long horizon a second provider is mild insurance against
an unreadable bet, worth roughly its flat fee, while for everyone else it is close to a wash.
The risk-level choice of Sections 1 and 4 remains the larger lever, and all of this assumes the
saver does not chase the apparent drift edge that Section 1 says cannot be trusted.

*To use this with real numbers, set `F2` (each provider's flat fee), the two proportional
rates, and your balance / contribution path; the break-evens above then read off directly.*

## A second lens: the split as insurance

The certainty equivalent prices the body of the distribution. A complementary view, free of any
distributional assumption, treats the split as insurance. A 50/50 buy-and-hold split ends at the
average of the two single outcomes, so its terminal wealth always lands between the worse and the
better provider. Splitting removes the risk of committing to the worse provider, and pays for it
by giving up the better provider's upside.



Over the sample, 1 kr grew to about 3.7 kr in PFA-high and about
3.2 kr in Velliv-high. A 50/50 buy-and-hold split would have ended at about
3.5 kr, between the two. The premium is symmetric, and you cannot know in
advance which provider will win: the realised drift gap is not distinguishable from zero, as shown
above.

The honest limit of this lens is that the insurance cannot be priced reliably against the flat
fee. Its value depends on the dispersion of the provider gap, and under the heavy tails the
returns reports document that dispersion is not something the data pin down. The Monte Carlo in
Section 4, and the long-horizon simulations in the returns reports, show that compounded outcomes
over a long horizon can diverge to an extreme degree. So the mean-variance certainty equivalent
gives a point estimate that reads as a close call, while the insurance lens says the protection is
real but its price is genuinely uncertain. The decision rests on how much an unquantifiable hedge
against picking the worse provider is worth to the saver, set against a known annual flat fee.

# 4. Does diversifying across providers help in the tail? A joint simulation

Sections 1--3 are second-moment -- Sharpe, correlation, volatility. The returns reports show
the second moment is the wrong lens: the tail index `nu` is around 3--5, returns are
left-skewed, and correlation is itself unstable under fat tails. The decision-relevant
question is whether holding two providers protects the *tail* -- a crash -- and by how much.

The data fix each plan's *marginal* (mean, volatility, fat-tailed shape) and the *linear
correlation* between providers (about 0.94 for two high-risk plans), but they do **not** fix the
*tail dependence*: whether the two crash *together* (a systemic equity selloff) or whether
one can crash *alone*. So rather than a single number we simulate three models that **all
match the observed means, volatilities and correlation** and differ only in the tail -- a
**Gaussian** world (no fat tails); the fitted skewed-$t$ marginals with **independent**
crashes (a Gaussian copula); and the same marginals with **coincident** crashes (a
Student-$t$ copula). For each we compare holding one high-risk plan (100% Velliv high)
against a 50/50 provider split (Velliv high + PFA high) over **one year** -- the horizon at
which a crash actually bites (over twenty years the law of large numbers smooths the monthly
tails away and the split's effect all but vanishes).


Table: One-year wealth (start = 100): one high-risk plan vs a 50/50 provider split, under three models matched on mean, volatility and correlation.

|                         | single 5th-pct| single P(loss>10%)| split 5th-pct| split P(loss>10%)|
|:------------------------|--------------:|------------------:|-------------:|-----------------:|
|Gaussian                 |          90.80|               4.05|         91.76|              3.16|
|Fat, independent crashes |          90.48|               4.67|         91.44|              3.61|
|Fat, coincident crashes  |          90.53|               4.65|         91.27|              3.84|

Three things stand out. **Fat tails make the single plan riskier than a Gaussian view admits.**
The chance of a one-year loss worse than 10% rises from about 4.0%
under the Gaussian to about 4.7% with
fat tails, and for deeper losses the gap widens. **Splitting across two same-risk providers helps
only modestly.** It trims that probability to about 3.6%
and lifts the 5th-percentile floor by about 1.0
points. And crucially, **that modest benefit barely moves between the independent-crash and
coincident-crash models**: at a correlation of 0.94 the bulk
co-movement already caps the diversification, so the tail dependence we *cannot* estimate turns
out not to change the answer. Provider-splitting at the same risk level is a weak crash hedge,
since two equity-dominated providers mostly fall together.

The far larger lever for crash protection is the **risk level itself**: The bond sleeve of a
lower-risk plan cuts the crash probability much more than a second provider does (the flip
side of the "Path crossing" result in the returns reports -- the lower-risk plan genuinely
cushions a drawdown, at the cost of expected return). The one diversification a *returns*
analysis cannot see is **provider-specific operational risk** -- a fund or administrator
failing on its own -- which is the strongest remaining argument for splitting and lies
outside this data.

# 5. Using the tool

- **Risk level, Velliv:** A pure risk-appetite dial (one leverage ray). Pick by drawdown
  tolerance; there is no reward-per-risk to optimise.
- **Risk level, PFA:** The menu curves, but the best-Sharpe blend is not identifiable and
  flips across periods. Default to risk appetite; do not pay to chase a tangency.
- **One provider or both:** A small mean-variance diversification (best via PFA-low +
  Velliv-high), and the joint simulation shows it stays small in the tail too -- two
  equity-heavy providers mostly crash together, so a same-risk split is a weak crash hedge.
  The real crash lever is the *risk level*, not the provider. The strongest case for two
  providers is operational risk, which the return data cannot measure; weigh it against the
  cost of splitting.
- **All of the above rests on a benign, short, fat-tailed sample.** Treat the numbers as
  direction, not precision -- the same discipline the returns reports impose.

# 6. From a one-off decision to an ongoing monitor

These choices are not made once. The data that drive them -- the regime, the gap between
providers, what each plan holds, the fees -- change, and a wrong assumption ("the bull market
will continue") reveals itself only with time. This tool is therefore also meant to be
**re-run periodically as a monitor**, flagging when a decision needs revisiting:



- **Regime shifts** -- a change in the level of returns, in volatility, or in the tail that
  would alter the *risk-level* choice (e.g. when staying in a high-risk plan stops looking
  safe).
- **Provider divergence** -- a widening gap between the providers' cumulative outcomes. Over
  2010-01 to 2024-04, 1 m DKK in PFA-high grew to about 3.7 m
  versus about 3.2 m in Velliv-high, a spread of about
  0.5 m, with PFA-high compounding about 1.0 pp/year
  faster. No one could have called this in advance. A monitor shows such a gap opening and forces
  the question of whether it is signal or luck.
- **Composition or fee changes** -- e.g. PFA's 2024 move from four profiles (A--D) to three
  (Low/Medium/High), or any change in the flat fees that drive the Section 3 arithmetic.

## Distance to a path crossing

Section 1 showed the high plan is a leverage of the medium plan, and the monthly report shows the
flip side: the high plan trails the medium plan exactly while the medium plan sits below its entry
value. The distance to a crossing is therefore the cushion the medium plan has built above the
chosen entry, and a crossing begins once a drawdown gives that cushion back. The table reads this
off for each provider, from the saver's entry (the start of the supplied data by default) and from
the medium plan's most recent peak.


Table: Distance to a within-provider path crossing. The high plan trails the medium plan once the medium plan falls back to its entry level. 'Drawdown to a crossing' is the fall from today, gradual or in a single month, that would trigger it; 'drawdown from peak now' is how far the medium plan already sits under its running high; 'medium return, 6m' shows whether the cushion is widening (positive) or narrowing.

|             provider| cushion since entry| drawdown to a crossing| drawdown from peak now| medium return, 6m|
|--------------------:|-------------------:|----------------------:|----------------------:|-----------------:|
| Velliv (high vs med)|               +169%|                    63%|                     2%|            +11.6%|
|         PFA (D vs B)|               +152%|                    60%|                     2%|             +8.7%|

From an entry at the start of the supplied data the cushion is large, so a crossing needs a
near-total drawdown: a long-held high plan is far from falling behind its medium plan. The
fragility is all in the entry point. An investor who bought at the medium plan's most recent peak
is at the brink, since any down-month then puts the medium plan below entry. This is the COVID-eve
case from the monthly report. The six-month medium return shows the current direction: positive
means the cushion is widening and a crossing receding, negative means it is narrowing. This is the
within-provider crossing, the high plan against its own medium plan, and is separate from the
cross-provider spread above.
