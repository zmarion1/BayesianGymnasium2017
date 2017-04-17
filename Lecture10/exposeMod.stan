data {
  int<lower=0> nObs;
  int<lower=0> obs[nObs]; // no. successes (or failures)
  vector<lower=0>[nObs] expose;
  vector[nObs] state;   // design matrix
}

parameters {
  real alpha;
  real beta;
}

transformed parameters {
  vector[nObs] lambda;
  
  lambda =alpha + beta*state + log(expose);
}
model {
 alpha ~ normal(0, 10);
  beta ~ normal(0, 1);

  obs ~ poisson_log(lambda);
}

