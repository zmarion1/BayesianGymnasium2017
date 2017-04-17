data {
  int<lower=0> nObs;
  int<lower=0> nVar;      // no. vars
  int<lower=0> obs[nObs]; // no. successes (or failures)
  int<lower=0> N[nObs];   // Total no. trials
  matrix[nObs, nVar] X;   // design matrix
  real<lower=0> bMu;      // mean of prior betas
  real<lower=0> bSD;      // SD of prior beta
}

parameters {
  vector[nVar] beta;
}

transformed parameters {
  vector[nObs] p;
  p = X * beta;
}

model {
  beta ~ normal(bMu, bSD);
  obs ~ binomial_logit(N, p);
}

generated quantities {
  vector[nObs] log_lik;

  for(n in 1:nObs)
    log_lik[n] = binomial_logit_lpmf(obs[n] | N[n], p[n]);
}

