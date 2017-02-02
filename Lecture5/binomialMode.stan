data {
  int<lower=0> nObs; 
  int<lower=0> N[nObs];
  int<lower=0> obs[nObs];   
  real<lower=0, upper=1> omega;  
  real<lower=2> kappa;  
}  

parameters {
  real<lower=0, upper=1> theta;     
}

transformed parameters {
  real<lower=0> a;
  real<lower=0> b;
  
  a = omega * (kappa - 2) + 1;
  b = (1 - omega) * (kappa - 2) + 1;
}

model {
  theta ~ beta(a,b);       // prior on theta
  obs ~ binomial(N, theta);    
}

generated quantities {
  int yNew[nObs];
  
  for (n in 1:nObs) {
    yNew[n] = binomial_rng(N[n], theta);
  }
}
