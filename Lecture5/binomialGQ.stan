data {
  int<lower=0> nObs;  // Total number of observations
  int<lower=0> N[nObs];
  int<lower=0> obs[nObs];   // obs as scalar
  real<lower=0, upper=1> omega;  // mode as input data
  real<lower=2> kappa;  // concentration 
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
  obs ~ binomial(N, theta);    
}

generated quantities {
  int yNew[nObs];       // define new data array

  for (n in 1:nObs) {   
    yNew[n] = binomial_rng(N[n], theta);
  }
}

