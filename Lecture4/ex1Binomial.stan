data {
  int<lower=0> nObs;  // Total number of observations
  int<lower=0> obs;   // obs as scalar
  real<lower=0> a;    // a & b are now input as data
  real<lower=0> b;    //    rather than hard-coded
}  

parameters {
  real<lower=0, upper=1> theta;     // prob. of water
}

model {
  theta ~ beta(a,b);                // prior on theta
  obs ~ binomial(nObs, theta);      // binomial likelihood
}

