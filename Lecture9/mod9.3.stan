data {
  int<lower=0> nObs;
  int<lower=0> nVar;      // no. vars
  vector[nObs] obs;
  matrix[nObs, nVar] X;
  real<lower=0> bMu;      // mean of prior betas
  real<lower=0> bSD;      // SD of prior beta
  real<lower=0> sigmaSD;  // scale for sigma
}

parameters {
  vector[nVar] beta;
  real<lower=0> sigma;
}

transformed parameters {
  // can be useful for plotting purposes
  vector[nObs] mu;
  mu = X*beta;
}

model {
  beta ~  normal(bMu, bSD);
  sigma ~ cauchy(0, sigmaSD);

  obs ~ normal(mu, sigma);
}

generated quantities {
  vector[nObs] log_lik;
  
  for(n in 1:nObs)
    log_lik[n] = normal_lpdf(obs[n] | mu[n], sigma);
}
