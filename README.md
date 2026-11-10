# pension-returns

Return analyses of the pension plans at Velliv and PFA, tools for deciding what
to do with the savings, and working notes on fat-tailed statistics. By Martin
Hoshi Vognsen.

**→ Read them at [mahovo.github.io/pension-returns](https://mahovo.github.io/pension-returns/)**

## On the site

| Document | Question | Language | Source |
|---|---|---|---|
| [Choosing a pension plan: An investor's advanced decision tool](https://mahovo.github.io/pension-returns/pension-returns_investor.html) | Which risk level, and one provider or both? | English | [`pension-returns_investor.Rmd`](pension-returns_investor.Rmd) |
| [Kapital eller rate](https://mahovo.github.io/pension-returns/kapital-eller-rate.html) | Hvad er en kapitalpension værd, hvis den laves om til ratepension? | Dansk | [`kapital-eller-rate.html`](kapital-eller-rate.html) |
| [Annual pension returns analysis](https://mahovo.github.io/pension-returns/pension-returns_annual.html) | How far does inference degrade when only annual data is available? | English | [`pension-returns_annual.Rmd`](pension-returns_annual.Rmd) |
| [Notes on Taleb's kappa](https://mahovo.github.io/pension-returns/misc_docs/taleb_kappa.pdf) (PDF) | How many Student t summands match the convergence of n Gaussian ones? | English | [`misc_docs/taleb_kappa.Rmd`](misc_docs/taleb_kappa.Rmd) |
| [A study of the skewed generalized t-distribution](https://mahovo.github.io/pension-returns/misc_docs/sgt.pdf) (PDF) | How do the parameters of a skewed t change when returns are summed? | English | [`misc_docs/sgt.Rmd`](misc_docs/sgt.Rmd) |
| [Importance sampling of return paths](https://mahovo.github.io/pension-returns/misc_docs/pensionsafkast_IS.pdf) (PDF) | Can a normal proposal sample skewed t return paths efficiently? | English | [`misc_docs/pensionsafkast_IS.Rmd`](misc_docs/pensionsafkast_IS.Rmd) |

## Publishing

[`.github/workflows/pages.yml`](.github/workflows/pages.yml) deploys the site on
every push to `main`. The site is [`index.html`](index.html) plus every local
file it links to. To publish another document, add a card for it there.

Nothing is rendered in CI. The reports need the simulation caches and the
pinned ggplot2 in `.Rlib_pin`, and both are git-ignored. Knit the reports
locally and commit the output.
