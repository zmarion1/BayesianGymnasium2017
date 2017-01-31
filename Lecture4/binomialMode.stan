data {
  int<lower=0> nObs;              // Total number of observations
  int<lower=0> obs;               // obs as scalar
  real<lower=0, upper=1> omega;  // mode as input data
  real<lower=2> kappa;           // concentration as input data
}  

parameters {
  real<lower=0, upper=1> theta;     // prob. of water
}

transformed parameters {
  real<lower=0> a;
  real<lower=0> b;
  
  a = omega * (kappa - 2) + 1;
  b = (1 - omega) * (kappa - 2) + 1;
}

model {
  theta ~ beta(a,b);                // prior on theta
  obs ~ binomial(nObs, theta);      // likelihood
}

