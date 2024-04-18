
library("fGarch")
library(RColorBrewer)
library(scales)
library(dplyr)
library(ggplot2)

## Calculate risk percentiles.
## data can be a data frame or a list of data frames.
# risk_percentiles <- function(data, percent, max_or_min) {
#   init_capital = 100
#   if(!is.list(data)) {
#     init_capital = 100
#   } else {
#     init_capital <- init_capital/length(data)
#     vect <- data[[1]]
#     if(length(data) > 1) {
#       for(i in 2:length(data)) {
#         vect <- vect + data[[i]]
#       }
#     }
#     data <- vect
#   }
#   if(max_or_min == "max"){
#       init_capital * (length(which(data < (100 - percent)/100)) + 0.5) / 1000
#     } else {
#       init_capital * (length(which(data > (100 + percent)/100)) + 0.5) / 1000
#     }
# }

## dist_data is given as log returns.
risk_percentiles <- function(dist_data, percent, max_or_min) {
  num_points <- length(dist_data)
  log_returns <- sort(dist_data)
  if(max_or_min == "max"){
    100 * (length(which(dist_data < log((100 - percent)/100)))) / num_points
  } else {
    100 * (length(which(dist_data > log((100 + percent)/100)))) / num_points
  }
}
risk_percentiles <- Vectorize(risk_percentiles, "percent")

## Estimate risk
risk_estimate <- function(dist_data, max_or_min = "max", percent) {
  if(max_or_min == "max") {
    cat("What is the risk of losing max", percent,"%? =<", risk_percentiles(dist_data, percent, max_or_min), "percent\n")
  } else {
    cat("What is the chance of gaining min", percent,"%? >=",risk_percentiles(dist_data, percent, max_or_min), "percent\n")
  }
}

## down_and_out_df() takes a data frame as input.
## For each column, the first element which is below the threshold and all following elements
## are set to 0.
down_and_out_df <- function(df, threshold) {
  ll <- lapply(df,
               function(vect) {
                 n <- length(vect) 
                 for(i in seq_along(vect)) {
                   if(vect[i] < threshold ) {
                     if(i == n) {break}
                     vect[(i):n] <- rep(0, n - i + 1)
                     break
                   }
                 }
                 vect
               }
  )
  as.data.frame(ll)
}

down_and_out_vect <- function(vect, threshold) {
  n <- length(vect) 
  for(i in seq_along(vect)) {
    if(vect[i] < threshold ) {
      if(i == n) {break}
      vect[(i):n] <- rep(0, n - i + 1)
      break
    }
  }
  vect
}

count_num_dao <- function(df, threshold = 0) {
  length(which(df[nrow(df), ] <= threshold))
}

df_summary_to_df <- function(df_summary) {
  summary_df_pre <- as.data.frame(df_summary)
  summary_levels <- levels(summary_df_pre$Var2)
  summary_df <- data.frame(
    matrix(
      length(summary_levels), 
      nrow=nrow(
        summary_df_pre[summary_df_pre$Var2 == summary_levels[[1]], ]
      )
    )
  )
  summary_df_2 <- summary_df
  for(i in seq_along(summary_levels)) {
    summary_df[, i] <- summary_df_pre[summary_df_pre$Var2 == summary_levels[i], "Freq"]
  }
  
  row_names <- c("Min.   :", "1st Qu.:", "Median :", "Mean   :", "3rd Qu.:", "Max.   :")
  for(i in 1:nrow(summary_df)) {
    for(j in 1:ncol(summary_df)) {
      summary_df_2[i, j] <- as.numeric(gsub(row_names[i], "", summary_df[i, j]))
    }
  }
  names(summary_df_2) <- unlist(lapply(summary_levels, function(x) {gsub(" ", "", x)}))
  row.names(summary_df_2) <- row_names
  summary_df_2
}

## Rank funds for each metric in a summary data frame
## sorting is a list of elements being either "hi" or "lo", one element for each
## metric. If "hi", sort descending, if "lo", sort ascending.
rank_summary <- function(summary_df, sorting) {
  ll <- list()
  for(i in 1:nrow(summary_df)) {
    ll[[i]] <- data.frame(unlist(summary_df[i, ]), colnames(summary_df))
    #colnames(ll[[i]]) <- c(rownames(summary_df)[i], paste0(rownames(summary_df)[i], "_ranking"))
    colnames(ll[[i]]) <- c(rownames(summary_df)[i], "ranking")
    ifelse(
      sorting[i] == "hi",
      ll[[i]] <- arrange(
        ll[[i]],
        desc(
          get(colnames(ll[[i]])[1])
        )
      ),
      ll[[i]] <- arrange(
        ll[[i]],
        get(colnames(ll[[i]])[1])
      )
    )
    ifelse(
      i == 1,
      mc_rankings <- ll[[i]],
      mc_rankings <- cbind(mc_rankings, ll[[i]])
    )
  }
  
  rownames(mc_rankings) <- 1:nrow(mc_rankings)
  mc_rankings
}

max_sum <- function(data_vector, p = 1) {
  ms <- c()
  x <- data_vector
  for(n in seq_along(data_vector)) {
    ms[n] <- max(x[1:n]^p) / sum(x[1:n]^p)
  }
  ms
}

plot_max_sum <- function(fit, num_periods) {
  ms_log_returns <- rsstd(num_periods - 1, fit$m, fit$s, fit$nu, fit$xi)
  par(mfrow = c(2, 2))
  lapply(1:4, function(p) {
    ms_vector <- max_sum(ms_log_returns, p)
    plot(ms_vector, type = "l", ylim = c(min(ms_vector), max(ms_vector)), xlab = "n", ylab = paste0("MS(", p, ")"), main = paste0("MS(", p, ")")
    )
  })
  par(mfrow = c(1, 1))
}


fit_gauss <- function(x, method = "Nelder-Mead") {
  loglik_sstd = function(beta) sum(- dnorm(x, mean = beta[1], sd = beta[2], log = TRUE))
  start = c(mean(x), sd(x))
  #fit_sstd = optim(start, loglik_sstd, hessian = F, method="L-BFGS-B", lower = c(0, 0.1, 1.1, -2))
  optim(start, loglik_sstd, method = method)
}



## Fit data to a skewed t distribution
fit_skewed_t <- function(x, method = "BFGS") {
  loglik_sstd = function(beta) sum(- dsstd(x, mean = beta[1], sd = beta[2], nu = beta[3], xi = beta[4], log = TRUE))
  start = c(mean(x), sd(x), 3, 1)
  #fit_sstd = optim(start, loglik_sstd, hessian = F, method="L-BFGS-B", lower = c(0, 0.1, 1.1, -2))
  fit_sstd = optim(start, loglik_sstd, method = method)
  
  n = length(x)
  
  AIC_sstd = 2 * fit_sstd$value + 2 * 4
  BIC_sstd = 2 * fit_sstd$value + log(n) * 4
  #sd_sstd = sqrt(diag(solve(fit_sstd$hessian)))
  cat("\n")
  #cat("sd_sstd:", sd_sstd)
  cat("AIC:", AIC_sstd, "\n")
  cat("BIC:", BIC_sstd, "\n")
  
  # Middelværdi:
  mu_sstd_fit <- fit_sstd$par[1]#/1000
  cat("m:", mu_sstd_fit, "\n")
  
  # Spredning:
  sigma_sstd_fit <- fit_sstd$par[2]#/1000
  cat("s:", sigma_sstd_fit, "\n")
  
  # Frihedsgrader:
  nu_sstd_fit <- fit_sstd$par[3] # 3.36019
  cat("nu (df):", nu_sstd_fit, "\n")
  
  xi_sstd_fit <- fit_sstd$par[4] # 0.8436514
  cat("xi:", xi_sstd_fit, "\n")
  
  fit <- qsstd((1:n - 0.5)/n, mean = fit_sstd$par[1], sd = fit_sstd$par[2], nu = fit_sstd$par[3], xi = fit_sstd$par[4])
  
  r_squared <- cor(sort(fit), sort(x))
  # R^2
  r_squared_round <- round(r_squared, 3)
  cat("R^2:", r_squared_round, "\n")
  cat("\n")
  
  range_cuts <- c(0.0, 0.5, 0.9, 0.95, 0.99, 1.0)
  interpretations <- c(
    paste0("An R^2 of ", r_squared_round, " suggests that the fit is not great."),
    paste0("An R^2 of ", r_squared_round, " suggests that the fit is not completely random."),
    paste0("An R^2 of ", r_squared_round, " suggests that the fit is good."),
    paste0("An R^2 of ", r_squared_round, " suggests that the fit is very good."),
    paste0("An R^2 of ", r_squared_round, " suggests that the fit is extremely good.")
  )
  
  cat(interpretations[findInterval(r_squared_round, range_cuts)])
  cat("\n")
  cat("\n")
  
  dist_data <- qsstd((1:1000 - 0.5)/1000, mean = fit_sstd$par[1], sd = fit_sstd$par[2], nu = fit_sstd$par[3], xi = fit_sstd$par[4])
  
  dens_data <- dsstd((-299:300 - 0.5)/1000, mean = fit_sstd$par[1], sd = fit_sstd$par[2], nu = fit_sstd$par[3], xi = fit_sstd$par[4])
  
  sample_mean <- mean(dist_data)
  
  risk_estimate(dist_data, "max", 10)
  risk_estimate(dist_data, "max", 25)
  risk_estimate(dist_data, "max", 50)
  risk_estimate(dist_data, "max", 90)
  risk_estimate(dist_data, "max", 99)
  cat("\n")
  risk_estimate(dist_data, "min", 10)
  risk_estimate(dist_data, "min", 25)
  risk_estimate(dist_data, "min", 50)
  risk_estimate(dist_data, "min", 90)
  risk_estimate(dist_data, "min", 99)
  
  theoretical_quantiles <- qsstd(ppoints(n), mu_sstd_fit, sigma_sstd_fit, nu_sstd_fit, xi_sstd_fit)
  
  output <- list(
    # Plot with estimated skewed t-distribution
    # qq plot for t-distribution
    qqplot = function() {qqplot(x = theoretical_quantiles, y = x, main = "QQ-plot, skewed t", xlab = "skewed t-quantiles", ylab = "log returns", xlim = c(min(fit) - abs(min(fit))/10, max(fit) + abs(max(fit))/10),  ylim = c(min(x) - abs(min(x))/10, max(x) + abs(max(x))/10))
      mtext(paste0("my=", round(mu_sstd_fit, 4),", sigma =", round(sigma_sstd_fit, 4),", df=",round(nu_sstd_fit, 3), ", xi =", round(xi_sstd_fit, 3), ", R^2=", r_squared_round), side=3,  cex = 0.8, adj=0)
      qqline(x, distribution = function(p) qsstd(p, mu_sstd_fit, sigma_sstd_fit, nu_sstd_fit, xi_sstd_fit), datax = FALSE, col="black")
      abline(0, 1, col = "red")
      legend("bottomright", legend = c("data trendline", "45 degree line"), col = c("black", "red"), lty = c(1, 1))
    },
    fit_plot = function() {
      plot(sort(x), col="blue", ylab = "log returns", main = "Data vs fit",
           ylim = c(min(c(x, fit)), max(c(x, fit))))
      points(sort(fit), col="red")
      legend("bottomright", legend = c("data", "fit"), col = c("blue", "red"), pch = c(1, 1))
    },
    dist_plot = function() {
      plot(sort(dist_data), pch = 16, cex = 0.3, main = "Estimated skew t distribution CDF")
      abline(a = 0, b = 0, col = "red")
    },
    dens_plot = function() {
      plot(x = (-299:300 - 0.5)/1000, y = dens_data, cex = 0.3, pch = 16, xlab = "log-return", ylab = "likelihood", main = "Estimated skew t distribution PDF",
           sub = paste0("m = ", round(mu_sstd_fit, 3), ", sample mean = ", round(sample_mean, 3)))
      abline(v = mu_sstd_fit, col = "red")
      abline(v = sample_mean, lty = 2, col = "blue")
      legend("topleft", legend = c("density", "m", "sample mean"), col = c("black", "red", "blue"), lty = c(1, 1, 2))
    },
    data = x,
    fit = fit,
    dist_data = dist_data,
    dens_data = dens_data,
    m = mu_sstd_fit,
    s = sigma_sstd_fit,
    nu = nu_sstd_fit,
    xi = xi_sstd_fit,
    r_squared = r_squared,
    theoretical_quantiles = theoretical_quantiles
  )
  
  comment(output) <- "single_fit"
  output
}





## Monte Carlo simulation
## Creates a data frame where each column is a simulated series, and the number 
## of rows is the number of periods in each series.
## The fit parameter can be a single output from fit_skewed_t(), or a list of 
## outputs from fit_skewed_t().
## mc_simulation() will create a separate simulation for each fit, dividing an 
## initial value of 100 between them, and then add the simulations together.
## For instance, if there are two fits, the first column of the simulations data 
## frame for the first fit will be added to the first column of the second df, ect.
## If dao=TRUE, will calculate down-and-out paths. For each column, the first 
## element which is below the threshold and all following elements are set to 0.

mc_simulation <- function(
    fit, 
    num_paths = 1000, 
    num_periods = 20,
    dao = TRUE,
    threshold = 0.01
) {
  init_capital = 100
  
  qual_col_pals = brewer.pal.info[brewer.pal.info$category == 'qual',]
  col_vector = unlist(mapply(brewer.pal, qual_col_pals$maxcolors, rownames(qual_col_pals)))
  
  ## Each single fit has comment "single_fit".
  ## A list if fits will not have a comment.
  if(is.null(comment(fit))) {
    ## A list of fits
    init_capital = 100/length(fit)
    mc_df <- data.frame(matrix(rep(0, num_paths * num_periods), nrow = num_periods))
    for(i in seq_along(fit)) {
      for(j in 1:num_paths) {
        mc_df[ ,j] <- mc_df[ ,j] + c(init_capital, init_capital * exp(cumsum(rsstd(num_periods - 1, fit[[i]]$m, fit[[i]]$s, fit[[i]]$nu, fit[[i]]$xi))))
      }
    }
  } else {
    if(comment(fit) == "single_fit") {
      mc_df <- data.frame(rep(0, num_periods))
      for(j in 1:num_paths) {
        mc_df[ ,j] <- c(init_capital, init_capital * exp(cumsum(rsstd(num_periods - 1, fit$m, fit$s, fit$nu, fit$xi))))
      }
    }
  }
  
  
  if(dao == TRUE) {
    mc_df <- down_and_out_df(mc_df, threshold)
    num_dao <- count_num_dao(mc_df)
    dao_probability_percent <- 100 * num_dao/num_paths
    
    cat("Down-and-out simulation:\n")
    cat("Probability of down-and-out:", dao_probability_percent, "percent\n")
    cat("\n")
  } else {
    cat("Simulation (ignoring down-and-out):\n")
    dao_probability_percent <- NA
  }
  
  colnames(mc_df) <- 1:num_paths
  
  mc_m <- mean(unlist(mc_df[num_periods, ]))
  mc_s <- sd(unlist(mc_df[num_periods, ]))
  mc_min <- min(unlist(mc_df[num_periods, ]))
  mc_max <- max(unlist(mc_df[num_periods, ]))
  
  ## Confidence intervals
  h_vect <- unlist(mc_df[num_periods, ]) ## Last row
  mu_hat <- cumsum(h_vect) / 1:num_paths
  sigma_hat <- numeric(num_paths)
  dev <- numeric(num_paths)
  ci_l <- numeric(num_paths) ## c.i. lower
  ci_u <- numeric(num_paths) ## c.i. upper
  for(i in 1:num_paths) {
    sigma_hat[i] <- sd(h_vect[1:i]) ## sd for paths 1 thru i
    dev[i] <- 1.96 * sigma_hat[i] / sqrt(i)
    ci_l <- mu_hat - dev[i]
    ci_u <- mu_hat + dev[i]
  }
  
  percent_losing_paths <- 100 * count_num_dao(mc_df, threshold = 100)/num_paths
  
  cat("Mean portfolio index value after", num_periods, "years:", round(mc_m, 3), "kr.\n")
  cat("SD of portfolio index value after", num_periods, "years:", round(mc_s, 3), "kr.\n")
  cat("Min total portfolio index value after", num_periods, "years:", round(mc_min, 3), "kr.\n")
  cat("Max total portfolio index value after", num_periods, "years:", round(mc_max, 3), "kr.\n")
  cat("\n")
  cat("Share of paths finishing below 100:", percent_losing_paths, "percent")
  
  list(
    mc_plot = function() {
      plot(mc_df[, 1], type = "l", ylim = c(min(mc_df), max(mc_df)), xlab = "period", ylab = "Portfolio index value in kr", main = paste0("MC simulation ", ifelse(dao == TRUE, "with down-and-out", "ignoring down-and-out")), sub = paste0("Number of paths: ", num_paths, ", number of periods: ", num_periods))
      lapply(mc_df[, -1], function(x) {
        lines(x, col = alpha(sample(col_vector, num_paths, replace = TRUE), 0.3))}
      )
      abline(100, 0, lwd=1, col="red")
    },
    mc_plot_last_period = function() {
      plot(
        sort(unlist(mc_df[num_periods, ])), pch = 16, cex = 0.3,
        xlab = "Sample ID",
        ylab = "Portfolio index value in kr"
      )
      abline(100, 0, lwd=1, col="red")
      mtext(side=3, line=2, at=-0.07, adj=0, cex=1, "Sorted portfolio index values for last period of all runs")
      mtext(side=3, line=1, at=-0.07, adj=0, cex=0.7, "(100 is par, 200 is double, 50 is half)")
    },
    mc_conv_plot = function() {
      df_conv <- data.frame(t = 1:num_paths, mu_hat = mu_hat, ci_l = ci_l, ci_u = ci_u)
      ggplot(df_conv, aes(x = t, y = mu_hat)) + 
      geom_ribbon(
        mapping = aes(
          ymin = ci_l, 
          ymax = ci_u
        ), fill = "gray") +
      ylim(min(ci_l), max(ci_u)) +
      geom_line() + 
      labs(title = paste("Monte Carlo convergence w/ 95% c.i."), subtitle = paste(num_periods, "steps,", num_paths, "paths"), x = "number of paths", y = "mu_hat")
    },
    mc_m = mc_m,
    mc_s = mc_s,
    mc_min = mc_min,
    mc_max = mc_max,
    mc_df = mc_df,
    dao_probability_percent = dao_probability_percent,
    percent_losing_paths = percent_losing_paths,
    mu_hat = mu_hat,
    ci_l = ci_l,
    ci_u = ci_u
  )
}




