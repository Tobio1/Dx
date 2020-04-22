install.packages("vcd")
library(vcd)
cohen.kappa(x)

library("irr")
library("psych")
library("qwraps2")

a<- x[,1]
d<- x[,2]
df2<- as.data.frame (cbind(a,d))
cohen.kappa(df2)


