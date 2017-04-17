data {
  int<lower=0> nObs;
  int<lower=0> nVar; // no. vars
  int<lower=0> nNew;
  int<lower=0> nVarN;
  int<lower=0> obs[nObs]; // no. successes (or failures)
  matrix[nObs, nVar] X;   // design matrix
  matrix[nNew, nVarN] newX;
  real bMu;   
  real b0SD;
  real<lower=0> bSD;      // SD of prior beta
}

parameters {
  vector[nVar] beta;
}

transformed parameters {
  vector[nObs] lambda;
  
  lambda = X * beta;
}
model {
  beta[1] ~ normal(bMu, b0SD);
  beta[2:nVar] ~ normal(bMu, bSD);

  obs ~ poisson_log(lambda);
}

generated quantities {
  vector[nObs] log_lik;
  vector[nNew] newLam;

  for(n in 1:nObs)
  log_lik[n] = poisson_log_lpmf(obs[n]|lambda[n]);

  newLam = newX * beta;
}

