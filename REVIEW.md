# Soundness review — pension-returns

Review of the calculations and reasoning in the monthly and annual pension-returns
reports. Scope: correctness of the statistical methodology and the conclusions it
supports. Data-update work is **out of scope here** (deferred; see "Data freshness").

Date of review: 2026-06. Reviewed against branch as checked out.

---

## 1. Data freshness (for context; not changed in this review)

| Source | File | Latest data | Notes |
|---|---|---|---|
| PFA monthly | `data/monthly/pfa_monthly.json` | April 2024 | `opdateredato` 2024-05-28 |
| Velliv monthly | `data/monthly/velliv_monthly_prices.csv` | April 2024 | — |
| Annual returns | hardcoded in `pension-returns_annual.Rmd` (≈ lines 173–185) | 2011–2023 | not file-driven |

There is no scraper in the repo; the inputs were produced externally. The figures
reflect a specific customer view (Velliv saldo kr 12.300, incl. bonus/DinKapital),
not the public marketing tables. **PFA restructured its investment profiles on
1 April 2025** (A/B/C/D → Lav/Middel/Høj; B/C/D → Low/Medium/High), which puts a
definitional break in the PFA series that any future update must handle explicitly.

---

## 2. Headline finding — the plans are ~1–2 factors, not 6 independent funds

The reports treat `vmr, vhr, pmr, phr, mmr, mhr` as six distinct funds, fit a
separate distribution to each, and in the Monte-Carlo / "mix" steps simulate them
**independently**. They are not independent.

**Structural reason (from PFA's own product description).** PFA Profile B = ½ High-risk
fund + ½ Low-risk fund; Profile D = 100% High-risk fund. So A/B/C/D are fixed weighted
blends of just **two** underlying funds. Velliv's VækstPension is built the same way
(low/medium/high are identical until 2012, then diverge as weightings).

**Empirical confirmation (annual 2011–2023 returns):**

- PCA on the four series: **PC1 explains 95.6%** of variance; each series' loading on
  PC1 ≈ 0.97–0.99 (mean 0.978). One common factor drives almost everything.
- Within provider, "high risk" ≈ a **scalar multiple** of "medium risk" with intercept ≈ 0:
  Velliv `vhr ≈ 1.22·vmr` (R²=0.98); PFA `phr ≈ 1.57·pmr` (R²=0.91).
- The implied PFA Low-risk fund `2·B − D` reconstructs a clean, bond-like series
  (mean 3.5%, sd 4.4% vs the High fund's 9.5%, sd 11.0%; corr with High ≈ 0.41) —
  exactly as the two-fund construction predicts.

**Consequence for conclusions.** Simulating six near-collinear series independently
(a) fabricates diversification that does not exist and (b) destroys the real
co-movement. In particular, any apparent advantage of the `mmr`/`mhr` "mix" funds
(lower simulated `mc_s` than their components) is largely an artifact of the
independence assumption plus over-fitting tiny samples — not a real diversification
benefit. (Note: the verbal version of those claims lived only in the **deprecated**
`pension-returns_template-comments.Rmd`, which is not rendered. But the underlying
**tables** that invite the same inference are still live via the comparison child doc.)

### "Risky" plan vs the never-crossing cumulative paths

Two separate observations, both real and both explained by the scaled-exposure structure:

- *Year by year*, the high-risk plan is **not** always more profitable: it underperformed
  medium-risk in 4/13 years (Velliv) and 3/13 (PFA), and drew down more in 2018 and 2022.
  Slope > 1 with intercept ≈ 0 means it **amplifies both gains and losses** — i.e. it is
  genuinely riskier (deeper drawdowns, higher sd). Higher *average* return is the
  compensation, not a free lunch.
- *Cumulatively*, in the monthly index plot the high-risk path never drops below the
  medium-risk path. With `log(W_high/100) ≈ β·log(W_med/100)`, β>1, α≈0, one gets
  `W_high > W_med ⟺ W_med > 100`. The paths can only cross while the **safe** plan is
  underwater vs its own start — which never happened over the 2012–2024 bull run
  (medium index min = 100.0). It is therefore an artifact of *structure + a benign
  sample started at a low*, **not** dominance. Re-base the clock to a market peak
  (e.g. end-2021) and the paths cross in 2022. The risk is still visible as deeper
  peak-to-trough drawdowns (Velliv −17.3% vs −15.2%; PFA −15.9% vs −11.9%).

---

## 3. Statistical soundness (beyond individual bugs)

1. **Sample size.** The annual report fits a **4-parameter skewed-t to 13 observations**
   (17 for the long Velliv series). The tail index `nu` is effectively unidentifiable
   from 13 annual points, yet the whole fat-tail narrative (`kappa`, `n_min`,
   "4th moment doesn't converge", `nu≈2` vs `nu≈90`) rests on it. Those `nu`
   differences are very likely sampling noise. The monthly report (~143 obs) is firmer.
2. **MC independence.** Splitting capital across a list of fits and summing independent
   simulations assumes zero correlation — the opposite of §2. Understates joint risk,
   overstates diversification.
3. **IS estimator** — fragile even when corrected: fat-tailed `f` (sstd, nu≈3) over a
   thin-tailed normal proposal `g` gives heavy-tailed weights and an estimator of
   `E[100·e^X]` whose variance can be (near-)infinite. Document the caveat; consider a
   fatter-tailed proposal.

---

## 4. Bug log

Status legend: ✅ fixed in this review · ⏸ held for your confirmation · 📝 documented.

| # | Location | Issue | Status |
|---|---|---|---|
| 1 | `src/…functions.R` `fit_distribution` ("std" branch) | Likelihood used `dsstd(...)` **without `xi`**, so it fit a *skewed* t with `dsstd`'s default `xi=1.5`, then plugged params into the symmetric `qstd`. Changed to `dstd(...)`. | ✅ |
| 2 | `src/…functions.R` `fit_distribution` (AIC/BIC) | Penalty hardcoded `k=4` for all distributions. Now `k = 4/3/2` for sstd/std/normal. | ✅ |
| 3 | `src/…functions.R` `fit_distribution` (normal branch) | `theoretical_quantiles` used `qstd` (a t, default nu=5) instead of `qnorm`. Fixed. | ✅ |
| 4 | `src/…functions.R` `importance_sampling` (`h_weighted`) | IS weight was **inside** the exponent: `100*exp(h*w)`. Corrected to `100*exp(h)*w`, and `mode=2` `sigma_hat` changed to `sd(h_weighted)` so `is_proposal` minimises the variance of the actual estimand. Post-fix `is_m`=364.7 vs MC `mc_m`=366.6 (was ≈4.2e8). | ✅ |
| 5 | `src/…functions.R` `mc_simulation` (CI loop) | `ci_l <- mu_hat - dev[i]` (no `[i]`) overwrote the whole vector each iteration → constant-width band. Now builds `dev` then vectorises `ci_l/ci_u`. | ✅ |
| 6 | `child_docs/…comparison.Rmd` `make_extreme_probs` | `pnorm(min(x), params[1], params[1])` used the **mean as the sd**. Changed second arg to `params[2]`. (Live doc.) | ✅ |
| 7 | `src/…functions.R` `f_kappa` / `f_n_min` | `sd` scaled by `nu/(nu-2)` (twice via `f_n_min`). Harmless — kappa is **scale-invariant** — but misleading. Removed the rescaling; verified kappa identical for sd=0.2 vs 5.0. | ✅ |
| 8 | `src/…functions.R` `fit_distribution` (`r_squared`) | `cor(sort(fit), sort(x))` is a correlation, reported as "R^2". Squared it so the "R^2" label is honest (monotonic → rankings unchanged). **Later superseded — see §6:** the squared value is now reported un-squared as **PPCC** (`r`, Filliben), since under thick tails the in-sample R² is inflated. | ✅→§6 |
| 9 | `src/…functions.R` `mc_simulation` (progress bar) | `txtProgressBar`/`setTxtProgressBar` write to the captured stream under `rmarkdown::render`, so every `\r` update landed in the HTML — pages of progress bars. Now gated on `interactive()` (suppressed during render, unchanged in the console) and the missing `close(pb)` added. | ✅ |
| 10 | `src/…functions.R` `sstd_se` | `optim(method="BFGS", hessian=TRUE)` was unguarded; on n=13 (one annual **mix** series, `mhr`) its finite-difference gradient went non-finite and **threw**, aborting the annual render inside the comparison child doc (`non-finite finite-difference value [4]`). Now `tryCatch`: BFGS → Nelder-Mead → NA, matching the function's "NA = not locally identified" design. Latent bug — the SE section postdated the last successful annual render, so the first full re-knit was the first to hit it. | ✅ |

Items 1, 4, 5, 6 change reported numbers; 2, 3 affect model-selection/plots; 7, 8 are
correctness-of-labelling / dead-code cleanups; 9 fixes rendered output; 10 unblocks the
annual render. All ten are now fixed.

Verification: `parse()` clean; `fit_distribution` runs for all three distributions with
corrected AIC (sstd −27.85 / std −16.38 / normal −20.32 on `vmr`); kappa scale-invariance
confirmed; `sstd_se` no longer throws on any of the 8 annual funds; both reports re-knit
clean (progress-bar lines: 0).

---

## 5. Monte-Carlo redesign — pure black box (implemented)

**Decision:** abandon the component-recombination MC; do **not** build a factor model;
model each fund — mixes included — as a single black box: fit one distribution to its
observed total-value series and simulate *that*. "Simulation of the average", not
"average of simulations".

**Change made.** In both reports the Monte-Carlo / max-sum / IS selector was

```r
fit_id <- list(1, 2, 3, 4, c(1,3), c(2,4), c(1,4), c(2,3))   # before
fit_id <- list(1, 2, 3, 4, 5, 6, 7, 8)                        # after (black box)
```

(`pension-returns_annual.Rmd` ~L464, `pension-returns_monthly.Rmd` ~L181.) Positions
5–8 now use `fits[[5..8]]`, the single fits to the realised mix series `mmr, mhr,
vmr_phr, vhr_pmr` already built with `mix_of_logreturns()` (returns-of-average). The
former `c(1,3)`-style entries drew the two components independently — assuming zero
correlation between funds that are ~0.9+ correlated — which manufactured diversification.

**Why this is correct / self-consistent.** The realised mix series already encodes the
true joint behaviour of its components (it was formed at the value level from the actual,
correlated history). Fitting and simulating that one series honours both (a) the appendix
"returns of average" rule and (b) the black-box premise that *all we observe is the total
value*. It also makes the MC consistent with the fit/kappa/percentile tables, which
already used the single mix fits.

**Illustrative effect** (`mhr`, 2000 paths × 20 periods, saved annual fits):

| | mc_s | mc_min | % losing |
|---|---|---|---|
| Black box (single fit)        | 258.7 | 5.4  | 1.9% |
| Old indep-sum (`vhr`+`phr`)   | 173.1 | 81.0 | 0.1% |

The old MC understated the mix's spread and downside and cut its loss probability ~19×.
The "nice properties" once attributed to `mhr` were largely this artifact.

**Action required to take effect.** The saved `data/*/mc_output*.RData`,
`max_sum_plots*.RData`, and `is_*` outputs were produced with the old `fit_id` and are now
stale. Re-render with `run_sim: TRUE` (and `run_is_sim: TRUE`) to regenerate. (Deferred
here because the input data is itself out of date — see §1.)

**Note on IS.** With the new `fit_id`, importance sampling also uses single fits (consistent
black box), but the IS *estimator* bug #4 remains **held** pending confirmation; it is
independent of this change.

---

## 6. Diagnostics added — PPCC, Anderson–Darling, max-sum; and Sharpe ray/curve

Additions requested after the soundness review, to make the goodness-of-fit story honest
under thick tails and to give the investor tool citable results. All live-computed and
rendered in both reports.

**PPCC (supersedes bug #8).** The probability-plot correlation is reported as **PPCC** — the
correlation `r` itself (Filliben), not its square — relabelled from "R²" across both reports'
fit-summary tables and QQ annotations (`fit$ppcc` in `fit_distribution`). Under thick tails an
in-sample R² is inflated, so the appendix caution now states that PPCC, like AIC/BIC, speaks
to the *body* of the distribution, not the tail. (The regression R² in the "Path crossing"
section is a different quantity and was left as "R²".)

**Anderson–Darling (new, `ad_gof()` in functions.R).** Tail-weighted A² against each fitted
CDF, with a **parametric-bootstrap** p-value — simulate from the fit, refit (Nelder-Mead),
recompute A²; 499 reps — because the textbook A² critical values do not apply once the
parameters are estimated from the same sample. Cached like the fits (`ad_df`, `ad_p_df`,
gated on `run_fits`) and displayed per fund × {sstd, std, normal} in the comparison child doc
after AIC/BIC. **Result (monthly, n=142): only the skewed-t survives** — normal rejected
(p ≤ 0.002) and the *symmetric*-t also rejected (p ≈ 0.002–0.01), independently confirming the
ξ ≈ 0.70 left skew (cf. §3). Where AIC/BIC only *rank* the candidates, AD asks whether the best
one is adequate in the tail.

**Max-sum plots (elevated).** Reframed in the individual child doc as the report's primary
moment-existence check (Taleb's GoF tool): for moment `p`, `max|Xᵢ|ᵖ / Σ|Xᵢ|ᵖ` must fall to
zero iff the p-th moment is finite. Positioned as the question that *precedes* PPCC/AIC/BIC
(which presuppose the moments they compare).

**Sharpe ray vs curve (new, both reports).** A live Sharpe-by-window table + verdict near the
"Path crossing" section. **Velliv is a leverage ray** — medium/high Sharpe equal across every
sub-window (within ~0.03), so the risk level is a pure risk-appetite dial. **PFA curves but the
better-Sharpe direction is not identifiable** — the medium profile leads from 2012/2011, the
high profile from 2019/2017, tied in between, all inside the sampling noise. Mirrors the
investor tool's §1, which cites it. (Reports carry only medium+high per provider; the tool
runs the full low/med/high and A–D menus.)

**Render.** Pinned ggplot2 3.5.2 recreated in `.Rlib_pin/` (git-ignored). Monthly: full
re-knit (`run_sim=run_fits=TRUE`). Annual: full re-knit computed all sims, then — after the
bug #10 fix — a fast cache-read re-render exercised the corrected live `sstd_se`. Verified:
0 progress-bar lines, AD/Sharpe/PPCC present, 0 stale "R²" fit-table rownames.
