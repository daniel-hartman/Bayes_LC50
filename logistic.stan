data {
  int<lower=0> N;     // number of observations
  int<lower=1> L;     // number of replicates
  array[N] int<lower=0, upper=1> y;
  array[N] int<lower=1, upper=L> ll;     // replicate designation (1 through L)
  array[N] real x;     // predictors (dose)
}
parameters {
  real mu;     // mean
  real<lower=0> sigma;   // standard dev, positive restriction
  array[L] real beta; 
}
model {
  mu ~ normal(0, 100);
  for (l in 1:L) {
    beta[l] ~ normal(mu, sigma);
  }
  for (n in 1:N) {
    y[n] ~ bernoulli(inv_logit(x[n] * beta[ll[n]]));
  }
}