#P distribution function : less than or equal to 0.75
##example: tiangle base = 1, h=2
pbeta(0.75,2,1)
#Survival Function: 1- distribution function
#probability of being greater than 0.75
1 - pbeta(0.75,2,1)

#Cumultaive distribution function of the density function
#What is the probability that 40% of fewer of the calls get answered in a given day; and 50%?; and 60%?
pbeta(c(0.4,0.5,0.6),2,1)


#Quantiles
#median = quantile 50%
qbeta(0.5,2,1)
#On about 50% of the days, 70% of the calls or fewer get answered, and about
#50% of the days, 70% of the calls or more get answered. 

### Simulating averages and estimating standard error of the mean (standard deviations)

## -- Example 1: normal distribution ----------------------------------------------------
# Standard normals have variance 1; means of n;
# normals(1) have standard deviation 1^2/sqrt(n) = 1/sqrt(n) 
n <- 5
sim <- 3

# We simulate 3 means of 5 standard normals
set.seed(2340)
matrix(rnorm(sim*n), sim)
apply(matrix(rnorm(sim*n), sim),1, mean)   # 1=filas
sd(apply(matrix(rnorm(sim*n), sim),1, mean))

#check (sd): 
1/sqrt(n)
## Different result than the theoretical sd. It is because I have used few data in my simulation. 
## Let's repeat the simulatoin using more data: We simulate 1000 means of 10 standard normals.
sim <- 1000
n <- 10

matrix(rnorm(sim*n), sim)
apply(matrix(rnorm(sim*n), sim),1, mean)
hist(apply(matrix(rnorm(sim*n), sim),1, mean))
sd(apply(matrix(rnorm(sim*n), sim),1, mean))

#Check with the theoretical sd
sd = 1 /sqrt(n)
sd

# We can compare the distribution of our simulation data (large collection of averages of 10 normals)
# with the normal distribution. 

# Simulated data
sim.data <- apply(matrix(rnorm(sim*n), sim),1, mean)
hist(sim.data, breaks=n, probability = TRUE, col="lightblue", 
     xlab="means", main="Simulation")

# Normal distribution
x = seq(min(sim.data), max(sim.data), length=100)
lines(x, dnorm(x, mean = mean(sim.data), sd=1/sqrt(n)), col=2, lwd=2)

## Also, we could compare the quantiles of the simulated data with the normal distribution. 
#We can see how the distribution is approximately normal
qqnorm(sim.data)
qqline(sim.data, col=2, lwd=2)


## -- Example 2: uniform distribution ----------------------------------------------------


