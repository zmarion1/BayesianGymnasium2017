data {
  int<lower=0> nObs;        // Total number of observations
  int<lower=0> N;
  int<lower=0> obs;   // obs as scalar
  real<lower=2> kappa;      // concentration 
  real<lower=0> a_omega;    // priors on Omega
  real<lower=0> b_omega;
}  

parameters {
  real<lower=0, upper=1> omega;     // overall prior mode
  real<lower=0, upper=1> theta;     // prob. of water
}

model {
  omega ~ beta(a_omega,b_omega);
  { // This sets up the a & b for theta as local parameters and doesnt save them.
    real a;
    real b;
    a = omega * (kappa - 2) +1;
    b = (1 - omega) * (kappa - 2) + 1;
    theta ~ beta(a,b);                
  }
  obs ~ binomial(N, theta);    
}

