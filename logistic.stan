data {
  int<lower=0> N;           // number of observations
  int<lower=1> L;           // number of replicates
  // real<lower=0> P;          // number of doses to calculate posterior predictions over
  array[N] int<lower=0, upper=1> y;   // mortality data
  array[N] int<lower=1, upper=L> ll;     // replicate designation (1 through L)
  array[N] real x;          // predictors (dose)
  // int<lower=0> N_tilde      // how many data points to predict over (new doses)
  // array[N_tilde] int x_tilde  // vector of new doses to predict over   
}
parameters {
  real mu;     // mean
  real<lower=0> sigma;   // standard dev, positive restriction
  real b_0; // y-intercept
  array[L] real beta; 
}
model {
  mu ~ normal(0, 100); //validate this
  b_0 ~ normal(0,50);
  for (l in 1:L) {
    beta[l] ~ normal(mu, sigma);
  }
  for (n in 1:N) {
    y[n] ~ bernoulli(inv_logit( b_0 + x[n] * beta[ll[n]]));
  }
}
generated quantities {
  vector[L] lc50;  // posterior predictive dist of LC50
  for (l in 1:L) {
    lc50[l] = -(b_0) / beta[l];
  }
}