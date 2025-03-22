# Bayesian Logistic Regression and LC50 Estimation

Fit logistic curves and derive LC<sub>50</sub>'s from bottle bioassay data. I'm sticking with a log-link, mostly due to the simplicity/convenience of drawing posterior predictive distributions for LC<sub>50</sub> values algebraically from the MCMC samples.  

Currently, I'm leaning on BAMBI to compile the PyMC3 model and arviz for plotting. In next steps I'll be more deliberate with a STAN file or PyMC3 file, when the need for tuning becomes obvious, but the default priors given by BAMBI are good for now. 

Future versions of this will build out a heirarchical model structure with tuned hyperpriors. The main motivation for this is the incredibly high amount of between-replicate variability observed in bioassay data for chlorfenapyr. It would be great to better understand what is going on here, and be able to characterize what noise we can't eliminate technically, at the bench. 