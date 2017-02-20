data {
  int<lower=0> nObs;          // No. obs.
  int<lower=0> nSites;        // No. groupings (redundant here)
  int<lower=0> site[nSites];  // Indicator values for groupings
  int<lower=0> N[nObs];       // No. sampled newts
  int<lower=0> obs[nObs];     // No. infected newts
  real<lower=0> alpha;        // priors on Omega
  real<lower=0> beta;         // priors on Omega
  real<lower=0> sigma;        // prior on kappa scale
}  

parameters {
  real<lower=0, upper=1> omega;     // avg. amg-site infect prob.
  real<lower=2> kappa;              // similarity of sites
  vector<lower=0, upper=1>[nSites] theta; // w/in-site infect prob.
}

transformed parameters {
  real<lower=0> a;
  real<lower=0> b;
    a = omega * (kappa - 2) +1;
    b = (1 - omega) * (kappa - 2) + 1;
}

model {
  omega ~ beta(alpha,beta);               // prior on omega
  kappa ~ normal(2, sigma);               // prior on kappa
  theta ~ beta(a,b);                      // prior for thetas
    
  // lik. (loop not necessary here but used to show indexing)
  
  for(n in 1:nObs)
  obs[n] ~ binomial(N[n], theta[site[n]]);  
}


