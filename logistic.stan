// most of this is straight from the STAN manual, with some tweaks:
// 1. restricting beta to be positive, since this is a dose response model

data {
  int<lower=1> D;     // number of predictors - leaving this here for strain comparisons
  int<lower=0> N;     // number of observations
  int<lower=1> L;     // number of replicates
  array[N] int<lower=0,upper=1> y;      // observation vector
  array[N] int<lower=1,upper=L> ll;     // replicate designation (1 through L)
  array[N] row_vector[D] x;     // predictors (dose)
}
parameters {
  array[D] real mu;     // mean
  array[D] real<lower=0> sigma;   // standard dev, positive restriction
  array[L] vector<lower=0>[D] beta; // restrict the coefficients to be positive
}
model {
  for (d in 1:D) {
    mu[d] ~ normal(0, 100);
    for (l in 1:L) {
      beta[l, d] ~ normal(mu[d], sigma[d]);
    }
  }
  for (n in 1:N) {
    y[n] ~ bernoulli(inv_logit(x[n] * beta[ll[n]]));
  }
}