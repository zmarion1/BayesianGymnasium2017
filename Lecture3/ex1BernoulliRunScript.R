library(shinystan)
library(rstan)
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())
setwd("~/Dropbox/BayesClass/2017 Class/Lecture 3")

obs <- rep(c(1,0), times=c(4,1))
nObs <- length(obs)
dat <- list(obs = obs, nObs = nObs)

mod1 <- stan(file="ex1Bernoulli.stan", data=dat,
             iter=2000, chains=4, seed=3)

traceplot(mod1, par="theta")
traceplot(mod1, par="lp__")
print(mod1)

stan_dens(mod1, par="theta")
stan_hist(mod1,par="theta")

theta <- as.matrix(mod1,par="theta")

