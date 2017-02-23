data {
  int<lower=0> nObs;          // No. obs.
  vector<lower=0>[nObs] BM;   // biomass observations
  real<lower=0> muMean;       // mean of prior mu
  real<lower=0> muSD;         // SD of prior mu
  real<lower=0> sigmaSD;      // scale for sigma
}  

parameters {
  real mu;
  real<lower=0> sigma;
}

model {
  mu ~ normal(muMean, muSD);
  sigma ~ cauchy(0, sigmaSD);
  
  BM ~ normal(mu, sigma);
}

