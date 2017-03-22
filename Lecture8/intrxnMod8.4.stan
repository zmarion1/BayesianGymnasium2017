data {
  int<lower=0> nObs;
  vector[nObs] obs;
  vector[nObs] R;
  vector[nObs] A;
  real<lower=0> aMu;      // mean of prior alpha
  real<lower=0> aSD;      // SD of prior alpha
  real<lower=0> bMu;      // mean of prior betas
  real<lower=0> bSD;      // SD of prior beta
  real<lower=0> sigmaSD;  // scale for sigma
}

parameters {
  real alpha;
  real betaR;
  real betaA;
  real betaAR;
  real<lower=0> sigma;
}

transformed parameters {
  vector[nObs] mu;
  vector[nObs] gamma;
  
  gamma = betaR + betaAR*A;
  // elementwise multiplication (.*)!
  mu = alpha + gamma .* R + betaA*A; 
}

model {
  alpha ~ normal(aMu, aSD);
  betaR ~  normal(bMu, bSD);
  betaA ~  normal(bMu, bSD);
  betaAR ~  normal(bMu, bSD);
  sigma ~ cauchy(0, sigmaSD);

  obs ~ normal(mu, sigma);
}

