data {
  int<lower=0> nObs;
  int<lower=0> nVar;      // no. vars
  vector[nObs] obs;
  matrix[nObs, nVar] X;
  real<lower=0> aMu;      // mean of prior alpha
  real<lower=0> aSD;      // SD of prior alpha
  real<lower=0> bMu;      // mean of prior betas
  real<lower=0> bSD;      // SD of prior beta
  real<lower=0> sigmaSD;  // scale for sigma
}

parameters {
  real alpha;
  vector[nVar] beta;
  real<lower=0> sigma;
}

model {
  alpha ~ normal(aMu, aSD);
  beta ~  normal(bMu, bSD);
  sigma ~ cauchy(0, sigmaSD);
  {
    vector[nObs] mu;
    mu = alpha + X*beta;
    
    obs ~ normal(mu, sigma);  
  }
}

