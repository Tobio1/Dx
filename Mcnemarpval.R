
install.packages("DTComPair")
library(DTComPair)
library(readxl)

# Read Data from excel file
data <- read_excel("Google Drive/13_Publications/191001_Fuji_MA/Revision5/SupportingInformation (2)/S1_Data.xlsx")
View(data)     

# Do calculation on a subset of patients
datac2 <- subset(data, COHORT=='Cohort2')

# Calculate p-values, CRS=gold standard, SILVAMPLAM=index test, LFLAM=comparator test
resc2crs <- sesp.mcnemar(tab.paired(datac2$CRS, datac2$SILVAMPLAM_FC, datac2$LFLAM_FC))
View(resc2crs)


