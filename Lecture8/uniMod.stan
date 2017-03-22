data {
  int<lower=0> nObs;  
  vector[nObs] obs;   
  vector[nObs] xvar;      // x variable
  real<lower=0> aSD;      // SD of prior alpha
  real<lower=0> bSD;      // SD of prior beta
  real<lower=0> sigmaSD;  // scale for sigma
}

parameters {
  real alpha;
  real beta;
  real<lower=0> sigma;
}

transformed parameters {
  // can be useful for plotting purposes
  vector[nObs] mu;
  mu = alpha + beta*xvar;
}

model {
  alpha ~ normal(0, aSD);
  beta ~  normal(0, bSD);
  sigma ~ cauchy(0, sigmaSD);

  obs ~ normal(mu, sigma);
}

