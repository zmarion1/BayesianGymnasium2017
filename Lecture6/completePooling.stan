data {
  int<lower=0> nObs;          // No. obs.
  int<lower=0> N[nObs];       // No. sampled newts
  int<lower=0> obs[nObs];     // No. infected newts
  real<lower=0> alpha;        // priors on theta
  real<lower=0> beta;         // priors on theta
}  

parameters {
  real<lower=0, upper=1> theta; // grand infect prob.
}

model {
  theta ~ beta(alpha, beta);  // prior for thetas
  obs ~ binomial(N, theta);  
}

