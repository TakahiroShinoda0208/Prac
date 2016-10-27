args <- commandArgs(trailingOnly = T)

#print(args[1])

x <- read.table(args[2])

#attach(x)
xm <- mean(x$V2)
xs <- sd(x$V2)
qnorm(0.075, mean = xm, sd = xs)
qnorm(0.100, mean = xm, sd = xs)
qnorm(0.900, mean = xm, sd = xs)
qnorm(0.925, mean = xm, sd = xs)

y <- read.table(args[1])
#attach(y)
ym <- mean(y$V6)
ys <- sd(y$V6)
#qnorm(0.025, mean = ym, sd = ys)
#qnorm(0.900, mean = ym, sd = ys)
#qnorm(0.950, mean = ym, sd = ys)