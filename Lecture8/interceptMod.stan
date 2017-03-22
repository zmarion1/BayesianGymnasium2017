data {
  int<lower=0> nObs;
  int<lower=0> nVar;      // no. vars
  vector[nObs] obs;
  int x[nObs];
  real<lower=0> aMu;      // mean of prior alpha
  real<lower=0> aSD;      // SD of prior alpha
  real<lower=0> sigmaSD;  // scale for sigma
}

parameters {
  vector[nVar] alpha;
  real<lower=0> sigma;
}

model {
  alpha ~ normal(aMu, aSD);
  sigma ~ cauchy(0, sigmaSD);
  {
    vector[nObs] mu;
    mu = alpha[x];
    
    obs ~ normal(mu, sigma);  
  }
}

