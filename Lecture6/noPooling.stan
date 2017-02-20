data {
  int<lower=0> nObs;          // No. obs.
  int<lower=0> nSites;        // No. groupings (redundant here)
  int<lower=0> site[nSites];  // Indicator values for groupings
  int<lower=0> N[nObs];       // No. sampled newts
  int<lower=0> obs[nObs];     // No. infected newts
  real<lower=0> alpha;        // priors on thetas
  real<lower=0> beta;         // priors on thetas
}  

parameters {
  vector<lower=0, upper=1>[nSites] theta; // w/in-site infect prob.
}

model {
  theta ~ beta(alpha, beta);      // prior for thetas
    
  // lik. (loop not necessary here but used to show indexing)
  
  for(n in 1:nObs)
  obs[n] ~ binomial(N[n], theta[site[n]]);  
}


