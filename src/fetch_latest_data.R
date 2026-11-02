## Fetch the latest monthly returns into data/latest/, for the investor tool.
## data/monthly/ stays frozen: It is the case study of the returns reports.
##
## PFA:    The PFA Plus monthly returns feed behind https://www.pfa.dk/privat/opsparing/pfa-afkast/
##         Saved as published. The tool reads afkast_maaned (Kundeafkast incl. KundeKapital) at
##         30 years to pension. Profiles forsigtig/lav/medium/hoej are the former A/B/C/D: The feed
##         restates their history, and from 1 April 2025 Lav and Middel carry the new weights.
## Velliv: The "Langsigtet udvikling" chart on
##         https://www.velliv.dk/opsparing/vaekstpension/vaekstpension-aktiv/afkast
##         (VaekstPension, 15 years to pension, index 30 June 2012 = 100), an everviz embed with
##         its data inline as CSV. Written in the format of data/monthly/velliv_monthly_prices.csv:
##         ISO month-end dates, and low/high copied from medium before the plans split in 2012.
##
## Run from the project root:  Rscript src/fetch_latest_data.R
## The feed and chart addresses are the providers'; if one moves, find the new one in the
## page's network requests (PFA) or iframe sources (Velliv).

library(here)
library(jsonlite)

out_dir    <- here("data", "latest")
pfa_url    <- "https://publish-p135237-e1337543.adobeaemcloud.com/content/dam/afkast/data/returns.json"
velliv_url <- "https://app.everviz.com/embed/QjzA4St16/"
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)

## --- PFA ---
pfa_file <- file.path(out_dir, "pfa_monthly.json")
download.file(pfa_url, pfa_file, quiet = TRUE, mode = "wb")
j <- fromJSON(pfa_file, simplifyVector = FALSE)
stopifnot(!is.null(j$afkast_maaned$afkast))
pfa_last <- max(unlist(lapply(j$afkast_maaned$afkast, function(y)
  sapply(Filter(function(m) m$maaned != "YTD", y$maaneder),
         function(m) sprintf("%d-%02d", as.integer(y$aar), as.integer(m$maaned))))))

## --- Velliv ---
html <- paste(readLines(velliv_url, warn = FALSE, encoding = "UTF-8"), collapse = "\n")
lit  <- regmatches(html, regexpr('"data"\\s*:\\s*\\{\\s*"csv"\\s*:\\s*"(?:[^"\\\\]|\\\\.)*"', html, perl = TRUE))
if (length(lit) != 1) stop("No inline CSV found in the Velliv chart embed: ", velliv_url)
csv <- fromJSON(paste0("[", sub('^"data"\\s*:\\s*\\{\\s*"csv"\\s*:\\s*', "", lit), "]"))
v   <- read.csv(text = csv, sep = ";", check.names = FALSE, stringsAsFactors = FALSE,
                colClasses = "character")
col <- function(pattern) v[[grep(pattern, names(v), ignore.case = TRUE)[1]]]
num <- function(x) suppressWarnings(as.numeric(gsub(",", ".", x)))
v <- data.frame(date        = as.Date(v[[1]], format = "%d-%m-%Y"),
                low_risk    = num(col("low risk")),
                medium_risk = num(col("medium risk")),
                high_risk   = num(col("high risk")),
                guarantee   = num(col("garanti|guarantee")))
v <- v[!is.na(v$date) & !is.na(v$medium_risk), ]
v <- v[order(v$date), ]
for (k in c("low_risk", "high_risk", "guarantee"))
  v[[k]][is.na(v[[k]])] <- v$medium_risk[is.na(v[[k]])]
write.csv(v, file.path(out_dir, "velliv_monthly_prices.csv"), row.names = FALSE)

cat(sprintf("PFA:    %s (last month %s)\nVelliv: %s (%s to %s)\n",
            pfa_file, pfa_last, file.path(out_dir, "velliv_monthly_prices.csv"),
            format(min(v$date), "%Y-%m"), format(max(v$date), "%Y-%m")))
