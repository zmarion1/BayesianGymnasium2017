data {
  int<lower=0> nObs;
  int<lower=0> nVar;      // no. vars
  vector[nObs] obs;
  vector[nObs] x1;  
  vector[nObs] x2;  
  real<lower=0> aSD;      // SD of prior alpha
  real<lower=0> bSD;      // SD of prior beta
  real<lower=0> sigmaSD;  // scale for sigma
}

transformed data {
  matrix[nObs, nVar] X;
  
  X = append_col(x1, x2);   
}

parameters {
  real alpha;
  vector[nVar] beta;
  real<lower=0> sigma;
}

transformed parameters {
  // can be useful for plotting purposes
  vector[nObs] mu;
  mu = alpha + X*beta;
}

model {
  alpha ~ normal(0, aSD);
  beta ~  normal(0, bSD);
  sigma ~ cauchy(0, sigmaSD);

  obs ~ normal(mu, sigma);
}

generated quantities {
  // Generate new counterfactual data by holding other
  // variable at mean value
  vector[nObs] muCH; 
  vector[nObs] muSS;
  
    muCH = alpha + beta[1]*X[,1];
    muSS = alpha + beta[2]*X[,2];
}

