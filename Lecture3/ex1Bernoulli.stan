data {
  int<lower=0> nObs;
  int<lower=0, upper=1> obs[nObs];
}

parameters {
  real<lower=0, upper=1> theta;
}

model {
  theta ~ beta(1, 1);
  for(n in 1:nObs) {
    obs[n] ~ bernoulli(theta);
  }
}


